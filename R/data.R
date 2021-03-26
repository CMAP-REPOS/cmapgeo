# Datasets created with data-raw/load_census_api.R -----------------------

#' Census Blocks
#'
#' The Census Blocks within the 7-county Chicago Metropolitan Agency for
#' Planning (CMAP) region. From the US Census Bureau's TIGER/Line shapefiles,
#' 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"Blocks are statistical areas bounded by visible features, such as streets,
#' roads, streams, and railroad tracks, and by nonvisible boundaries, such as
#' selected property lines and city, township, school district, and county
#' limits and short line-of-sight extensions of streets and roads. Generally,
#' census blocks are small in area; for example, a block in a city bounded on
#' all sides by streets. Census blocks in suburban and rural areas may be large,
#' irregular, and bounded by a variety of features, such as roads, streams, and
#' transmission lines. In remote areas, census blocks may encompass hundreds of
#' square miles. Census blocks cover the entire territory of the United States,
#' Puerto Rico, and the Island Areas. Census blocks nest within all other
#' tabulated census geographic entities and are the basis for all tabulated
#' data."*
#'
#' @format
#' A multipolygon `sf` object with `r nrow(block_sf)` rows and `r ncol(block_sf)`
#' variables:
#' \describe{
#'   \item{geoid_block}{15-digit unique block ID, assigned by the Census Bureau.
#'   The parent tract and block group can be identified from the first 11 and 12
#'   digits, respectively. Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the block is in.
#'   Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the blocks with ggplot2
#' library(ggplot2)
#' ggplot(data = block_sf) + geom_sf(lwd = 0.1) + theme_void()
"block_sf"


#' Census Block Groups
#'
#' The Census Block Groups within the 7-county Chicago Metropolitan Agency for
#' Planning (CMAP) region. From the US Census Bureau's TIGER/Line shapefiles,
#' 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"Block Groups (BGs) are statistical divisions of census tracts, are
#' generally defined to contain between 600 and 3,000 people, and are used to
#' present data and control block numbering. A block group consists of clusters
#' of blocks within the same census tract that have the same first digit of
#' their four-digit census block number. For example, blocks 3001, 3002, 3003,
#' ..., 3999 in census tract 1210.02 belong to BG 3 in that census tract. Most
#' BGs were delineated by local participants in the Census Bureau's Participant
#' Statistical Areas Program. The Census Bureau delineated BGs only where a
#' local or tribal government declined to participate, and a regional
#' organization or State Data Center was not available to participate.*
#'
#' *"A BG usually covers a contiguous area. Each census tract contains at least
#' one BG, and BGs are uniquely numbered within the census tract. Within the
#' standard census geographic hierarchy, BGs never cross state, county, or
#' census tract boundaries but may cross the boundaries of any other geographic
#' entity. Tribal census tracts and tribal BGs are separate and unique
#' geographic areas defined within federally recognized American Indian
#' reservations and can cross state and county boundaries. The tribal census
#' tracts and tribal block groups may be completely different from the census
#' tracts and block groups defined by state and county."*
#'
#' @format
#' A polygon `sf` object with `r nrow(blockgroup_sf)` rows and
#' `r ncol(blockgroup_sf)` variables:
#' \describe{
#'   \item{geoid_blkgrp}{12-digit unique block group ID, assigned by the Census
#'   Bureau. The parent tract can be identified from the first 11 digits.
#'   Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the block group
#'   is in. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the block groups with ggplot2
#' library(ggplot2)
#' ggplot(data = blockgroup_sf) + geom_sf(lwd = 0.1) + theme_void()
"blockgroup_sf"


