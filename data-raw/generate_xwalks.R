library(tidyverse)
devtools::load_all()

# Set parameters
tigerline_year <- 2023  # Latest TIGER/Line vintage
lehd_year <- 2019  # Latest LEHD year available, for employment data
census_year <- 2020  # Latest Decennial Census
census_vars <- c("H1_001N", "H1_002N", "P1_001N")  # HU, HH, POP vars in 2020 redistricting data
counties_il <- str_sub(c(county_fips_codes$cmap, county_fips_codes$xil), 3, 5)
counties_in <- str_sub(county_fips_codes$xin, 3, 5)
counties_wi <- str_sub(county_fips_codes$xwi, 3, 5)


# Get Census block geometries for entire modeling area
block_21co_sf <- tigris::blocks(state = "IL", county = counties_il, year = tigerline_year) %>%
  bind_rows(tigris::blocks(state = "IN", county = counties_in, year = tigerline_year)) %>%
  bind_rows(tigris::blocks(state = "WI", county = counties_wi, year = tigerline_year)) %>%
  filter(TRACTCE20 != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_block = GEOID20) %>%
  mutate(county_fips = paste0(STATEFP20, COUNTYFP20),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_block, county_fips, sqmi) %>%
  arrange(geoid_block)

# Get population, households and housing units for modeling area Census blocks
block_data <- tidycensus::get_decennial(
  "block", census_vars, year = census_year, sumfile = "pl", output = "wide",
  state = "IL", county = counties_il
) %>%
  bind_rows(tidycensus::get_decennial(
    "block", census_vars, year = census_year, sumfile = "pl", output = "wide",
    state = "IN", county = counties_in
  )) %>%
  bind_rows(tidycensus::get_decennial(
    "block", census_vars, year = census_year, sumfile = "pl", output = "wide",
    state = "WI", county = counties_wi
  )) %>%
  select(-NAME) %>%
  rename(
    geoid_block = GEOID,
    hu = H1_001N,
    hh = H1_002N,
    pop = P1_001N
  )

# Get LEHD block-level employment data (2019 LEHD USES 2010 BLOCKS)
lehd_data <- lehdr::grab_lodes(
  state = c("IL", "IN", "WI"), year = lehd_year, lodes_type = "wac",
  job_type = "JT00", segment = "S000", state_part = "main"
) %>%
  mutate(county_fips = stringr::str_sub(w_geocode, 1, 5)) %>%
  filter(county_fips %in% unlist(county_fips_codes[c("cmap", "xil", "xin", "xwi")])) %>%
  select(w_geocode, emp = C000)


### PROCESS LEHD EMPLOYMENT DATA USING 2010 CENSUS BLOCKS
### Note: this section is only needed until LEHD switches to use the 2020
# blocks. This is still needed as of December 15, 2023. As of the 2019 LEHD, it
# still uses the 2010 blocks. Once it switches, remove this section and the LEHD
# data will be joined to block_data directly.

