library(tidyverse)
library(devtools)
load_all()

# Links to zipped shapefiles hosted on the CMAP Data Hub
CMAP_ZIP_URL <- "https://datahub.cmap.illinois.gov/dataset/2e8ed4ce-d056-4183-8d97-5f2901edb1f9/resource/832c29a6-9ca8-4459-9ff0-106c56c39a0d/download/mpocountiescmap201409.zip"
COM_ZIP_URL <- "https://datahub.cmap.illinois.gov/dataset/a466a0bf-3c3e-48cb-8297-6eb55f49fb50/resource/cbe742e0-2e78-4a54-95c2-d694703e1ae6/download/CoMCMAP201303.zip"
SUBZONE_ZIP_URL <- "https://datahub.cmap.illinois.gov/dataset/a515b107-bdee-4b4c-b92e-50d3ecc0d971/resource/c4e47fca-0030-4b66-9221-947120c9c24f/download/subzones17CMAP2019.zip"
ZONE_ZIP_URL <- "https://datahub.cmap.illinois.gov/dataset/a515b107-bdee-4b4c-b92e-50d3ecc0d971/resource/8dd37215-98dc-4244-9623-2d28c4e1611c/download/zones17.zip"

# Set temp dir to download and extract ZIP files into
unzip_dir <- tempdir()

# Process CMAP Metropolitan Planning Area
cmap_zip <- tempfile()
download.file(CMAP_ZIP_URL, cmap_zip)
unzip(cmap_zip, exdir = unzip_dir)
unlink(cmap_zip)
cmap_mpa_sf <- sf::st_read(paste(unzip_dir, "MPOcounties_CMAP_201409.shp", sep="\\")) %>%
  sf::st_transform(cmap_crs) %>%
  rename(label_name = LabelName) %>%
  mutate(county_fips = paste0("17", FIPSCNTY),
         whole_county = !(CNTYNAME %in% c("DeKalb", "Grundy")),
         sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(label_name, county_fips, whole_county, sqmi) %>%
  arrange(desc(whole_county), county_fips)

# Process Councils of Mayors
com_zip <- tempfile()
download.file(COM_ZIP_URL, com_zip)
unzip(com_zip, exdir = unzip_dir)
unlink(com_zip)
com_sf <- sf::st_read(paste(unzip_dir, "CoM_CMAP_201303.shp", sep="\\")) %>%
  sf::st_transform(cmap_crs) %>%
  rename(council = Council,
         full_name = FullName) %>%
  mutate(sqmi = unclass(sf::st_area(geometry) / sqft_per_sqmi)) %>%
  select(council, full_name, sqmi) %>%
  arrange(council)

# Process subzones
subzone_zip <- tempfile()
download.file(SUBZONE_ZIP_URL, subzone_zip)
unzip(subzone_zip, exdir = unzip_dir)
unlink(subzone_zip)
subzone_sf <- sf::st_read(paste(unzip_dir, "subzones17.shp", sep="\\")) %>%
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
zone_zip <- tempfile()
download.file(ZONE_ZIP_URL, zone_zip)
unzip(zone_zip, exdir = unzip_dir)
unlink(zone_zip)
zone_sf <- sf::st_read(paste(unzip_dir, "zones17.shp", sep="\\")) %>%
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
usethis::use_data(subzone_sf, overwrite = TRUE)
usethis::use_data(zone_sf, overwrite = TRUE)
