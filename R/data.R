# Geodata created with data-raw/load_census_api.R ------------------------

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
#'   \item{geoid_block}{Unique 15-digit block ID, assigned by the Census Bureau.
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
#' ggplot(block_sf) + geom_sf(lwd = 0.1) + theme_void()
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
#'   \item{geoid_blkgrp}{Unique 12-digit block group ID, assigned by the Census
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
#' ggplot(blockgroup_sf) + geom_sf(lwd = 0.1) + theme_void()
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
#'   \item{geoid_tract}{Unique 11-digit tract ID, assigned by the Census
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
#' ggplot(tract_sf) + geom_sf(lwd = 0.1) + theme_void()
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
#'   \item{geoid_puma}{Unique 7-digit PUMA ID, assigned by the Census Bureau.
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
#' ggplot(puma_sf) + geom_sf(lwd = 0.1) + theme_void()
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
#' ggplot(ilga_senate_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
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
#' ggplot(ilga_house_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
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
#' ggplot(congress_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
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
#'   \item{geoid_place}{Unique 7-digit place/municipality ID, assigned by the
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
#' ggplot(municipality_sf) + geom_sf(lwd = 0.1) + theme_void()
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
#'   \item{geoid_cousub}{Unique 10-digit county subdivision/township ID,
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
#' ggplot(township_sf) + geom_sf(lwd = 0.1) + theme_void()
"township_sf"


#' Counties
#'
#' The counties that are within the CMAP travel modeling area **or** the
#' "Chicago-Naperville-Elgin, IL-IN-WI" Metropolitan Statistical Area (as
#' defined by the United States Office of Management and Budget). From the US
#' Census Bureau's TIGER/Line shapefiles, 2019 vintage.
#'
#' Census Bureau description:
#'
#' *"Counties are the primary legal divisions of most states. Most counties are
#' functioning governmental units, whose powers and functions vary from state to
#' state. Legal changes to county boundaries or names are typically infrequent,
#' but do occur from time to time."*
#'
#' Note: The Illinois counties of LaSalle, Lee and Ogle are included in their
#' entirety, although only portions of these counties are part of the CMAP
#' travel modeling area. The precise geographic extent of the CMAP travel
#' modeling area is reflected in `zone_sf` and `subzone_sf`.
#'
#' @format
#' A polygon `sf` object with `r nrow(county_sf)` rows and `r ncol(county_sf)`
#' variables:
#' \describe{
#'   \item{geoid_county}{Unique 5-digit county ID (a.k.a. FIPS code), assigned
#'   by the Census Bureau. Character.}
#'   \item{county}{County name. Character.}
#'   \item{state}{2-letter state abbreviation. Character.}
#'   \item{cmap}{Is the county part of the 7-county CMAP region? Logical.}
#'   \item{msa}{Is the county part of the "Chicago-Naperville-Elgin, IL-IN-WI"
#'   Metropolitan Statistical Area? Logical.}
#'   \item{travel_model}{Is the county at least partially covered by CMAP's
#'   travel modeling area? Logical.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source US Census Bureau
#'   [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the counties with ggplot2
#' library(ggplot2)
#' ggplot(county_sf) +
#'   geom_sf(aes(fill=paste(travel_model, msa)), lwd = 0.1) +
#'   geom_sf(data = dplyr::filter(county_sf, cmap), fill = NA, lwd = 0.5) +
#'   theme_void()
"county_sf"


#' IDOT Districts
#'
#' The nine highway districts covering the entire state of Illinois, as defined
#' by the Illinois Department of Transportation (IDOT). Includes a column
#' indicating which of the five transportation regions each district belongs to.
#' Created using the county boundaries in the US Census Bureau's TIGER/Line
#' shapefiles, 2019 vintage.
#'
#' @format
#' A polygon `sf` object with `r nrow(idot_sf)` rows and `r ncol(idot_sf)`
#' variables:
#' \describe{
#'   \item{district}{District ID, assigned by IDOT. Character.}
#'   \item{region}{Region ID, assigned by IDOT. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source US Census Bureau
#'   [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'   counties, aggregated into
#'   [IDOT Regions](https://idot.illinois.gov/about-idot/idot-regions/index)
#'
#' @examples
#' # Display the IDOT districts/regions with ggplot2
#' library(ggplot2)
#' ggplot(idot_sf) + geom_sf(aes(fill = region), lwd = 0.1) + theme_void()
"idot_sf"



# Geodata created with data-raw/load_chicago_geojson.R --------------------

#' Chicago Community Areas (CCAs)
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
#' ggplot(cca_sf) + geom_sf(lwd = 0.1) + theme_void()
"cca_sf"


#' Chicago Wards
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
#' ggplot(ward_sf) + geom_sf(lwd = 0.1) + theme_void()
"ward_sf"



# Geodata created with data-raw/load_datahub_shp.R ------------------------

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
#'   \item{whole_county}{Does feature represent an entire county? Logical.}
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
#' ggplot(cmap_mpa_sf) + geom_sf(aes(fill = whole_county), lwd = 0.1) + theme_void()
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
#' ggplot(com_sf) + geom_sf(lwd = 0.1) + theme_void()
"com_sf"