# Get 2010 Census block geometries for entire modeling area
block2010_21co_sf <- tigris::blocks(state = "IL", county = counties_il, year = 2019) %>%
  bind_rows(tigris::blocks(state = "IN", county = counties_in, year = 2019)) %>%
  bind_rows(tigris::blocks(state = "WI", county = counties_wi, year = 2019)) %>%
  filter(TRACTCE10 != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(w_geocode = GEOID10) %>%
  select(w_geocode) %>%
  arrange(w_geocode)

# Convert 2010 blocks to centroids and spatially join to 2020 block polygons
sf::st_geometry(block2010_21co_sf) <- sf::st_point_on_surface(sf::st_geometry(block2010_21co_sf))
block10_block20_assign <- block2010_21co_sf %>%
  mutate(geoid_block = block_21co_sf$geoid_block[sf::st_nearest_feature(., block_21co_sf)]) %>%
  as_tibble() %>%
  select(w_geocode, geoid_block)

# Summarize LEHD data by 2020 block
lehd_data <- lehd_data %>%
  left_join(block10_block20_assign) %>%
  group_by(geoid_block) %>%
  summarize(emp = sum(emp))

### END LEHD 2010 BLOCK PROCESSING ###


block_data <- block_data %>%
  left_join(lehd_data) %>%  # Specify `by=c("geoid_block"="w_geocode")` when joining LEHD directly
  mutate(emp = if_else(is.na(emp), 0, emp)) %>%
  filter(pop > 0 | hh > 0 | hu > 0 | emp > 0) %>%
  mutate(
    geoid_blkgrp = str_sub(geoid_block, 1, 12),
    geoid_tract = str_sub(geoid_block, 1, 11),
    geoid_county = str_sub(geoid_block, 1, 5)
  ) %>%
  inner_join(select(as.data.frame(block_21co_sf), geoid_block, sqmi))

# Sum to block group and tract
blockgroup_data <- block_data %>%
  group_by(geoid_blkgrp) %>%
  summarize(
    hu_blkgrp = sum(hu),
    hh_blkgrp = sum(hh),
    pop_blkgrp = sum(pop),
    emp_blkgrp = sum(emp),
    sqmi_blkgrp = sum(sqmi),
    .groups = "drop"
  )

tract_data <- block_data %>%
  group_by(geoid_tract) %>%
  summarize(
    hu_tract = sum(hu),
    hh_tract = sum(hh),
    pop_tract = sum(pop),
    emp_tract = sum(emp),
    sqmi_tract = sum(sqmi),
    .groups = "drop"
  )

# Calculate block shares of block group and tract data.
# Use area weighting for unpopulated block groups or tracts.
block_pct <- block_data %>%
  left_join(blockgroup_data) %>%
  mutate(
    hu_pct_blkgrp = if_else(hu_blkgrp > 0, hu/hu_blkgrp, sqmi/sqmi_blkgrp),
    hh_pct_blkgrp = if_else(hh_blkgrp > 0, hh/hh_blkgrp, sqmi/sqmi_blkgrp),
    pop_pct_blkgrp = if_else(pop_blkgrp > 0, pop/pop_blkgrp, sqmi/sqmi_blkgrp),
    emp_pct_blkgrp = if_else(emp_blkgrp > 0, emp/emp_blkgrp, sqmi/sqmi_blkgrp)
  ) %>%
  left_join(tract_data) %>%
  mutate(
    hu_pct_tract = if_else(hu_tract > 0, hu/hu_tract, sqmi/sqmi_tract),
    hh_pct_tract = if_else(hh_tract > 0, hh/hh_tract, sqmi/sqmi_tract),
    pop_pct_tract = if_else(pop_tract > 0, pop/pop_tract, sqmi/sqmi_tract),
    emp_pct_tract = if_else(emp_tract > 0, emp/emp_tract, sqmi/sqmi_tract)
  ) %>%
  select(geoid_block, hu, hh, pop, emp,
         geoid_blkgrp, ends_with("pct_blkgrp"),
         geoid_tract, ends_with("pct_tract"))

# Create block centroids (for blocks with HU/HH/pop/emp only)
block_pt_sf <- block_21co_sf %>%
  select(geoid_block) %>%
  semi_join(block_data)
sf::st_geometry(block_pt_sf) <- sf::st_point_on_surface(sf::st_geometry(block_pt_sf))

# Intersect block centroids with CCA geoms
chi_census_sf <- municipality_sf %>%
  select(municipality) %>%
  filter(municipality == "Chicago")

block_cca_assign <- block_pt_sf %>%
  filter(apply(sf::st_intersects(., chi_census_sf), 1, any)) %>%
  mutate(cca_num = cca_sf$cca_num[sf::st_nearest_feature(., cca_sf)]) %>%
  as_tibble() %>%
  select(geoid_block, cca_num) %>%

  ### MAKE MANUAL ADJUSTMENTS TO BLOCK-CCA ASSIGNMENT HERE: ###
  mutate(cca_num = as.integer(case_when(
    geoid_block == "170312301001004" ~ 23,  # Centroid in 22
    geoid_block == "170315206001056" ~ 55,  # Centroid in 52
    geoid_block == "170315206001057" ~ 55,  # Centroid in 52
    geoid_block == "170317304002017" ~ 73,  # Centroid in 72
    geoid_block == "170319801001004" ~ 56,  # Centroid in 64
    TRUE ~ as.numeric(cca_num)  # Leave everything else alone
  ))) %>%
  filter(!is.na(cca_num))

# Intersect block centroids with subzone geoms
model_area_sf <- rmapshaper::ms_dissolve(subzone_sf)

block_subzone_assign <- block_pt_sf %>%
  filter(apply(sf::st_intersects(., sf::st_buffer(model_area_sf, 100)), 1, any)) %>%

  ### MANUALLY RE-ADD IN-REGION BLOCKS WHOSE CENTROIDS ARE OUTSIDE: ###
  bind_rows(filter(block_pt_sf, geoid_block %in% c("170978622003054"))) %>%

  mutate(subzone17 = subzone_sf$subzone17[sf::st_nearest_feature(., subzone_sf)]) %>%
  as_tibble() %>%
  select(geoid_block, subzone17) %>%

  ### MAKE MANUAL ADJUSTMENTS TO BLOCK-SUBZONE ASSIGNMENT HERE: ###
  mutate(subzone17 = as.integer(case_when(
    geoid_block == "170318300012001" ~ 1100,  # Centroid in subzone from wrong county
    geoid_block == "170370018001079" ~ 16598,  # Centroid in subzone from wrong county
    geoid_block == "170978622003054" ~ 10096,  # Centroid on breakwater in Lake Michigan
    geoid_block == "171118708122011" ~ 11831,  # Centroid in subzone from wrong county
    geoid_block == "171118708123021" ~ 11845,  # Centroid in subzone from wrong county
    geoid_block == "171118708123029" ~ 11843,  # Centroid in subzone from wrong county
    geoid_block == "171118713053000" ~ 11175,  # Centroid in subzone from wrong county
    geoid_block == "181270510111015" ~ 17204,  # Centroid in subzone from wrong county
    geoid_block == "551010027021035" ~ 17304,  # Centroid in subzone from wrong county
    geoid_block == "551270010003065" ~ 17392,  # Centroid in subzone from wrong county
    TRUE ~ as.numeric(subzone17)  # Leave everything else alone
  )))

# Infer zone assignments from subzone assignments
block_zone_assign <- block_subzone_assign %>%
  left_join(subzone_sf) %>%
  select(geoid_block, zone17)


# Create the xwalks
xwalk_blockgroup2cca <- block_pct %>%
  select(geoid_block, geoid_blkgrp, ends_with("pct_blkgrp")) %>%
  inner_join(block_cca_assign) %>%
  group_by(geoid_blkgrp, cca_num) %>%
  summarize(
    hu_pct = sum(hu_pct_blkgrp),
    hh_pct = sum(hh_pct_blkgrp),
    pop_pct = sum(pop_pct_blkgrp),
    emp_pct = sum(emp_pct_blkgrp),
    .groups = "drop"
  )
summary(xwalk_blockgroup2cca)

xwalk_tract2cca <- block_pct %>%
  select(geoid_block, geoid_tract, ends_with("pct_tract")) %>%
  inner_join(block_cca_assign) %>%
  group_by(geoid_tract, cca_num) %>%
  summarize(
    hu_pct = sum(hu_pct_tract),
    hh_pct = sum(hh_pct_tract),
    pop_pct = sum(pop_pct_tract),
    emp_pct = sum(emp_pct_tract),
    .groups = "drop"
  )
summary(xwalk_tract2cca)

xwalk_blockgroup2subzone <- block_pct %>%
  select(geoid_block, geoid_blkgrp, ends_with("pct_blkgrp")) %>%
  inner_join(block_subzone_assign) %>%
  group_by(geoid_blkgrp, subzone17) %>%
  summarize(
    hu_pct = sum(hu_pct_blkgrp),
    hh_pct = sum(hh_pct_blkgrp),
    pop_pct = sum(pop_pct_blkgrp),
    emp_pct = sum(emp_pct_blkgrp),
    .groups = "drop"
  )
summary(xwalk_blockgroup2subzone)

xwalk_tract2subzone <- block_pct %>%
  select(geoid_block, geoid_tract, ends_with("pct_tract")) %>%
  inner_join(block_subzone_assign) %>%
  group_by(geoid_tract, subzone17) %>%
  summarize(
    hu_pct = sum(hu_pct_tract),
    hh_pct = sum(hh_pct_tract),
    pop_pct = sum(pop_pct_tract),
    emp_pct = sum(emp_pct_tract),
    .groups = "drop"
  )
summary(xwalk_tract2subzone)

xwalk_blockgroup2zone <- block_pct %>%
  select(geoid_block, geoid_blkgrp, ends_with("pct_blkgrp")) %>%
  inner_join(block_zone_assign) %>%
  group_by(geoid_blkgrp, zone17) %>%
  summarize(
    hu_pct = sum(hu_pct_blkgrp),
    hh_pct = sum(hh_pct_blkgrp),
    pop_pct = sum(pop_pct_blkgrp),
    emp_pct = sum(emp_pct_blkgrp),
    .groups = "drop"
  )
summary(xwalk_blockgroup2zone)

xwalk_tract2zone <- block_pct %>%
  select(geoid_block, geoid_tract, ends_with("pct_tract")) %>%
  inner_join(block_zone_assign) %>%
  group_by(geoid_tract, zone17) %>%
  summarize(
    hu_pct = sum(hu_pct_tract),
    hh_pct = sum(hh_pct_tract),
    pop_pct = sum(pop_pct_tract),
    emp_pct = sum(emp_pct_tract),
    .groups = "drop"
  )
summary(xwalk_tract2zone)

# Save processed data to package's data dir
usethis::use_data(xwalk_blockgroup2cca, overwrite = TRUE)
usethis::use_data(xwalk_blockgroup2subzone, overwrite = TRUE)
usethis::use_data(xwalk_blockgroup2zone, overwrite = TRUE)
usethis::use_data(xwalk_tract2cca, overwrite = TRUE)
usethis::use_data(xwalk_tract2subzone, overwrite = TRUE)
usethis::use_data(xwalk_tract2zone, overwrite = TRUE)


## QC TO IDENTIFY ANY NECESSARY MANUAL ADJUSTMENTS
library(tmap)  # Load tmap for interactive mapping
tmap_mode("view")

# Map tracts that straddle 2+ CCAs (and their component blocks/centroids)
multi_cca_tracts <- xwalk_tract2cca %>%
  group_by(geoid_tract) %>%
  summarize(n = n()) %>%
  filter(n > 1)
block_21co_sf %>%
  inner_join(block_data, by="geoid_block") %>%
  filter(substr(geoid_block, 1, 11) %in% multi_cca_tracts$geoid_tract) %>%
  left_join(block_cca_assign) %>%
  mutate(cca_num = as_factor(cca_num)) %>%
  tm_shape(.) +
    tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu", "emp")) +
  tm_shape(chi_census_sf) +
    tm_borders(col="blue", lwd=4, alpha=0.5) +
  tm_shape(cca_sf) +
    tm_borders(col="red", lwd=4, alpha=0.5) +
  tm_shape(filter(tract_sf, geoid_tract %in% multi_cca_tracts$geoid_tract)) +
    tm_borders(lwd=2, col="black") +
  tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 11) %in% multi_cca_tracts$geoid_tract)) +
    tm_dots()

