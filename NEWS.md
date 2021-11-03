# cmapgeo 0.1.3
November 3, 2021

* Added `block_sf_2020`, `blockgroup_sf_2020` and `tract_sf_2020` for use with
  data from the 2020 decennial census. *(Note: once the Census Bureau publishes
  the 2016-2020 ACS 5-year data, these datasets will be renamed to replace
  `block_sf`, `blockgroup_sf` and `tract_sf`.)*


# cmapgeo 0.1.2
June 11, 2021

* Changed class of `cca_sf` and `ward_sf` from `sf-tibble` to `sf-data.frame`,
  for consistency with all other cmapgeo datasets.


# cmapgeo 0.1.1
June 8, 2021

* Added Census ZIP Code Tabulation Areas (ZCTAs) as `zcta_sf`.


# cmapgeo 0.1.0
May 26, 2021

* Initial package release. At this point, it is essentially just a repository of
geodata and crosswalk tables.
