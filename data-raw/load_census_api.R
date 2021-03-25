library(tidyverse)
library(devtools)
load_all()

# Set common parameters
STATE <- "17"  # Illinois
COUNTIES_7CO <- c("031", "043", "089", "093", "097", "111", "197")  # CMAP 7
COUNTIES_MPO <- c(COUNTIES_7CO, "063", "037")  # CMAP 7, plus Grundy and DeKalb

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
  filter(apply(sf::st_intersects(., township_sf, sparse = FALSE), 1, any)) %>%  # In CMAP MPO only
  filter(NAME != "Somonauk") %>%  # Exclude Somonauk (doesn't touch 7 counties)
  rename(geoid_place = GEOID,
         municipality = NAME) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_place, municipality, sqmi) %>%
  arrange(geoid_place)

## Process Census tracts
tract_sf <- tigris::tracts(state = STATE, county = COUNTIES_7CO) %>%
  filter(TRACTCE != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_tract = GEOID) %>%
  mutate(county_fips = paste0(STATEFP, COUNTYFP),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_tract, county_fips, sqmi) %>%
  arrange(geoid_tract)

## Process Census block groups
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

# Save processed data to package's data dir
usethis::use_data(township_sf, overwrite = TRUE)
usethis::use_data(municipality_sf, overwrite = TRUE)
usethis::use_data(tract_sf, overwrite = TRUE)
usethis::use_data(blockgroup_sf, overwrite = TRUE)
usethis::use_data(block_sf, overwrite = TRUE)