# Map tracts that are only partially in Chicago
chi_partial_tracts <- xwalk_tract2cca %>%
  group_by(geoid_tract) %>%
  summarize_at(vars(hu_pct, hh_pct, pop_pct), sum) %>%
  filter(hu_pct < 0.99999 | hh_pct < 0.99999 | pop_pct < 0.99999)
block_21co_sf %>%
  inner_join(block_data, by="geoid_block") %>%
  filter(substr(geoid_block, 1, 11) %in% chi_partial_tracts$geoid_tract) %>%
  left_join(block_cca_assign) %>%
  mutate(cca_num = as_factor(cca_num)) %>%
  tm_shape(.) +
    tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu", "emp")) +
  tm_shape(chi_census_sf) +
    tm_borders(col="blue", lwd=4, alpha=0.5) +
  tm_shape(cca_sf) +
    tm_borders(col="red", lwd=4, alpha=0.5) +
  tm_shape(filter(tract_sf, geoid_tract %in% chi_partial_tracts$geoid_tract)) +
    tm_borders(lwd=2, col="black") +
  tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 11) %in% chi_partial_tracts$geoid_tract)) +
    tm_dots()

# Map block groups that straddle 2+ CCAs (and their component blocks/centroids)
multi_cca_blkgrps <- xwalk_blockgroup2cca %>%
  group_by(geoid_blkgrp) %>%
  summarize(n = n()) %>%
  filter(n > 1)