#' Census Tracts
#'
#' The Census Tracts within the 7-county Chicago Metropolitan Agency for
#' Planning (CMAP) region. From the US Census Bureau's TIGER/Line shapefiles,
#' 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"Census Tracts are small, relatively permanent statistical subdivisions of a
#' county or equivalent entity that are updated by local participants prior to
#' each decennial census as part of the Census Bureau's Participant Statistical
#' Areas Program. The Census Bureau delineates census tracts in situations where
#' no local participant existed or where state, local, or tribal governments
#' declined to participate. The primary purpose of census tracts is to provide a
#' stable set of geographic units for the presentation of statistical data.*
#'
#' *"Census tracts generally have a population size between 1,200 and 8,000
#' people, with an optimum size of 4,000 people. A census tract usually covers a
#' contiguous area; however, the spatial size of census tracts varies widely
#' depending on the density of settlement. Census tract boundaries are
#' delineated with the intention of being maintained over a long time so that
#' statistical comparisons can be made from census to census. Census tracts
#' occasionally are split due to population growth or merged as a result of
#' substantial population decline.*
#'
#' *"Census tract boundaries generally follow visible and identifiable features.
#' They may follow nonvisible legal boundaries, such as minor civil division
#' (MCD) or incorporated place boundaries in some states and situations, to
#' allow for census-tract-to-governmental-unit relationships where the
#' governmental boundaries tend to remain unchanged between censuses. State and
#' county boundaries always are census tract boundaries in the standard census
#' geographic hierarchy. Tribal census tracts are a unique geographic entity
#' defined within federally recognized American Indian reservations and
#' off-reservation trust lands and can cross state and county boundaries. Tribal
#' census tracts may be completely different from the census tracts and block
#' groups defined by state and county."*
#'
#' @format
#' A polygon `sf` object with `r nrow(tract_sf)` rows and `r ncol(tract_sf)`
#' variables:
#' \describe{
#'   \item{geoid_tract}{11-digit unique tract ID, assigned by the Census
#'   Bureau. Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the tract is in.
#'   Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the tracts with ggplot2
#' library(ggplot2)
#' ggplot(data = tract_sf) + geom_sf(lwd = 0.1) + theme_void()
"tract_sf"


#' Census Public Use Microdata Areas (PUMAs)
#'
#' The Census PUMAs covering the 7-county Chicago Metropolitan Agency for
#' Planning (CMAP) region. From the US Census Bureau's TIGER/Line shapefiles,
#' 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"Public Use Microdata Areas (PUMAs) are geographic areas for which the
#' Census Bureau provides selected extracts of raw data from a small sample of
#' census records that are screened to protect confidentiality. These extracts
#' are referred to as public use microdata sample (PUMS) files.*
#'
#' *"For the 2010 Census, each state, the District of Columbia, Puerto Rico, and
#' some Island Area participants delineated PUMAs for use in presenting PUMS
#' data based on a 5 percent sample of decennial census or American Community
#' Survey data. These areas are required to contain at least 100,000 people.
#' This is different from Census 2000 when two types of PUMAs were defined: a 5
#' percent PUMA as for 2010 and an additional super-PUMA designed to provide a 1
#' percent sample. The PUMAs are identified by a five-digit census code unique
#' within state."*
#'
#' @format
#' A multipolygon `sf` object with `r nrow(puma_sf)` rows and `r ncol(puma_sf)`
#' variables:
#' \describe{
#'   \item{geoid_puma}{7-digit unique PUMA ID, assigned by the Census Bureau.
#'   Character.}
#'   \item{name}{A Census-assigned name to help describe a PUMA's extent.
#'   Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the PUMAs with ggplot2
#' library(ggplot2)
#' ggplot(data = puma_sf) + geom_sf(lwd = 0.1) + theme_void()
"puma_sf"


#' Illinois State Senate Districts
#'
#' The Illinois General Assembly Senate Districts. From the US Census Bureau's
#' TIGER/Line shapefiles, 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"State Legislative Districts (SLDs) are the areas from which members are
#' elected to state legislatures. The Census Bureau first reported data for SLDs
#' as part of the 2000 Public Law (P.L.) 94-171 Redistricting Data File.*
#'
#' *"Current SLDs (2010 Election Cycle) -- States participating in Phase 1 of
#' the 2010 Census Redistricting Data Program voluntarily provided the Census
#' Bureau with the 2006 election cycle boundaries, codes, and, in some cases,
#' names for their SLDs. All 50 states, plus the District of Columbia and Puerto
#' Rico, participated in Phase 1, State Legislative District Project (SLDP) of
#' the 2010 Census Redistricting Data Program. States subsequently provided
#' legal changes to those plans through the Redistricting Data Office and/or
#' corrections as part of Phase 2 of the 2010 Census Redistricting Data Program,
#' as needed.*
#'
#' *"The SLDs embody the upper (senate) and lower (house) chambers of the state
#' legislature. A unique three-character census code, identified by state
#' participants, is assigned to each SLD within a state. In Connecticut, Hawaii,
#' Illinois, Louisiana, Maine, Massachusetts, New Jersey, Ohio, and Puerto Rico,
#' state officials did not define the SLDs to cover all of the state or state
#' equivalent area (usually bodies of water). In these areas with no SLDs
#' defined, the code "ZZZ" has been assigned, which is treated within state as a
#' single SLD for purposes of data presentation."*
#'
#' Note: The aforementioned "ZZZ" district, which comprises the Illinois portion
#' of Lake Michigan, has been excluded from this dataset.
#'
#' @format
#' A polygon `sf` object with `r nrow(ilga_senate_sf)` rows and
#' `r ncol(ilga_senate_sf)` variables:
#' \describe{
#'   \item{dist_num}{Illinois State Senate District number. Integer.}
#'   \item{dist_name}{Name of the district. Character.}
#'   \item{cmap}{Does the district overlap the 7-county CMAP region? Logical.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the ILGA Senate Districts with ggplot2
#' library(ggplot2)
#' ggplot(data = ilga_senate_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
"ilga_senate_sf"


