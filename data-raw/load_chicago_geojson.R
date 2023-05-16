library(tidyverse)
devtools::load_all()

# Links to City of Chicago Socrata resources' GeoJSON exports
CCA_GEOJSON_URL <- "https://data.cityofchicago.org/api/geospatial/cauq-8yn6?method=export&format=GeoJSON"
WARD_GEOJSON_URL <- "https://data.cityofchicago.org/api/geospatial/p293-wvbd?method=export&format=GeoJSON"

# Process Chicago Community Areas
cca_sf <- sf::st_read(CCA_GEOJSON_URL) %>%
  sf::st_transform(cmap_crs) %>%
  mutate(
    cca_name = case_when(community == "OHARE" ~ "O'Hare",
                         community == "MCKINLEY PARK" ~ "McKinley Park",
                         TRUE ~ str_to_title(community)),
    cca_num = as.integer(area_numbe),
    sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)
  ) %>%
  select(cca_name, cca_num, sqmi) %>%
  arrange(cca_name)

# Process Chicago Wards
ward_sf <- sf::st_read(WARD_GEOJSON_URL) %>%
  sf::st_transform(cmap_crs) %>%
  mutate(ward_num = as.integer(ward),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(ward_num, sqmi) %>%
  arrange(ward_num)

# Save processed data to package's data dir
usethis::use_data(cca_sf, overwrite = TRUE)
usethis::use_data(ward_sf, overwrite = TRUE)