block_21co_sf %>%
  inner_join(block_data, by="geoid_block") %>%
  filter(substr(geoid_block, 1, 12) %in% multi_cca_blkgrps$geoid_blkgrp) %>%
  left_join(block_cca_assign) %>%
  mutate(cca_num = as_factor(cca_num)) %>%
  tm_shape(.) +
    tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu", "emp")) +
  tm_shape(chi_census_sf) +
    tm_borders(col="blue", lwd=4, alpha=0.5) +
  tm_shape(cca_sf) +
    tm_borders(col="red", lwd=4, alpha=0.5) +
  tm_shape(filter(blockgroup_sf, geoid_blkgrp %in% multi_cca_blkgrps$geoid_blkgrp)) +
    tm_borders(lwd=2, col="black") +
  tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 12) %in% multi_cca_blkgrps$geoid_blkgrp)) +
    tm_dots()

# Map block groups that are only partially in Chicago
chi_partial_blkgrps <- xwalk_blockgroup2cca %>%
  group_by(geoid_blkgrp) %>%
  summarize_at(vars(hu_pct, hh_pct, pop_pct), sum) %>%
  filter(hu_pct < 0.99999 | hh_pct < 0.99999 | pop_pct < 0.99999)
block_21co_sf %>%
  inner_join(block_data, by="geoid_block") %>%
  filter(substr(geoid_block, 1, 12) %in% chi_partial_blkgrps$geoid_blkgrp) %>%
  left_join(block_cca_assign) %>%
  mutate(cca_num = as_factor(cca_num)) %>%
  tm_shape(.) +
    tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu", "emp")) +
  tm_shape(chi_census_sf) +
    tm_borders(col="blue", lwd=4, alpha=0.5) +
  tm_shape(cca_sf) +
    tm_borders(col="red", lwd=4, alpha=0.5) +
  tm_shape(filter(blockgroup_sf, geoid_blkgrp %in% chi_partial_blkgrps$geoid_blkgrp)) +
    tm_borders(lwd=2, col="black") +
  tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 12) %in% chi_partial_blkgrps$geoid_blkgrp)) +
    tm_dots()