#' Illinois State House Districts
#'
#' The Illinois General Assembly House Districts. From the US Census Bureau's
#' TIGER/Line shapefiles, 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"State Legislative Districts (SLDs) are the areas from which members are
#' elected to state legislatures. The Census Bureau first reported data for SLDs
#' as part of the 2000 Public Law (P.L.) 94-171 Redistricting Data File.*
#'
#' *"Current SLDs (2010 Election Cycle) -- States participating in Phase 1 of
#' the 2010 Census Redistricting Data Program voluntarily provided the Census
#' Bureau with the 2006 election cycle boundaries, codes, and, in some cases,
#' names for their SLDs. All 50 states, plus the District of Columbia and Puerto
#' Rico, participated in Phase 1, State Legislative District Project (SLDP) of
#' the 2010 Census Redistricting Data Program. States subsequently provided
#' legal changes to those plans through the Redistricting Data Office and/or
#' corrections as part of Phase 2 of the 2010 Census Redistricting Data Program,
#' as needed.*
#'
#' *"The SLDs embody the upper (senate) and lower (house) chambers of the state
#' legislature. A unique three-character census code, identified by state
#' participants, is assigned to each SLD within a state. In Connecticut, Hawaii,
#' Illinois, Louisiana, Maine, Massachusetts, New Jersey, Ohio, and Puerto Rico,
#' state officials did not define the SLDs to cover all of the state or state
#' equivalent area (usually bodies of water). In these areas with no SLDs
#' defined, the code "ZZZ" has been assigned, which is treated within state as a
#' single SLD for purposes of data presentation."*
#'
#' Note: The aforementioned "ZZZ" district, which comprises the Illinois portion
#' of Lake Michigan, has been excluded from this dataset.
#'
#' @format
#' A polygon `sf` object with `r nrow(ilga_house_sf)` rows and
#' `r ncol(ilga_house_sf)` variables:
#' \describe{
#'   \item{dist_num}{Illinois State House District number. Integer.}
#'   \item{dist_name}{Name of the district. Character.}
#'   \item{cmap}{Does the district overlap the 7-county CMAP region? Logical.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the ILGA House Districts with ggplot2
#' library(ggplot2)
#' ggplot(data = ilga_house_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
"ilga_house_sf"


#' U.S. Congressional Districts
#'
#' The United States Congressional Districts in the state of Illinois. From the
#' US Census Bureau's TIGER/Line shapefiles, 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"Congressional Districts are the 435 areas from which people are elected to
#' the U.S. House of Representatives. After the apportionment of congressional
#' seats among the states based on decennial census population counts, each
#' state with multiple seats is responsible for establishing congressional
#' districts for the purpose of electing representatives. Each congressional
#' district is to be as equal in population to all other congressional districts
#' in a state as practicable. For the District of Columbia, Puerto Rico, and
#' each Island Area, a separate code is used to identify the entire areas of
#' these state-equivalent entities as having a single nonvoting delegate."*
#'
#' @format
#' A multipolygon `sf` object with `r nrow(congress_sf)` rows and `r ncol(congress_sf)`
#' variables:
#' \describe{
#'   \item{dist_num}{Congressional District number. Integer.}
#'   \item{dist_name}{Name of the district (full). Character.}
#'   \item{dist_name_short}{Name of the district (short). Character.}
#'   \item{cmap}{Does the district overlap the 7-county CMAP region? Logical.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the Congressional Districts with ggplot2
#' library(ggplot2)
#' ggplot(data = congress_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
"congress_sf"