#' CMAP Facility Planning Areas (FPAs)
#'
#' This dataset represents
#' wastewater service boundaries (Facility Planning Areas, or FPAs) approved by
#' IEPA as of 1 April 2014, after which IEPA ceased approving FPA boundaries. No
#' updates to this data set have occurred since that date, and no additional
#' updates are anticipated.
#'
#' CMAP is the designated areawide water-quality management planning agency for
#' the seven counties of northeastern Illinois, with responsibility for
#' reviewing wastewater permits, facility plans, and related topics to ensure
#' consistency with the federally-approved Illinois Water Quality Management
#' Plan and the Areawide Water Quality Management Plan.
#'
#' @format
#' A multipolygon `sf` object with `r nrow(fpa_sf)` rows and `r ncol(fpa_sf)`
#' variables:
#' \describe{
#'   \item{fpa}{Full name of FPA (including parent- and sub-FPA). Character.}
#'   \item{parent_fpa}{Name of parent FPA (same as `fpa` if not part of a
#'   sub-FPA). Character.}
#'   \item{sub_fpa}{Name of sub-FPA, which may have multiple parent FPAs.
#'   Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' [CMAP Data Hub](https://datahub.cmap.illinois.gov/dataset/facility-planning-areas-fpa)
#'
#' @seealso
#' <https://www.cmap.illinois.gov/programs/water/water-quality/wastewater-planning>
#'
#' @examples
#' # Display the FPAs with ggplot2
#' library(ggplot2)
#' ggplot(fpa_sf) + geom_sf(lwd = 0.1) + theme_void()
"fpa_sf"


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
#' ggplot(subzone_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
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
#' ggplot(zone_sf) + geom_sf(aes(fill = cmap), lwd = 0.1) + theme_void()
"zone_sf"



# Crosswalk tables created with data-raw/generate_xwalks.R ----------------

#' Tract-to-CCA Crosswalk
#'
#' This table contains a set of factors to apportion Census tract-level data
#' among Chicago Community Areas (CCAs). Seperate factors are provided for
#' apportioning housing unit, household, and population attributes. All factors
#' were determined by calculating the percentage of a tract's housing units,
#' households and population that were located in each of its component blocks,
#' according to the 2010 Decennial Census, and then assigning each block to a
#' CCA (based on the location of the block's centroid point).
#'
#' Generally speaking, tract boundaries align neatly with CCA boundaries as they
#' tend to follow similar features (e.g. rivers, major roads, rail lines) but
#' there are cases where the population, households and/or housing units in a
#' tract are split across multiple CCAs, or else are partially within the City
#' of Chicago and partially outside of it. For that reason, it is not
#' appropriate to use a one-to-one tract-to-CCA assignment to apportion Census
#' data among CCAs, and this crosswalk (or `xwalk_blockgroup2cca` for block
#' group-level data) should be used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since tract IDs appear multiple times in this table). Once the
#' data is joined, it should be multiplied by the appropriate factor (depending
#' whether the data of interest is measured at the housing unit, household or
#' person level), and then the result should be summed by CCA. If calculating
#' rates, this should only be done after the counts have been summed to CCA. The
#' resulting table can then be joined to `cca_sf` for mapping, if desired.
#'
#' If your data is also available at the block group level, it is recommended
#' that you use that with `xwalk_blockgroup2cca` instead of the tract-level
#' allocation.
#'
#' @format
#' A tibble with `r nrow(xwalk_tract2cca)` rows and `r ncol(xwalk_tract2cca)`
#' variables:
#' \describe{
#'   \item{geoid_tract}{Unique 11-digit tract ID, assigned by the Census
#'   Bureau. Corresponds to `tract_sf`. Character.}
#'   \item{cca_num}{Numeric CCA ID, as assigned by the City of Chicago.
#'   Corresponds to `cca_sf`. Integer.}
#'   \item{hu_pct}{Proportion of the tract's housing units (occupied or vacant)
#'   located in the specified CCA. Multiply this by a tract-level measure of a
#'   housing attribute (e.g. vacant homes) to estimate the CCA's portion.
#'   Double.}
#'   \item{hh_pct}{Proportion of the tract's households (i.e. occupied housing
#'   units) living in the specified CCA. Multiply this by a tract-level measure
#'   of a household attribute (e.g. car-free households) to estimate the CCA's
#'   portion. Double.}
#'   \item{pop_pct}{Proportion of the tract's total population (including group
#'   quarters) living in the specified CCA. Multiply this by a tract-level
#'   measure of a population attribute (e.g. race/ethnicity) to estimate the
#'   CCA's portion. Double.}
#' }
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#'
#' # View the tracts with population not fully contained in a single CCA
#' filter(xwalk_tract2cca, pop_pct < 1)
#'
#' # Estimate CCA-level transit mode share from tract-level ACS data
#' df_tract <- tidycensus::get_acs(
#'   "tract", state = "IL", county = "031", table = "B08006",
#'   year = 2019, survey = "acs5", output = "wide", cache_table = TRUE
#' ) %>%
#'   rename(workers = B08006_001E, transit = B08006_008E) %>%
#'   select(GEOID, workers, transit)
#'
#' df_cca <- xwalk_tract2cca %>%
#'   left_join(df_tract, by = c("geoid_tract" = "GEOID")) %>%
#'   mutate(transit = transit * pop_pct,
#'          workers = workers * pop_pct) %>%
#'   group_by(cca_num) %>%
#'   summarize_at(vars(transit, workers), sum) %>%
#'   mutate(transit_commute_pct = transit / workers)
#' df_cca
#'
#' # Join to cca_sf for mapping
#' library(ggplot2)
#' cca_sf %>%
#'   left_join(df_cca, by = "cca_num") %>%
#'   ggplot() +
#'     geom_sf(aes(fill = transit_commute_pct), lwd = 0.1) +
#'     scale_fill_viridis_c() +
#'     theme_void()
"xwalk_tract2cca"