# Map blocks that were assigned to subzones but centroid is outside model area
fringe_block_sf <- block_21co_sf %>%
  inner_join(block_subzone_assign) %>%
  filter(!apply(sf::st_intersects(sf::st_point_on_surface(sf::st_geometry(.)), model_area_sf), 1, any))
ggplot(fringe_block_sf) +
  geom_sf(color="red", lwd=1) +
  geom_sf(data=inner_join(block_pt_sf, as.data.frame(fringe_block_sf), by = "geoid_block"))

# Map subzones with no HU/HH/pop/emp assigned to them
subzone_sf %>%
  anti_join(block_subzone_assign) %>%
  tm_shape() +
    tm_polygons(col="red", alpha=0.3)

# Map zones with no HU/HH/pop/emp assigned to them
zone_sf %>%
  anti_join(block_zone_assign) %>%
  tm_shape() +
    tm_polygons(col="red", alpha=0.3)

# Map blocks in one county assigned to subzone/zone in another county
subzone_county <- subzone_sf %>%
  as.data.frame() %>%
  select(subzone17, county_fips)
block_bad_county <- block_21co_sf %>%
  left_join(block_subzone_assign, by = "geoid_block") %>%
  left_join(subzone_county, by = "subzone17", suffix = c("_block", "_subzone")) %>%
  filter(!is.na(county_fips_subzone), county_fips_block != county_fips_subzone)