#' Municipalities
#'
#' The 284 municipalities (also referred to as "incorporated places" in Census
#' Bureau terminology) that are at least partially within the 7-county Chicago
#' Metropolitan Agency for Planning (CMAP) region. From the US Census Bureau's
#' TIGER/Line shapefiles, 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"Incorporated Places are those reported to the Census Bureau as legally in
#' existence as of January 1, 2010, as reported in the latest Boundary and
#' Annexation Survey (BAS), under the laws of their respective states. An
#' incorporated place is established to provide governmental functions for a
#' concentration of people as opposed to a minor civil division, which generally
#' is created to provide services or administer an area without regard,
#' necessarily, to population. Places always are within a single state or
#' equivalent entity, but may extend across county and county subdivision
#' boundaries. An incorporated place usually is a city, town, village, or
#' borough, but can have other legal descriptions."*
#'
#' @format
#' A multipolygon `sf` object with `r nrow(municipality_sf)` rows and
#' `r ncol(municipality_sf)` variables:
#' \describe{
#'   \item{geoid_place}{7-digit unique place/municipality ID, assigned by the
#'   Census Bureau. Character.}
#'   \item{municipality}{Municipality name. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the municipalities with ggplot2
#' library(ggplot2)
#' ggplot(data = municipality_sf) + geom_sf(lwd = 0.1) + theme_void()
"municipality_sf"


#' Townships
#'
#' The political townships (also referred to as "county subdivisions" in Census
#' Bureau terminology) that are within the CMAP Metropolitan Planning Area
#' (MPA). (The MPA includes the 7 CMAP counties, plus Aux Sable Township in
#' Grundy County and Sandwich & Somonauk Townships in DeKalb County.) From the
#' US Census Bureau's TIGER/Line shapefiles, 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"County Subdivisions are the primary divisions of counties and equivalent
#' entities. They include census county divisions, census subareas, minor civil
#' divisions, and unorganized territories and can be classified as either legal
#' or statistical. Each county subdivision is assigned a five-character numeric
#' Federal Information Processing Series (FIPS) code based on alphabetical
#' sequence within state and an eight-digit National Standard feature
#' identifier."*
#'
#' Note: The entire City of Chicago (other than the portion of O'Hare in DuPage
#' County) is included as a single township in this dataset, and has not been
#' subdivided into the eight theoretical townships defined by the Cook County
#' Clerk's Office for the purposes of collecting property tax.
#'
#' @format
#' A multipolygon `sf` object with `r nrow(township_sf)` rows and
#' `r ncol(township_sf)` variables:
#' \describe{
#'   \item{geoid_cousub}{10-digit unique county subdivision/township ID,
#'   assigned by the Census Bureau. Character.}
#'   \item{township}{Township name. Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the township is
#'   in. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the townships with ggplot2
#' library(ggplot2)
#' ggplot(data = township_sf) + geom_sf(lwd = 0.1) + theme_void()
"township_sf"



# Datasets created with data-raw/load_chicago_geojson.R -------------------

#' Chicago community areas (CCAs)
#'
#' The official boundaries of the Chicago Community Areas. Obtained 3/24/2021.
#'
#' @format
#' A multipolygon `sf` object with `r nrow(cca_sf)` rows and `r ncol(cca_sf)`
#' variables:
#' \describe{
#'   \item{cca_name}{Community area name. Character.}
#'   \item{cca_num}{Numeric ID, as assigned by the City of Chicago. Integer.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' [Chicago Data Portal](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Community-Areas-current-/cauq-8yn6)
#'
#' @examples
#' # Display the CCAs with ggplot2
#' library(ggplot2)
#' ggplot(data = cca_sf) + geom_sf(lwd = 0.1) + theme_void()
"cca_sf"


#' Chicago wards
#'
#' The official boundaries of the current Chicago wards (established in May of
#' 2015). Obtained 3/24/2021.
#'
#' @format
#' A multipolygon `sf` object with `r nrow(ward_sf)` rows and `r ncol(ward_sf)`
#' variables:
#' \describe{
#'   \item{ward_num}{Ward number. Integer.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' [Chicago Data Portal](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Wards-2015-/sp34-6z76)
#'
#' @examples
#' # Display the wards with ggplot2
#' library(ggplot2)
#' ggplot(data = ward_sf) + geom_sf(lwd = 0.1) + theme_void()
"ward_sf"



