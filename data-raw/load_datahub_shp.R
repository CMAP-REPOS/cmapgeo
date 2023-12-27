library(tidyverse)
devtools::load_all()

# Links to JSON shapefiles hosted on the CMAP Data Hub

MPA_URL <- "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/Shapefile_CMAP_MPA_Boundary_September_2014/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
COM_URL <- "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/Councils_of_Mayors_Boundary_Shapefile_March_2013/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
EDA_URL <- "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/EDAs_and_Disinvested_Areas/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
FPA_URL <- "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/FPA_CMAP_201404_revised_6_16_/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
SUBZONE_URL <- "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/Trip_Generation_Zone_Subzone_Geography_2017/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
ZONE_URL <- "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/Traffic_Analysis_Zone_Geography_2017/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"

# Process CMAP Metropolitan Planning Area
cmap_mpa_sf <- sf::st_read(MPA_URL) %>%
  sf::st_transform(cmap_crs) %>%
    rename(label_name = LabelName) %>%
    mutate(county_fips = paste0("17", FIPSCNTY),
           whole_county = !(CNTYNAME %in% c("DeKalb", "Grundy")),
           sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
    select(label_name, county_fips, whole_county, sqmi) %>%
    arrange(desc(whole_county), county_fips)

# Process Councils of Mayors
com_sf <- sf::st_read(COM_URL) %>%
  sf::st_transform(cmap_crs) %>%
  rename(council = Council,
         full_name = FullName) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(council, full_name, sqmi) %>%
  arrange(council)

# Process EDAs and Disinvested Areas
eda_sf <- sf::st_read(EDA_URL) %>%
  sf::st_transform(cmap_crs) %>%
  filter(DisplayGro %in% c("Economically Disconnected Area", "Disinvested", "Both")) %>%
  sf::st_transform(cmap_crs) %>%
  rename(geoid_tract = GEOID10) %>%
  mutate(county_fips = paste0(STATEFP10, COUNTYFP10),
         area_type = case_when(
           DisplayGro == "Disinvested" ~ "Disinvested Area Only",
           DisplayGro == "Both" ~ "Economically Disconnected and Disinvested Area",
           TRUE ~ "Economically Disconnected Area Only"
         ),
         eda = DisplayGro %in% c("Economically Disconnected Area", "Both"),
         disinvested = DisplayGro %in% c("Disinvested", "Both"),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(geoid_tract, county_fips, area_type, eda, disinvested, sqmi) %>%
  arrange(geoid_tract)

# Process Facility Planning Areas
fpa_sf <- sf::st_read(FPA_URL) %>%
  filter(FPANAME != "Non-FPA") %>%
  sf::st_transform(cmap_crs) %>%
  rename(fpa = FPANAME,
         parent_fpa = PARENT_FPA,
         sub_fpa = SUB_FPA) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  group_by(fpa, parent_fpa, sub_fpa) %>%
  summarize(sqmi = sum(sqmi), .groups = "drop") %>%
  arrange(parent_fpa, sub_fpa)

# Process subzones
subzone_sf <- sf::st_read(SUBZONE_URL) %>%
  sf::st_transform(cmap_crs) %>%
  rename(county_fips = county_fip,
         township_range = township_r,
         county_name = county_nam) %>%
  mutate(subzone17 = as.integer(subzone17),
         zone17 = as.integer(zone17),
         capzone17 = as.integer(capzone17),
         cmap = as.logical(cmap),
         chicago = as.logical(chicago),
         cbd = as.logical(cbd),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(subzone17, zone17, capzone17, cmap, chicago, cbd, township_range, county_fips, state, sqmi) %>%
  arrange(subzone17)

# Process zones
zone_sf <- sf::st_read(ZONE_URL) %>%
  sf::st_transform(cmap_crs) %>%
  rename(county_fips = county_fip,
         township_range = township_r,
         county_name = county_nam) %>%
  mutate(zone17 = as.integer(zone17),
         cmap = as.logical(cmap),
         chicago = as.logical(chicago),
         cbd = as.logical(cbd),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(zone17, cmap, chicago, cbd, township_range, county_fips, state, sqmi) %>%
  arrange(zone17)

# Save processed data to package's data dir
usethis::use_data(cmap_mpa_sf, overwrite = TRUE)
usethis::use_data(com_sf, overwrite = TRUE)
usethis::use_data(eda_sf, overwrite = TRUE)
usethis::use_data(fpa_sf, overwrite = TRUE)
usethis::use_data(subzone_sf, overwrite = TRUE)
usethis::use_data(zone_sf, overwrite = TRUE)