tm_shape(subzone_sf) +
  tm_polygons(id = "subzone17", col = "county_fips", border.col = "white", alpha = 0.5) +
tm_shape(block_bad_county) +
  tm_polygons(col = "red", border.col = "maroon", alpha = 0.3) +
tm_shape(filter(block_pt_sf, geoid_block %in% block_bad_county$geoid_block)) +
  tm_dots()

# Map tracts that are only partially in modeling area
model_partial_tracts <- xwalk_tract2subzone %>%
  group_by(geoid_tract) %>%
  summarize_at(vars(hu_pct, hh_pct, pop_pct, emp_pct), sum) %>%
  filter(hu_pct < 0.99999 | hh_pct < 0.99999 | pop_pct < 0.99999 | emp_pct < 0.99999)
block_21co_sf %>%
  inner_join(block_data, by="geoid_block") %>%
  filter(substr(geoid_block, 1, 11) %in% model_partial_tracts$geoid_tract) %>%
  left_join(block_subzone_assign) %>%
  tm_shape(.) +
    tm_polygons(col="geoid_tract", alpha=0.5, popup.vars=c("geoid_block", "geoid_tract", "subzone17", "pop", "hh", "hu", "emp")) +
  tm_shape(model_area_sf) +
    tm_borders(col="red", lwd=4, alpha=0.5) +
  tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 11) %in% model_partial_tracts$geoid_tract)) +
    tm_dots()

# Map block groups that are only partially in modeling area
model_partial_blkgrps <- xwalk_blockgroup2subzone %>%
  group_by(geoid_blkgrp) %>%
  summarize_at(vars(hu_pct, hh_pct, pop_pct, emp_pct), sum) %>%
  filter(hu_pct < 0.99999 | hh_pct < 0.99999 | pop_pct < 0.99999 | emp_pct < 0.99999)
block_21co_sf %>%
  inner_join(block_data, by="geoid_block") %>%
  filter(substr(geoid_block, 1, 12) %in% model_partial_blkgrps$geoid_blkgrp) %>%
  left_join(block_subzone_assign) %>%
  tm_shape(.) +
    tm_polygons(col="geoid_blkgrp", alpha=0.5, popup.vars=c("geoid_block", "geoid_blkgrp", "subzone17", "pop", "hh", "hu", "emp")) +
  tm_shape(model_area_sf) +
    tm_borders(col="red", lwd=4, alpha=0.5) +
  tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 12) %in% model_partial_blkgrps$geoid_blkgrp)) +
    tm_dots()

# Check CCA sums against Census' Chicago total
chi_data <- tidycensus::get_decennial(
  "place", census_vars, year = census_year, sumfile = "pl", output = "wide",
  state = "IL"
) %>%
  filter(NAME == "Chicago city, Illinois") %>%
  rename(
    hu = H1_001N,
    hh = H1_002N,
    pop = P1_001N
  )
block_cca_sums <- block_data %>%
  semi_join(block_cca_assign) %>%
  select(hu, hh, pop) %>%
  summarize_all(sum)
block_cca_sums$hu - chi_data$hu  # Should return 0
block_cca_sums$hh - chi_data$hh  # Should return 0
block_cca_sums$pop - chi_data$pop  # Should return 0
