# cmapgeo 0.1.4
February 23, 2022

* `block_sf`, `blockgroup_sf` and `tract_sf` now represent the 2020 census
  geographies. (2010 census geographies are still available with a `_2010`
  suffix for use with ACS data from 2010 through 2019.)
* Crosswalk tables (`xwalk_*`) have also been updated to use 2020 Census data,
  and a new employment allocation factor (based on 2019
  [LEHD](https://lehd.ces.census.gov/data) data) has been added to each. The
  prior crosswalks based on the 2010 Census data are still available with a
  `_2010` suffix for use with ACS data from 2010 through 2019 (although they
  still lack an employment allocation factor).
* All datasets based on the Census Bureau's TIGER/Line boundaries have been
  updated with the 2021 vintage. (The exception is the 2010 blocks, block groups
  and tracts, which are still based on the 2019 vintage.)
* Added `sf` and `tibble` packages as requirements instead of suggestions.


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