#' Block Group-to-CCA Crosswalk
#'
#' This table contains a set of factors to apportion Census block group-level
#' data among Chicago Community Areas (CCAs). Seperate factors are provided for
#' apportioning housing unit, household, and population attributes. All factors
#' were determined by calculating the percentage of a block group's housing
#' units, households and population that were located in each of its component
#' blocks, according to the 2010 Decennial Census, and then assigning each block
#' to a CCA (based on the location of the block's centroid point).
#'
#' Generally speaking, block group boundaries align neatly with CCA boundaries
#' as they tend to follow similar features (e.g. rivers, major roads, rail
#' lines) but there are cases where the population, households and/or housing
#' units in a block group are split across multiple CCAs, or else are partially
#' within the City of Chicago and partially outside of it. For that reason, it
#' is not appropriate to use a one-to-one block group-to-CCA assignment to
#' apportion Census data among CCAs, and this crosswalk (or `xwalk_tract2cca`
#' for tract-level data) should be used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since block group IDs appear multiple times in this table). Once
#' the data is joined, it should be multiplied by the appropriate factor
#' (depending whether the data of interest is measured at the housing unit,
#' household or person level), and then the result should be summed by CCA. If
#' calculating rates, this should only be done after the counts have been summed
#' to CCA. The resulting table can then be joined to `cca_sf` for mapping, if
#' desired.
#'
#' If your data is only available at the tract level, you can use
#' `xwalk_tract2cca` for a tract-level allocation instead.
#'
#' @format
#' A tibble with `r nrow(xwalk_blockgroup2cca)` rows and
#' `r ncol(xwalk_blockgroup2cca)` variables:
#' \describe{
#'   \item{geoid_blkgrp}{Unique 12-digit block group ID, assigned by the Census
#'   Bureau. Corresponds to `blockgroup_sf`. Character.}
#'   \item{cca_num}{Numeric CCA ID, as assigned by the City of Chicago.
#'   Corresponds to `cca_sf`. Integer.}
#'   \item{hu_pct}{Proportion of the block group's housing units (occupied or
#'   vacant) located in the specified CCA. Multiply this by a block group-level
#'   measure of a housing attribute (e.g. vacant homes) to estimate the CCA's
#'   portion. Double.}
#'   \item{hh_pct}{Proportion of the block group's households (i.e. occupied
#'   housing units) living in the specified CCA. Multiply this by a block
#'   group-level measure of a household attribute (e.g. car-free households) to
#'   estimate the CCA's portion.Double.}
#'   \item{pop_pct}{Proportion of the block group's total population (including
#'   group quarters) living in the specified CCA. Multiply this by a block
#'   group-level measure of a population attribute (e.g. race/ethnicity) to
#'   estimate the CCA's portion. Double.}
#' }
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#'
#' # View the block groups with households not fully contained in a single CCA
#' filter(xwalk_blockgroup2cca, hh_pct < 1)
#'
#' # Estimate CCA-level unemployment rate from block group-level ACS data
#' df_blkgrp <- tidycensus::get_acs(
#'   "block group", state = "IL", county = "031", table = "B23025",
#'   year = 2019, survey = "acs5", output = "wide", cache_table = TRUE
#' ) %>%
#'   rename(civ_lf = B23025_003E, unemp = B23025_005E) %>%
#'   select(GEOID, civ_lf, unemp)
#'
#' df_cca <- xwalk_blockgroup2cca %>%
#'   left_join(df_blkgrp, by = c("geoid_blkgrp" = "GEOID")) %>%
#'   mutate(civ_lf = civ_lf * pop_pct,
#'          unemp = unemp * pop_pct) %>%
#'   group_by(cca_num) %>%
#'   summarize_at(vars(civ_lf, unemp), sum) %>%
#'   mutate(unemp_rate = unemp / civ_lf)
#' df_cca
#'
#' # Join to cca_sf for mapping
#' library(ggplot2)
#' cca_sf %>%
#'   left_join(df_cca, by = "cca_num") %>%
#'   ggplot() +
#'     geom_sf(aes(fill = unemp_rate), lwd = 0.1) +
#'     scale_fill_viridis_c(direction = -1) +
#'     theme_void()
"xwalk_blockgroup2cca"
