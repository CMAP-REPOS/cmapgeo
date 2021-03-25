library(tidyverse)
library(devtools)
load_all()

# Set common parameters
STATE <- "17"  # Illinois
COUNTIES_7CO <- c("031", "043", "089", "093", "097", "111", "197")  # CMAP 7
COUNTIES_MPO <- c(COUNTIES_7CO, "063", "037")  # CMAP 7, plus Grundy and DeKalb

# Get CMAP counties for spatial filtering (not saved) -- includes Lake Michigan
temp_cmap_sf <- tigris::counties(state = STATE) %>%
  filter(COUNTYFP %in% COUNTIES_7CO) %>%
  sf::st_transform(cmap_crs) %>%
  select(GEOID)

# Get Lake Michigan tracts for erasing
temp_lakemich_sf <- tigris::tracts(state = STATE, county = c("031", "097")) %>%
  filter(TRACTCE == "990000") %>%
  sf::st_transform(cmap_crs) %>%
  rmapshaper::ms_dissolve()

# Define helper function to determine overlaps with CMAP counties
intersects_cmap <- function(in_sf) {
  apply(sf::st_overlaps(in_sf, temp_cmap_sf, sparse = FALSE), 1, any) |
    apply(sf::st_covers(in_sf, temp_cmap_sf, sparse = FALSE), 1, any) |
    apply(sf::st_covered_by(in_sf, temp_cmap_sf, sparse = FALSE), 1, any)
}

# Process Census county subdivisions (a.k.a. political townships)
township_sf <- tigris::county_subdivisions(state = STATE, county = COUNTIES_MPO) %>%
  filter(COUSUBFP != "00000",  # Exclude Lake Michigan "townships"
         COUNTYFP %in% COUNTIES_7CO | NAME %in% c("Aux Sable", "Sandwich", "Somonauk")) %>%
  sf::st_transform(cmap_crs) %>%
  rename(geoid_cousub = GEOID,
         township = NAME) %>%
  mutate(county_fips = paste0(STATEFP, COUNTYFP),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_cousub, township, county_fips, sqmi) %>%
  arrange(geoid_cousub)

# Process Census places (a.k.a. municipalities)
municipality_sf <- tigris::places(state = STATE) %>%
  filter(!str_detect(NAMELSAD, " CDP")) %>%  # Incorporated places only
  sf::st_transform(cmap_crs) %>%
  filter(intersects_cmap(.)) %>%  # Restrict to CMAP region
  rename(geoid_place = GEOID,
         municipality = NAME) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_place, municipality, sqmi) %>%
  arrange(geoid_place)

# Process Census tracts
tract_sf <- tigris::tracts(state = STATE, county = COUNTIES_7CO) %>%
  filter(TRACTCE != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_tract = GEOID) %>%
  mutate(county_fips = paste0(STATEFP, COUNTYFP),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_tract, county_fips, sqmi) %>%
  arrange(geoid_tract)

# Process Census block groups
blockgroup_sf <- tigris::block_groups(state = STATE, county = COUNTIES_7CO) %>%
  filter(TRACTCE != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_blkgrp = GEOID) %>%
  mutate(county_fips = paste0(STATEFP, COUNTYFP),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_blkgrp, county_fips, sqmi) %>%
  arrange(geoid_blkgrp)

# Process Census blocks
block_sf <- tigris::blocks(state = STATE, county = COUNTIES_7CO) %>%
  filter(TRACTCE10 != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_block = GEOID10) %>%
  mutate(county_fips = paste0(STATEFP10, COUNTYFP10),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_block, county_fips, sqmi) %>%
  arrange(geoid_block)

# Process Census PUMAs
puma_sf <- tigris::pumas(state = STATE) %>%
  sf::st_transform(cmap_crs) %>%
  filter(intersects_cmap(.)) %>%  # Restrict to CMAP region
  rmapshaper::ms_erase(temp_lakemich_sf) %>%  # Erase Lake Michigan
  rename(geoid_puma = GEOID10,
         name = NAMELSAD10) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_puma, name, sqmi) %>%
  arrange(geoid_puma) %>%
  ## Manually exclude one PUMA, which appears to mistakenly include a *tiny* block in McHenry
  filter(geoid_puma != "1702901")

# Process Congressional Districts (U.S. House of Representatives)
congress_sf <- tigris::congressional_districts() %>%
  filter(STATEFP == STATE, LSAD == "C2") %>%
  sf::st_transform(cmap_crs) %>%
  mutate(dist_num = as.integer(CD116FP),
         dist_name = paste0("IL-", dist_num),
         dist_name_long = paste("Illinois",
                                nombre::nom_ord(dist_num, max_n = 0),
                                "Congressional District"),
         cmap = intersects_cmap(.),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(dist_num, dist_name, dist_name_long, cmap, sqmi) %>%
  arrange(dist_num)

# Process IL House Districts
ilga_house_sf <- tigris::state_legislative_districts(state = STATE, house = "lower") %>%
  filter(LSAD == "LL") %>%
  sf::st_transform(cmap_crs) %>%
  rename(dist_name = NAMELSAD) %>%
  mutate(dist_num = as.integer(SLDLST),
         cmap = intersects_cmap(.),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(dist_num, dist_name, cmap, sqmi) %>%
  arrange(dist_num)

# Process IL Senate Districts
ilga_senate_sf <- tigris::state_legislative_districts(state = STATE, house = "upper") %>%
  filter(LSAD == "LU") %>%
  sf::st_transform(cmap_crs) %>%
  rename(dist_name = NAMELSAD) %>%
  mutate(dist_num = as.integer(SLDUST),
         cmap = intersects_cmap(.),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(dist_num, dist_name, cmap, sqmi) %>%
  arrange(dist_num)

# Save processed data to package's data dir
usethis::use_data(township_sf, overwrite = TRUE)
usethis::use_data(municipality_sf, overwrite = TRUE)
usethis::use_data(tract_sf, overwrite = TRUE)
usethis::use_data(blockgroup_sf, overwrite = TRUE)
usethis::use_data(block_sf, overwrite = TRUE)
usethis::use_data(puma_sf, overwrite = TRUE)
usethis::use_data(congress_sf, overwrite = TRUE)
usethis::use_data(ilga_house_sf, overwrite = TRUE)
usethis::use_data(ilga_senate_sf, overwrite = TRUE)
