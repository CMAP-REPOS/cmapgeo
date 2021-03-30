library(tidyverse)
devtools::load_all()

# Set parameters
census_year <- 2010  # Latest Decennial Census
census_vars <- c("H003001", "H003002", "P001001")  # HU, HH, POP
counties <- block_sf$county_fips %>%
  unique() %>%
  str_sub(3, 5)

# Get population, households and housing units for Census blocks
block_data <- tidycensus::get_decennial(
  "block", census_vars, year = census_year, sumfile = "sf1", state = "IL",
  county = counties, output = "wide"
) %>%
  select(-NAME) %>%
  rename(
    geoid_block = GEOID,
    hu = H003001,
    hh = H003002,
    pop = P001001
  ) %>%
  filter(pop > 0 | hh > 0 | hu > 0) %>%
  mutate(
    geoid_blkgrp = str_sub(geoid_block, 1, 12),
    geoid_tract = str_sub(geoid_block, 1, 11)
  ) %>%
  inner_join(select(as.data.frame(block_sf), geoid_block, sqmi))

# Sum to block group and tract
blockgroup_data <- block_data %>%
  group_by(geoid_blkgrp) %>%
  summarize(
    hu_blkgrp = sum(hu),
    hh_blkgrp = sum(hh),
    pop_blkgrp = sum(pop),
    sqmi_blkgrp = sum(sqmi),
    .groups = "drop"
  )

tract_data <- block_data %>%
  group_by(geoid_tract) %>%
  summarize(
    hu_tract = sum(hu),
    hh_tract = sum(hh),
    pop_tract = sum(pop),
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
    pop_pct_blkgrp = if_else(pop_blkgrp > 0, pop/pop_blkgrp, sqmi/sqmi_blkgrp)
  ) %>%
  left_join(tract_data) %>%
  mutate(
    hu_pct_tract = if_else(hu_tract > 0, hu/hu_tract, sqmi/sqmi_tract),
    hh_pct_tract = if_else(hh_tract > 0, hh/hh_tract, sqmi/sqmi_tract),
    pop_pct_tract = if_else(pop_tract > 0, pop/pop_tract, sqmi/sqmi_tract)
  ) %>%
  select(geoid_block, hu, hh, pop,
         geoid_blkgrp, ends_with("pct_blkgrp"),
         geoid_tract, ends_with("pct_tract"))

# Create block centroids
block_pt_sf <- block_sf %>%
  select(geoid_block) %>%
  semi_join(block_data)
sf::st_geometry(block_pt_sf) <- sf::st_point_on_surface(sf::st_geometry(block_pt_sf))

# Intersect block centroids with xwalk "to" geoms
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
    geoid_block == "170312705001009" ~ 27,  # Centroid in 26
    geoid_block == "170315206001058" ~ 55,  # Centroid in 52
    geoid_block == "170315206001059" ~ 55,  # Centroid in 52
    geoid_block == "170317112004057" ~ 71,  # Centroid in 70
    geoid_block == "170317304002008" ~ 73,  # Centroid in 72
    geoid_block == "170317706023016" ~ NA_real_,  # Centroid in chi_census_sf, but not cca_sf
    TRUE ~ as.numeric(cca_num)  # Leave everything else alone
  ))) %>%
  filter(!is.na(cca_num))

# Create the xwalks
xwalk_tract2cca <- block_pct %>%
  select(geoid_block, geoid_tract, ends_with("pct_tract")) %>%
  inner_join(block_cca_assign) %>%
  group_by(geoid_tract, cca_num) %>%
  summarize(
    hu_pct = sum(hu_pct_tract),
    hh_pct = sum(hh_pct_tract),
    pop_pct = sum(pop_pct_tract),
    .groups = "drop"
  )

xwalk_blockgroup2cca <- block_pct %>%
  select(geoid_block, geoid_blkgrp, ends_with("pct_blkgrp")) %>%
  inner_join(block_cca_assign) %>%
  group_by(geoid_blkgrp, cca_num) %>%
  summarize(
    hu_pct = sum(hu_pct_blkgrp),
    hh_pct = sum(hh_pct_blkgrp),
    pop_pct = sum(pop_pct_blkgrp),
    .groups = "drop"
  )

# Save processed data to package's data dir
usethis::use_data(xwalk_tract2cca, overwrite = TRUE)
usethis::use_data(xwalk_blockgroup2cca, overwrite = TRUE)