# Datasets created with data-raw/load_datahub_shp.R -----------------------

#' CMAP Metropolitan Planning Area
#'
#' This dataset depicts the individual counties (some only partial) that compose
#' the Chicago Metropolitan Planning Area, approved by the Board of
#' [CMAP](https://www.cmap.illinois.gov) and the
#' [MPO Policy Committee](https://www.cmap.illinois.gov/committees/policy/mpo)
#' in March of 2013. Final approval by Governor Quinn was granted on 11
#' September, 2014. The revised MPA includes the urbanized area established by
#' the US Census Bureau pursuant to the 2010 Decennial Census. The MPA was
#' expanded to include Somonauk and Sandwich Townships in DeKalb County.
#'
#' @format
#' A polygon `sf` object with `r nrow(cmap_mpa_sf)` rows and
#' `r ncol(cmap_mpa_sf)` variables:
#' \describe{
#'   \item{label_name}{County name (or township names, for partial counties).
#'   Character.}
#'   \item{county_fips}{Unique 5-digit county FIPS code. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' [CMAP Data Hub](https://datahub.cmap.illinois.gov/dataset/cmap-metropolitan-planning-area-september-2014)
#'
#' @examples
#' # Display the CMAP MPA counties with ggplot2
#' library(ggplot2)
#' ggplot(data = cmap_mpa_sf) + geom_sf(aes(fill = whole_county), lwd = 0.1) + theme_void()
"cmap_mpa_sf"


#' CMAP Subregional Councils of Mayors (COMs)
#'
#' This dataset was developed by CMAP to create a more up-to-date depiction of
#' Council of Mayors (COM) boundaries. Since COMs are made up of groups of
#' municipalities, CMAP utilized the most current available municipal boundaries
#' from the seven counties to help construct this file in September 2010. This
#' file was updated in March 2013 to reflect the expansion of the MPA into
#' DeKalb County (Sandwich and Somonauk Townships).
#'
#' DISCLAIMER: Subregional Councils of Mayors (COM) boundaries are a hybrid of
#' county and municipal boundaries. The council boundaries are based on the
#' membership of municipalities within a subregional council. County boundaries
#' are followed in unincorporated areas. For municipalities designated as
#' belonging to more than one council, the county boundary is followed. Example
#' 1: the City of Naperville is a member of the DuPage Council of Mayors; since
#' Naperville city limits extend into Will County, the DuPage COM boundary
#' follows the Naperville boundary (including all unincorporated pockets) in
#' Will County. Example 2: Buffalo Grove belongs to both the Lake County and
#' Northwest subregional councils; in this case, the subregional boundary
#' follows the county boundary through Buffalo Grove.
#'
#' It is important to note here that the portions of COM boundaries, defined by
#' municipalities, are fluid: they change as a village annexes adjacent
#' unincorporated land. The boundaries depicted in this dataset reflect
#' municipal boundaries of varying vintages and sources, and cannot be
#' considered “true” for any given point in time.
#'
#' @format
#' A multipolygon `sf` object with `r nrow(com_sf)` rows and `r ncol(com_sf)`
#' variables:
#' \describe{
#'   \item{council}{Council of Mayors name (short). Character.}
#'   \item{full_name}{Council of Mayors name (full). Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' [CMAP Data Hub](https://datahub.cmap.illinois.gov/dataset/councils-of-mayors-boundaries)
#'
#' @seealso
#' <https://www.cmap.illinois.gov/committees/advisory/council-of-mayors/subregional-councils>
#'
#' @examples
#' # Display the COMs with ggplot2
#' library(ggplot2)
#' ggplot(data = com_sf) + geom_sf(lwd = 0.1) + theme_void()
"com_sf"


