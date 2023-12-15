library(tidyverse)
devtools::load_all()

# Set common parameters
BASE_YEAR <- 2023  # TIGER/Line vintage to use by default
STATE <- "17"  # Illinois
COUNTIES_7CO <- c("031", "043", "089", "093", "097", "111", "197")  # CMAP 7
COUNTIES_MPO <- c(COUNTIES_7CO, "063", "037")  # CMAP 7, plus Grundy and DeKalb

# Get CMAP counties for spatial filtering (not saved) -- includes Lake Michigan
temp_cmap_sf <- tigris::counties(state = STATE, year = BASE_YEAR) %>%
  filter(COUNTYFP %in% COUNTIES_7CO) %>%
  sf::st_transform(cmap_crs) %>%
  select(GEOID)

# Get Lake Michigan tracts for erasing
temp_lakemich_sf <- tigris::tracts(state = "17", year = BASE_YEAR) %>%
  bind_rows(tigris::tracts(state = "18", year = BASE_YEAR)) %>%
  bind_rows(tigris::tracts(state = "55", year = BASE_YEAR)) %>%
  filter(TRACTCE == "990000") %>%  # Water tracts only
  sf::st_transform(cmap_crs) %>%
  rmapshaper::ms_dissolve()

# Define helper function to determine overlaps with CMAP counties
intersects_cmap <- function(in_sf) {
  apply(sf::st_overlaps(in_sf, temp_cmap_sf, sparse = FALSE), 1, any) |
    apply(sf::st_covers(in_sf, temp_cmap_sf, sparse = FALSE), 1, any) |
    apply(sf::st_covered_by(in_sf, temp_cmap_sf, sparse = FALSE), 1, any)
}

# Process Census counties
keep_counties <- unique(unlist(county_fips_codes))
state_fips <- unique(substr(keep_counties, 1, 2))
county_sf <- tigris::counties(state = state_fips, year = BASE_YEAR) %>%
  filter(GEOID %in% keep_counties) %>%
  sf::st_transform(cmap_crs) %>%
  rmapshaper::ms_erase(temp_lakemich_sf) %>%  # Erase Lake Michigan
  rename(geoid_county = GEOID,
         county = NAME) %>%
  mutate(state = case_when(STATEFP == "17" ~ "IL",
                           STATEFP == "18" ~ "IN",
                           STATEFP == "55" ~ "WI"),
         cmap = geoid_county %in% county_fips_codes$cmap,
         msa = geoid_county %in% county_fips_codes$msa,
         travel_model = geoid_county %in% unlist(county_fips_codes[c("cmap", "xil", "xin", "xwi")]),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_county, county, state, cmap, msa, travel_model, sqmi) %>%
  arrange(geoid_county)

# Process Census county subdivisions (a.k.a. political townships)
township_sf <- tigris::county_subdivisions(state = STATE, county = COUNTIES_MPO, year = BASE_YEAR) %>%
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
municipality_sf <- tigris::places(state = STATE, year = BASE_YEAR) %>%
  filter(!str_detect(NAMELSAD, " CDP")) %>%  # Incorporated places only
  sf::st_transform(cmap_crs) %>%
  filter(intersects_cmap(.)) %>%  # Restrict to CMAP region
  rename(geoid_place = GEOID,
         municipality = NAME) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_place, municipality, sqmi) %>%
  arrange(geoid_place)