# ## QC TO IDENTIFY NECESSARY MANUAL ADJUSTMENTS
# library(tmap)  # Load tmap for interactive mapping
# tmap_mode("view")
#
# # Map tracts that straddle 2+ CCAs (and their component blocks/centroids)
# multi_cca_tracts <- xwalk_tract2cca %>%
#   group_by(geoid_tract) %>%
#   summarize(n = n()) %>%
#   filter(n > 1)
# block_sf %>%
#   inner_join(block_data, by="geoid_block") %>%
#   filter(substr(geoid_block, 1, 11) %in% multi_cca_tracts$geoid_tract) %>%
#   left_join(block_cca_assign) %>%
#   mutate(cca_num = as_factor(cca_num)) %>%
#   tm_shape(.) +
#     tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu")) +
#   tm_shape(cca_sf) +
#     tm_borders(col="red", lwd=4, alpha=0.5) +
#   tm_shape(filter(tract_sf, geoid_tract %in% multi_cca_tracts$geoid_tract)) +
#     tm_borders(lwd=2, col="black") +
#   tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 11) %in% multi_cca_tracts$geoid_tract)) +
#     tm_dots()
#
# # Map tracts that are only partially in Chicago
# chi_partial_tracts <- xwalk_tract2cca %>%
#   group_by(geoid_tract) %>%
#   summarize_at(vars(hu_pct, hh_pct, pop_pct), sum) %>%
#   filter(hu_pct < 0.99999 | hh_pct < 0.99999 | pop_pct < 0.99999)
# block_sf %>%
#   inner_join(block_data, by="geoid_block") %>%
#   filter(substr(geoid_block, 1, 11) %in% chi_partial_tracts$geoid_tract) %>%
#   left_join(block_cca_assign) %>%
#   mutate(cca_num = as_factor(cca_num)) %>%
#   tm_shape(.) +
#     tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu")) +
#   tm_shape(cca_sf) +
#     tm_borders(col="red", lwd=4, alpha=0.5) +
#   tm_shape(filter(tract_sf, geoid_tract %in% chi_partial_tracts$geoid_tract)) +
#     tm_borders(lwd=2, col="black") +
#   tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 11) %in% chi_partial_tracts$geoid_tract)) +
#     tm_dots()
#
# # Map block groups that straddle 2+ CCAs (and their component blocks/centroids)
# multi_cca_blkgrps <- xwalk_blockgroup2cca %>%
#   group_by(geoid_blkgrp) %>%
#   summarize(n = n()) %>%
#   filter(n > 1)
# block_sf %>%
#   inner_join(block_data, by="geoid_block") %>%
#   filter(substr(geoid_block, 1, 12) %in% multi_cca_blkgrps$geoid_blkgrp) %>%
#   left_join(block_cca_assign) %>%
#   mutate(cca_num = as_factor(cca_num)) %>%
#   tm_shape(.) +
#     tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu")) +
#   tm_shape(cca_sf) +
#     tm_borders(col="red", lwd=4, alpha=0.5) +
#   tm_shape(filter(blockgroup_sf, geoid_blkgrp %in% multi_cca_blkgrps$geoid_blkgrp)) +
#     tm_borders(lwd=2, col="black") +
#   tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 12) %in% multi_cca_blkgrps$geoid_blkgrp)) +
#     tm_dots()
#
# # Map block groups that are only partially in Chicago
# chi_partial_blkgrps <- xwalk_blockgroup2cca %>%
#   group_by(geoid_blkgrp) %>%
#   summarize_at(vars(hu_pct, hh_pct, pop_pct), sum) %>%
#   filter(hu_pct < 0.99999 | hh_pct < 0.99999 | pop_pct < 0.99999)
# block_sf %>%
#   inner_join(block_data, by="geoid_block") %>%
#   filter(substr(geoid_block, 1, 12) %in% chi_partial_blkgrps$geoid_blkgrp) %>%
#   left_join(block_cca_assign) %>%
#   mutate(cca_num = as_factor(cca_num)) %>%
#   tm_shape(.) +
#     tm_polygons(col="cca_num", alpha=0.5, popup.vars=c("geoid_block", "cca_num", "pop", "hh", "hu")) +
#   tm_shape(cca_sf) +
#     tm_borders(col="red", lwd=4, alpha=0.5) +
#   tm_shape(filter(blockgroup_sf, geoid_blkgrp %in% chi_partial_blkgrps$geoid_blkgrp)) +
#     tm_borders(lwd=2, col="black") +
#   tm_shape(filter(block_pt_sf, substr(geoid_block, 1, 12) %in% chi_partial_blkgrps$geoid_blkgrp)) +
#     tm_dots()