#' CMAP Travel Modeling Subzones
#'
#' The 2017 subzones (a.k.a. MAZs) used by [CMAP](http://cmap.illinois.gov) for
#' travel demand modeling and socioeconomic forecasting. Covers the 7-county
#' CMAP region, plus 14 other counties in Illinois, Indiana and Wisconsin (some
#' only partially). The subzones are derived from the Illinois Public Land
#' Survey System (PLSS), with most of the subzones within the CMAP region
#' corresponding to a PLSS quarter-section. This forms a fairly regular grid of
#' 0.5 mile wide squares, although there are some irregularities.
#'
#' @format
#' A polygon `sf` object with `r nrow(subzone_sf)` rows and `r ncol(subzone_sf)`
#' variables:
#' \describe{
#'   \item{subzone17}{Numeric subzone ID. Integer.}
#'   \item{zone17}{Numeric ID of parent zone, corresponding to `zone_sf`.
#'   Integer.}
#'   \item{capzone17}{The CMAP capacity zone characterization of the subzone.
#'   Integer. \itemize{
#'     \item{1 = Chicago Central Business District}
#'     \item{2 = Remainder of Chicago Central Area}
#'     \item{3 = Remainder of City of Chicago}
#'     \item{4 = Inner ring suburbs where Chicago street grid is generally
#'     maintained}
#'     \item{5 = Remainder of IL portion of the Chicago Urbanized Area}
#'     \item{6 = IN portion of the Chicago Urbanized Area}
#'     \item{7 = Other Urbanized Areas and Urban Clusters within the CMAP
#'     Metropolitan Planning Area plus other Urbanized Areas in IL}
#'     \item{8 = Other Urbanized Areas and Urban Clusters in IN}
#'     \item{9 = Remainder of CMAP Metropolitan Planning Area}
#'     \item{10 = Remainder of Lake County, IN (rural)}
#'     \item{11 = External area}
#'   }}
#'   \item{cmap}{Is subzone in the CMAP MPA? (The MPA includes the 7 CMAP
#'   counties, plus Aux Sable Township in Grundy County and Sandwich & Somonauk
#'   Townships in DeKalb County.) Logical.}
#'   \item{chicago}{Is subzone in the City of Chicago? (Approximate, in some
#'   cases.) Logical.}
#'   \item{cbd}{Is subzone in the Chicago Central Business District? (CBD is
#'   defined as the area bounded by Chicago Ave, Halsted St, Roosevelt Rd, and
#'   Lake Michigan.) Logical.}
#'   \item{township_range}{4-digit ID of the
#'   \href{https://clearinghouse.isgs.illinois.edu/data/reference/illinois-plss-townships}{PLSS township}
#'   the subzone is in; first 2 digits are township, last 2 are range. Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the subzone is
#'   in; first 2 digits are the state FIPS code. Character.}
#'   \item{state}{State the subzone is in (IL, IN or WI). Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' [CMAP Data Hub](https://datahub.cmap.illinois.gov/dataset/cmap-modeling-zone-systems)
#'
#' @examples
#' # Display the subzones with ggplot2
#' library(ggplot2)
#' ggplot(data = subzone_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
"subzone_sf"


#' CMAP Travel Modeling Zones
#'
#' The 2017 zones (a.k.a. TAZs) used by [CMAP](http://cmap.illinois.gov) for
#' travel demand modeling. Covers the 7-county CMAP region, plus 14 other
#' counties in Illinois, Indiana and Wisconsin (some only partially). Zones are
#' aggregations of subzones (`subzone_sf`).
#'
#' @format
#' A polygon `sf` object with `r nrow(zone_sf)` rows and `r ncol(zone_sf)`
#' variables:
#' \describe{
#'   \item{zone17}{Numeric zone ID. Integer.}
#'   \item{cmap}{Is zone in the CMAP MPA? (The MPA includes the 7 CMAP counties,
#'   plus Aux Sable Township in Grundy County and Sandwich & Somonauk Townships
#'   in DeKalb County.) Logical.}
#'   \item{chicago}{Is zone in the City of Chicago? (Approximate, in some
#'   cases.) Logical.}
#'   \item{cbd}{Is zone in the Chicago Central Business District? (CBD is
#'   defined as the area bounded by Chicago Ave, Halsted St, Roosevelt Rd, and
#'   Lake Michigan.) Logical.}
#'   \item{township_range}{4-digit ID of the
#'   \href{https://clearinghouse.isgs.illinois.edu/data/reference/illinois-plss-townships}{PLSS township}
#'   the zone is in; first 2 digits are township, last 2 are range. Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the zone is in;
#'   first 2 digits are the state FIPS code. Character.}
#'   \item{state}{State the zone is in (IL, IN or WI). Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' [CMAP Data Hub](https://datahub.cmap.illinois.gov/dataset/cmap-modeling-zone-systems)
#'
#' @examples
#' # Display the zones with ggplot2
#' library(ggplot2)
#' ggplot(data = zone_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
"zone_sf"