# Process Congressional Districts (U.S. House of Representatives)
# Note: still 2011 districts, as of 2022 TIGER/Line. Updates are expected in spring 2023.
congress_sf <- tigris::congressional_districts(year = BASE_YEAR) %>%
  filter(STATEFP == STATE, LSAD == "C2") %>%
  sf::st_transform(cmap_crs) %>%
  mutate(dist_num = as.integer(CD116FP),
         dist_name = paste("Illinois",
                           nombre::nom_ord(dist_num, max_n = 0),
                           "Congressional District"),
         dist_name_short = paste0("IL-", dist_num),
         cmap = intersects_cmap(.),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(dist_num, dist_name, dist_name_short, cmap, sqmi) %>%
  arrange(dist_num)

# Process IL House Districts (Illinois General Assembly)
ilga_house_sf <- tigris::state_legislative_districts(state = STATE, house = "lower", year = BASE_YEAR) %>%
  filter(LSAD == "LL") %>%
  sf::st_transform(cmap_crs) %>%
  rename(dist_name = NAMELSAD) %>%
  mutate(dist_num = as.integer(SLDLST),
         cmap = intersects_cmap(.),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(dist_num, dist_name, cmap, sqmi) %>%
  arrange(dist_num)

# Process IL Senate Districts (Illinois General Assembly)
ilga_senate_sf <- tigris::state_legislative_districts(state = STATE, house = "upper", year = BASE_YEAR) %>%
  filter(LSAD == "LU") %>%
  sf::st_transform(cmap_crs) %>%
  rename(dist_name = NAMELSAD) %>%
  mutate(dist_num = as.integer(SLDUST),
         cmap = intersects_cmap(.),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(dist_num, dist_name, cmap, sqmi) %>%
  arrange(dist_num)

# Process Public Use Microddata Areas (PUMAs)
# Note: Now includes 2020 boundaries, as of 2022 TIGER/Line
puma_sf <- tigris::pumas(state = STATE, year = BASE_YEAR) %>%
  sf::st_transform(cmap_crs) %>%
  filter(intersects_cmap(.)) %>%  # Restrict to CMAP region
  rmapshaper::ms_erase(temp_lakemich_sf) %>%  # Erase Lake Michigan
  rename(geoid_puma = GEOID20,
         name = NAMELSAD20) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_puma, name, sqmi) %>%
  arrange(geoid_puma)

# Process ZIP Code Tabulation Areas (ZCTAs)
zcta_sf <- tigris::zctas(starts_with = "6", year = BASE_YEAR) %>%
  sf::st_transform(cmap_crs) %>%
  filter(intersects_cmap(.)) %>%  # Restrict to CMAP region
  rename(geoid_zcta = GEOID20) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_zcta, sqmi) %>%
  arrange(geoid_zcta)

# Process IDOT regions
county_district = c(
  `17031`="D1", `17089`="D1", `17197`="D1", `17043`="D1", `17097`="D1", `17111`="D1",
  `17161`="D2", `17103`="D2", `17177`="D2", `17085`="D2", `17073`="D2", `17201`="D2", `17141`="D2", `17007`="D2", `17195`="D2", `17015`="D2",
  `17011`="D3", `17093`="D3", `17037`="D3", `17075`="D3", `17053`="D3", `17091`="D3", `17105`="D3", `17063`="D3", `17099`="D3",
  `17131`="D4", `17057`="D4", `17175`="D4", `17155`="D4", `17109`="D4", `17203`="D4", `17179`="D4", `17123`="D4", `17187`="D4", `17143`="D4", `17095`="D4", `17071`="D4",
  `17113`="D5", `17147`="D5", `17041`="D5", `17039`="D5", `17183`="D5", `17019`="D5", `17045`="D5",
  `17067`="D6", `17009`="D6", `17135`="D6", `17001`="D6", `17171`="D6", `17129`="D6", `17169`="D6", `17125`="D6", `17149`="D6", `17017`="D6", `17167`="D6", `17137`="D6", `17117`="D6", `17107`="D6", `17021`="D6",
  `17025`="D7", `17185`="D7", `17029`="D7", `17049`="D7", `17035`="D7", `17033`="D7", `17115`="D7", `17023`="D7", `17159`="D7", `17191`="D7", `17173`="D7", `17051`="D7", `17139`="D7", `17079`="D7", `17101`="D7", `17047`="D7",
  `17005`="D8", `17083`="D8", `17163`="D8", `17189`="D8", `17027`="D8", `17061`="D8", `17157`="D8", `17013`="D8", `17121`="D8", `17119`="D8", `17133`="D8",
  `17151`="D9", `17055`="D9", `17059`="D9", `17065`="D9", `17193`="D9", `17181`="D9", `17199`="D9", `17069`="D9", `17127`="D9", `17145`="D9", `17087`="D9", `17153`="D9", `17003`="D9", `17165`="D9", `17081`="D9", `17077`="D9"
)
idot_sf <- tigris::counties(state = STATE, year = BASE_YEAR) %>%
  sf::st_transform(cmap_crs) %>%
  rmapshaper::ms_erase(temp_lakemich_sf) %>%  # Erase Lake Michigan
  mutate(district = recode(GEOID, !!!county_district),
         region = case_when(district == "D1" ~ "R1",
                            district %in% c("D2", "D3") ~ "R2",
                            district %in% c("D4", "D5") ~ "R3",
                            district %in% c("D6", "D7") ~ "R4",
                            district %in% c("D8", "D9") ~ "R5"),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  group_by(district, region) %>%
  summarize(sqmi = sum(sqmi), .groups = "drop")


# Process 2020 Census geographies (block, block group, tract)
tract_sf <- tigris::tracts(state = STATE, county = COUNTIES_7CO, year = BASE_YEAR) %>%
  filter(TRACTCE != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_tract = GEOID) %>%
  mutate(county_fips = paste0(STATEFP, COUNTYFP),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_tract, county_fips, sqmi) %>%
  arrange(geoid_tract)

blockgroup_sf <- tigris::block_groups(state = STATE, county = COUNTIES_7CO, year = BASE_YEAR) %>%
  filter(TRACTCE != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_blkgrp = GEOID) %>%
  mutate(county_fips = paste0(STATEFP, COUNTYFP),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_blkgrp, county_fips, sqmi) %>%
  arrange(geoid_blkgrp)

block_sf <- tigris::blocks(state = STATE, county = COUNTIES_7CO, year = BASE_YEAR) %>%
  filter(TRACTCE20 != "990000") %>%  # Exclude Lake Michigan tracts
  sf::st_transform(cmap_crs) %>%
  rename(geoid_block = GEOID20) %>%
  mutate(county_fips = paste0(STATEFP20, COUNTYFP20),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_block, county_fips, sqmi) %>%
  arrange(geoid_block)


# Save processed data to package's data dir
usethis::use_data(county_sf, overwrite = TRUE)
usethis::use_data(township_sf, overwrite = TRUE)
usethis::use_data(municipality_sf, overwrite = TRUE)
usethis::use_data(congress_sf, overwrite = TRUE)
usethis::use_data(ilga_house_sf, overwrite = TRUE)
usethis::use_data(ilga_senate_sf, overwrite = TRUE)
usethis::use_data(puma_sf, overwrite = TRUE)
usethis::use_data(zcta_sf, overwrite = TRUE)
usethis::use_data(idot_sf, overwrite = TRUE)
usethis::use_data(tract_sf, overwrite = TRUE)
usethis::use_data(blockgroup_sf, overwrite = TRUE)
usethis::use_data(block_sf, overwrite = TRUE)
