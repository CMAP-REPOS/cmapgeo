# Geodata created with data-raw/load_census_api.R ------------------------

# NOTE: Census geography glossary is located at
# <https://www.census.gov/programs-surveys/geography/about/glossary.html>


#' Census Blocks
#'
#' The Census Blocks within the 7-county Chicago Metropolitan Agency for
#' Planning (CMAP) region. From the US Census Bureau's TIGER/Line shapefiles,
#' 2022 vintage. **Use `block_sf` for data from the 2020 decennial census or the
#' American Community Survey (ACS) from 2020 onward.**
#'
#' Census Bureau description:
#'
#' *"Blocks (Census Blocks or Tabulation Blocks) are statistical areas bounded
#' by visible features, such as streets, roads, streams, and railroad tracks,
#' and by nonvisible boundaries, such as selected property lines and city,
#' township, school district, and county limits and short line-of-sight
#' extensions of streets and roads. Generally, blocks are small in area; for
#' example, a city block bounded on all sides by streets. Blocks in suburban and
#' rural areas may be larger, more irregular in shape, and bounded by a variety
#' of features, such as roads, streams, and transmission lines. In remote areas,
#' blocks may even encompass hundreds of square miles. Blocks cover the entire
#' territory of the United States, Puerto Rico, and the Island Areas. Blocks
#' nest within all other tabulated census geographic entities at the time of the
#' decennial census and are the basis for all tabulated data from that census.
#' Census Block Numbers—Blocks are numbered uniquely with a four-digit census
#' block number from 0000 to 9999 within census tract, which nest within state
#' and county. The first digit of the census block number identifies the block
#' group. Block numbers beginning with a zero (in Block Group 0) are intended to
#' include only water area, but not all water-only blocks have block numbers
#' beginning with 0 (zero)."*
#'
#' @format `block_sf` is a multipolygon `sf` object with `r nrow(block_sf)` rows
#' and `r ncol(block_sf)` variables:
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
#' @source US Census Bureau
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
#' 2022 vintage.
#'
#' Census Bureau description:
#'
#' *"Block Groups (BGs) are statistical divisions of census tracts, are
#' generally defined to contain between 600 and 3,000 people, and are used to
#' present data and control block numbering. A block group consists of clusters
#' of blocks within the same census tract that have the same first digit of
#' their four-digit census block number. For example, blocks 3001, 3002, 3003,
#' ..., 3999 in census tract 1210.02 belong to BG 3 in that census tract. Most
#' BGs were delineated by local participants in the Census Bureau’s Participant
#' Statistical Areas Program (PSAP). The Census Bureau delineated BGs only where
#' a local or tribal government declined to participate in PSAP, and a regional
#' organization or the State Data Center was not available to participate. A BG
#' usually covers a contiguous area. Each census tract contains at least one BG,
#' and BGs are uniquely numbered within the census tract. Within the standard
#' census geographic hierarchy, BGs never cross state, county, or census tract
#' boundaries, but may cross the boundaries of any other geographic entity.
#' Tribal census tracts and tribal BGs are separate and unique geographic areas
#' defined within federally recognized American Indian reservations and can
#' cross state and county boundaries. The tribal census tracts and tribal block
#' groups may be completely different from the standard county-based census
#' tracts and block groups defined for the same area."*
#'
#' @format
#' `blockgroup_sf` is a multipolygon `sf` object with `r nrow(blockgroup_sf)`
#' rows and `r ncol(blockgroup_sf)` variables:
#' \describe{
#'   \item{geoid_blkgrp}{Unique 12-digit block group ID, assigned by the Census
#'   Bureau. The parent tract can be identified from the first 11 digits.
#'   Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the block group
#'   is in. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
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
#' 2022 vintage.
#'
#' Census Bureau description:
#'
#' *"Census Tracts are small, relatively permanent statistical subdivisions of a
#' county or statistically equivalent entity that can be updated by local
#' participants prior to each decennial census as part of the Census Bureau’s
#' Participant Statistical Areas Program (PSAP). The Census Bureau delineates
#' census tracts in situations where no local participant responded or where
#' state, local, or tribal governments declined to participate. The primary
#' purpose of census tracts is to provide a stable set of geographic units for
#' the presentation of statistical data.
#'
#' *"Census tracts generally have a population size between 1,200 and 8,000
#' people, with an optimum size of 4,000 people. A census tract usually covers a
#' contiguous area; however, the spatial size of census tracts varies widely
#' depending on the density of settlement. Census tract boundaries are
#' delineated with the intention of being maintained over a long time so that
#' statistical comparisons can be made from census to census. Census tracts
#' occasionally are split due to population growth or merged as a result of
#' substantial population decline.
#'
#' *"Census tract boundaries generally follow visible and identifiable features.
#' They may follow nonvisible legal boundaries, such as minor civil division
#' (MCD) or incorporated place boundaries in some states and situations, to
#' allow for census tract-to-governmental unit relationships where the
#' governmental boundaries tend to remain unchanged between censuses. State and
#' county boundaries always are census tract boundaries in the standard census
#' geographic hierarchy. Tribal census tracts are a unique geographic entity
#' defined within federally recognized American Indian reservations and
#' off-reservation trust lands and can cross state and county boundaries. The
#' tribal census tracts may be completely different from the standard
#' county-based census tracts defined for the same area."*
#'
#' @format
#' `tract_sf` is a multipolygon `sf` object with `r nrow(tract_sf)` rows and
#' `r ncol(tract_sf)` variables:
#' \describe{
#'   \item{geoid_tract}{Unique 11-digit tract ID, assigned by the Census
#'   Bureau. Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the tract is in.
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
#' # Display the tracts with ggplot2
#' library(ggplot2)
#' ggplot(tract_sf) + geom_sf(lwd = 0.1) + theme_void()
"tract_sf"

#' Census Public Use Microdata Areas (PUMAs)
#'
#' The Census PUMAs covering the 7-county Chicago Metropolitan Agency for
#' Planning (CMAP) region. From the US Census Bureau's TIGER/Line shapefiles,
#' 2022 vintage.
#'
#' Census Bureau description:
#'
#' *"Public Use Microdata Areas (PUMAs) are geographic areas for which the
#' Census Bureau provides selected extracts of raw data from a small sample of
#' census records that are screened to protect confidentiality. These extracts
#' are referred to as public use microdata sample (PUMS) files.*
#'
#' *"PUMAs are statistical geographic areas defined for the tabulation and
#' dissemination of American Community Survey (ACS) and Puerto Rico Community
#' Survey Public Use Microdata Sample (PUMS) data as well as ACS period
#' estimates, and decennial census data. Nesting within states or equivalent
#' entities, PUMAs cover the entirety of the United States, Puerto Rico, Guam,
#' and the U.S. Virgin Islands. PUMA delineations are subject to population
#' threshold criteria, “building block” geography criteria, and geographic
#' nesting criteria. State Data Centers (SDCs) define PUMAs with the cooperation
#' of regional, state, local, and tribal governments, organizations, and other
#' interested data users. Each PUMA must have a minimum population of 100,000 at
#' the time of delineation and throughout the decade.*
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


#' Census ZIP Code Tabulation Areas (ZCTAs)
#'
#' The Census ZCTAs covering the 7-county Chicago Metropolitan Agency for
#' Planning (CMAP) region. From the US Census Bureau's TIGER/Line shapefiles,
#' 2022 vintage.
#'
#' Census Bureau description:
#'
#' *"ZIP Code Tabulation Areas (ZCTAs) are approximate area representations of
#' U.S. Postal Service (USPS) five-digit ZIP Code service areas that the Census
#' Bureau creates using whole blocks to present statistical data from censuses
#' and surveys. The Census Bureau defines ZCTAs by allocating each block that
#' contains addresses to a single ZCTA, usually to the ZCTA that reflects the
#' most frequently occurring ZIP Code for the addresses within that tabulation
#' block. Blocks that do not contain addresses but are completely surrounded by
#' a single ZCTA (enclaves) are assigned to the surrounding ZCTA; those
#' surrounded by multiple ZCTAs will be added to a single ZCTA based on limited
#' buffering performed between multiple ZCTAs. The Census Bureau identifies
#' five-digit ZCTAs using a five-character numeric code that represents the most
#' frequently occurring USPS ZIP Code within that ZCTA, and this code may
#' contain leading zeros. Not all ZIP Codes in use by the USPS may have a ZCTA
#' delineated to represent them, The USPS makes periodic changes to ZIP Codes to
#' support more efficient mail delivery. In addition, the ZCTA delineation
#' process primarily uses residential addresses and has a bias towards ZIP Codes
#' used for city-style mail delivery, thus there may be ZIP Codes that are
#' primarily nonresidential or used for PO boxes only that may not have a
#' corresponding ZCTA. ZIP Code is a trademark of the U.S. Postal Service."*
#'
#' @format
#' A multipolygon `sf` object with `r nrow(zcta_sf)` rows and `r ncol(zcta_sf)`
#' variables:
#' \describe{
#'   \item{geoid_zcta}{Unique 5-digit ZCTA ID, corresponding to a 5-digit USPS
#'   ZIP Code. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source
#' US Census Bureau
#' [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
#'
#' @examples
#' # Display the ZCTAs with ggplot2
#' library(ggplot2)
#' ggplot(zcta_sf) + geom_sf(lwd = 0.1) + theme_void()
"zcta_sf"


#' Illinois State Senate Districts
#'
#' The Illinois General Assembly Senate Districts. From the US Census Bureau's
#' TIGER/Line shapefiles, 2022 vintage. **These districts were in effect for
#' elections from 2012 through 2020 (i.e. the 98th through 102nd General
#' Assemblies). They will be superseded by new district boundaries for the 2022
#' election (for the 103rd General Assembly). Updated shapefiles from the Census
#' Bureau are expected in spring 2023.**
#'
#' Census Bureau description:
#'
#' *"State Legislative Districts (SLDs) are the areas from which members are
#' elected to state legislatures. The Census Bureau first reported data for SLDs
#' as part of the 2000 Public Law (P.L.) 94-171 Redistricting Data File.*
#'
#' *"Current SLDs (2018 Election Cycle)—States participating in Phase 4 of the
#' 2020 Census Redistricting Data Program voluntarily provided the Census Bureau
#' with the 2018 election cycle boundaries, codes, and, in some cases, names for
#' their SLDs. All 50 states, plus the District of Columbia and Puerto Rico,
#' participated in Phase 4's State Legislative District Project (SLDP) of the
#' 2020 Census Redistricting Data Program. States subsequently provided
#' corrections to those plans through the Redistricting Data Office during Phase
#' 2 of the 2020 Census Redistricting Data Program, if needed.
#'
#' "The SLDs embody the upper (senate—SLDU) and lower (house—SLDL) chambers of
#' the state legislature. A unique three-character census code, identified by
#' state participants, is assigned to each SLD within a state. In some states,
#' state officials did not define the SLDs to cover all of the state or state
#' equivalent area (usually bodies of water). In these areas with no SLDs
#' defined, the code 'ZZZ' has been assigned, which is treated within state as a
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
#' TIGER/Line shapefiles, 2022 vintage. **These districts were in effect for
#' elections from 2012 through 2020 (i.e. the 98th through 102nd General
#' Assemblies). They will be superseded by new district boundaries for the 2022
#' election (for the 103rd General Assembly). As with Illinois State Senate
#' districts, updated files are expected from the Census Bureau in spring
#' 2023.**
#'
#' Census Bureau description:
#'
#' *"State Legislative Districts (SLDs) are the areas from which members are
#' elected to state legislatures. The Census Bureau first reported data for SLDs
#' as part of the 2000 Public Law (P.L.) 94-171 Redistricting Data File.*
#'
#' *"Current SLDs (2018 Election Cycle)—States participating in Phase 4 of the
#' 2020 Census Redistricting Data Program voluntarily provided the Census Bureau
#' with the 2018 election cycle boundaries, codes, and, in some cases, names for
#' their SLDs. All 50 states, plus the District of Columbia and Puerto Rico,
#' participated in Phase 4's State Legislative District Project (SLDP) of the
#' 2020 Census Redistricting Data Program. States subsequently provided
#' corrections to those plans through the Redistricting Data Office during Phase
#' 2 of the 2020 Census Redistricting Data Program, if needed.
#'
#' "The SLDs embody the upper (senate—SLDU) and lower (house—SLDL) chambers of
#' the state legislature. A unique three-character census code, identified by
#' state participants, is assigned to each SLD within a state. In some states,
#' state officials did not define the SLDs to cover all of the state or state
#' equivalent area (usually bodies of water). In these areas with no SLDs
#' defined, the code 'ZZZ' has been assigned, which is treated within state as a
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
#' US Census Bureau's TIGER/Line shapefiles, 2022 vintage. **These districts
#' were in effect for elections from 2012 through 2020 (i.e. the 113th through
#' 117th Congresses). They will be superseded by new district boundaries for the
#' 2022 election (for the 118th Congress). Updates are expected in spring 2023.**
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
#' @format A multipolygon `sf` object with `r nrow(congress_sf)` rows and
#' `r ncol(congress_sf)` variables:
#' \describe{
#'   \item{dist_num}{Congressional District number. Integer.}
#'   \item{dist_name}{Name of the district (full). Character.}
#'   \item{dist_name_short}{Name of the district (short). Character.}
#'   \item{cmap}{Does the district overlap the 7-county CMAP region? Logical.}
#'   \item{sqmi}{Area in square miles. Double.} \item{geometry}{Feature
#'   geometry. `sf` multipolygon.}
#' }
#'
#' @source US Census Bureau
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
#' TIGER/Line shapefiles, 2022 vintage.
#'
#' Census Bureau description:
#'
#' *"Incorporated Places are those reported to the Census Bureau as legally in
#' existence as of January 1, as reported in the latest Boundary and Annexation
#' Survey (BAS), under the laws of their respective states. An incorporated
#' place is established to provide governmental functions for a concentration of
#' people as opposed to a minor civil division (MCD), which generally is created
#' to provide services or administer an area without regard, necessarily, to
#' population. Places always are within a single state or equivalent entity, but
#' may extend across county and county subdivision boundaries. An incorporated
#' place usually is a city, town, village, or borough, but can have other legal
#' descriptions."*
#'
#' @format A multipolygon `sf` object with `r nrow(municipality_sf)` rows and
#' `r ncol(municipality_sf)` variables:
#' \describe{
#'   \item{geoid_place}{Unique 7-digit place/municipality ID, assigned by the
#'   Census Bureau. Character.}
#'   \item{municipality}{Municipality name. Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` multipolygon.}
#' }
#'
#' @source US Census Bureau
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
#' US Census Bureau's TIGER/Line shapefiles, 2022 vintage.
#'
#' Census Bureau description:
#'
#' *"County Subdivisions are the primary divisions of counties and equivalent
#' entities. They include census county divisions, census subareas, minor civil
#' divisions, and unorganized territories and can be classified as either legal
#' or statistical. Each county subdivision is assigned a five-character numeric
#' Federal Information Processing Series (FIPS) code based on alphabetical
#' sequence within state, and an eight-digit National Standard (NS) code."*
#'
#' Note: The entire City of Chicago (other than the portion of O'Hare in DuPage
#' County) is included as a single township in this dataset, and has not been
#' subdivided into the eight theoretical townships defined by the Cook County
#' Clerk's Office for the purposes of collecting property tax.
#'
#' @format A multipolygon `sf` object with `r nrow(township_sf)` rows and
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
#' @source US Census Bureau
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
#' Census Bureau's TIGER/Line shapefiles, 2022 vintage.
#'
#' Census Bureau description:
#'
#' *"The primary legal divisions of most states are termed counties. Each county
#' or statistically equivalent entity is assigned a three-character numeric
#' Federal Information Processing Series (FIPS) code based on alphabetical
#' sequence that is unique within state, and an eight-digit National Standard
#' (NS) code."*
#'
#' Note: The Illinois counties of LaSalle, Lee and Ogle are included in their
#' entirety, although only portions of these counties are part of the CMAP
#' travel modeling area. The precise geographic extent of the CMAP travel
#' modeling area is reflected in `zone_sf` and `subzone_sf`.
#'
#' @format A polygon `sf` object with `r nrow(county_sf)` rows and
#' `r ncol(county_sf)` variables:
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
#' shapefiles, 2022 vintage.
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
#' The official boundaries of the Chicago Community Areas. Obtained 2/12/2023.
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
#' The official boundaries of the Chicago wards established in May of 2015.
#' Obtained 2/12/2023. Updated boundaries will be provided once the 2023 wards
#' come into effect in May 2023.
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
#' [CMAP Data Hub (temporarily offline)](https://datahub.cmap.illinois.gov/dataset/cmap-metropolitan-planning-area-september-2014)
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
#' It is important to note here that the portions of COM boundaries defined by
#' municipalities are fluid: they change as a village annexes adjacent
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
#' [CMAP Data Hub (temporarily offline)](https://datahub.cmap.illinois.gov/dataset/councils-of-mayors-boundaries)
#'
#' @seealso
#' <https://www.cmap.illinois.gov/committees/advisory/council-of-mayors/subregional-councils>
#'
#' @examples
#' # Display the COMs with ggplot2
#' library(ggplot2)
#' ggplot(com_sf) + geom_sf(lwd = 0.1) + theme_void()
"com_sf"


#' CMAP Economically Disconnected and Disinvested Areas
#'
#' To advance [ON TO 2050](https://www.cmap.illinois.gov/2050)'s commitment to
#' inclusive growth, CMAP has defined Economically Disconnected and Disinvested
#' Areas within the region. These classifications have been made at the Census
#' tract level, covering the 7-county CMAP region. Economically Disconnected
#' Areas (EDAs) are areas that describe population-based estimates of
#' concentrated low-income and minority status, whereas disinvested areas
#' outline places with long-term declines in employment and other markers of
#' commercial market weakness. Together, these communities experience a
#' persistent, long-term lack of market investment, leading to declining
#' property values, taxes, employment, and, frequently, population.
#' Disinvestment often constrains the ability of any individual community to
#' respond effectively to these losses, and high tax rates and low market
#' potential limit private investment.
#'
#' @format
#' A polygon `sf` object with `r nrow(eda_sf)` rows and `r ncol(eda_sf)`
#' variables:
#' \describe{
#'   \item{geoid_tract}{Unique 11-digit tract ID, assigned by the Census
#'   Bureau. **These correspond to tract boundaries from 2010, not 2020.**
#'   Character.}
#'   \item{county_fips}{Unique 5-digit FIPS code of the county the tract is in.
#'   Character.}
#'   \item{area_type}{Description of the tract's combined EDA and disinvested
#'   status. Character.}
#'   \item{eda}{Is the tract an Economically Disconnected Area (EDA)? Logical.}
#'   \item{disinvested}{Is the tract a disinvested area? Logical.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source
#' [CMAP Data Hub (temporarily offline)](https://datahub.cmap.illinois.gov/dataset/on-to-2050-layer-edas-disinvested-areas)
#'
#' @seealso
#' <https://www.cmap.illinois.gov/2050/maps/eda>
#'
#' @examples
#' # Display the EDAs and disinvested areas with ggplot2
#' library(ggplot2)
#' ggplot(eda_sf) + geom_sf(aes(fill = area_type), lwd = 0.1) + theme_void()
"eda_sf"


#' CMAP Facility Planning Areas (FPAs)
#'
#' This dataset represents wastewater service boundaries (Facility Planning
#' Areas, or FPAs) approved by IEPA as of 1 April 2014, after which IEPA ceased
#' approving FPA boundaries. No updates to this data set have occurred since
#' that date, and no additional updates are anticipated.
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
#' [CMAP Data Hub (temporarily offline)](https://datahub.cmap.illinois.gov/dataset/facility-planning-areas-fpa)
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
#' [CMAP Data Hub (temporarily offline)](https://datahub.cmap.illinois.gov/dataset/cmap-modeling-zone-systems)
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
#' [CMAP Data Hub (temporarily offline)](https://datahub.cmap.illinois.gov/dataset/cmap-modeling-zone-systems)
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
#' among Chicago Community Areas (CCAs). Separate factors are provided for
#' apportioning housing unit, household, and population attributes. All factors
#' were determined by calculating the percentage of a tract's housing units,
#' households and population that were located in each of its component blocks,
#' according to the 2020 Decennial Census, and then assigning each block to a
#' CCA (based on the location of the block's centroid point). **Use
#' `xwalk_tract2cca` for data from the 2020 decennial census or the American
#' Community Survey (ACS) from 2020 onward. For data from the 2010 decennial
#' census or ACS from 2010 through 2019, use `xwalk_tract2cca_2010`.**
#'
#' Generally speaking, tract boundaries align neatly with CCA boundaries as they
#' tend to follow similar features (e.g. rivers, major roads, rail lines) but
#' there are cases where the jobs, population, households and/or housing units
#' in a tract are split across multiple CCAs, or else are partially within the
#' City of Chicago and partially outside of it. For that reason, it is not
#' appropriate to use a one-to-one tract-to-CCA assignment to apportion Census
#' data among CCAs, and this crosswalk should be used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since tract IDs appear multiple times in this table). Once the
#' data is joined, it should be multiplied by the appropriate factor (depending
#' whether the data of interest is measured at the housing unit, household,
#' person or job level), and then the result should be summed by CCA. If
#' calculating rates, this should only be done after the counts have been summed
#' to CCA. The resulting table can then be joined to `cca_sf` for mapping, if
#' desired.
#'
#' If your data is also available at the block group level, it is recommended
#' that you use that with `xwalk_blockgroup2cca` instead of the tract-level
#' allocation.
#'
#' @format
#' `xwalk_tract2cca` is a tibble with `r nrow(xwalk_tract2cca)` rows and
#' `r ncol(xwalk_tract2cca)` variables:
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
#'   \item{emp_pct}{Proportion of the tract's total jobs located in the
#'   specified CCA. Multiply this by a tract-level measure of an employment
#'   attribute (e.g. retail jobs) to estimate the CCA's portion.
#'   **Not available in `xwalk_tract2cca_2010`.** Double.}
#' }
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#'
#' # View the tracts with population split between multiple CCAs
#' filter(xwalk_tract2cca, pop_pct < 1)
#'
#' # Estimate CCA-level population density from tract-level Census data
#' df_tract <- tidycensus::get_decennial(
#'   geography = "tract", variables = c("P1_001N"),
#'   year = 2020, state = "IL", county = c("031", "043"), output = "wide"
#' ) %>%
#'   suppressMessages() %>%  # Hide tidycensus messages
#'   select(geoid_tract = GEOID, pop = P1_001N)
#'
#' df_cca <- xwalk_tract2cca %>%
#'   left_join(df_tract, by = "geoid_tract") %>%
#'   mutate(pop = pop * pop_pct) %>%
#'   group_by(cca_num) %>%
#'   summarize(pop = sum(pop))
#' df_cca
#'
#' # Join to cca_sf for mapping
#' library(ggplot2)
#' cca_sf %>%
#'   left_join(df_cca, by = "cca_num") %>%
#'   ggplot() +
#'     geom_sf(aes(fill = pop / sqmi), lwd = 0.1) +
#'     scale_fill_viridis_c(direction = -1) +
#'     theme_void()
"xwalk_tract2cca"

#' @rdname xwalk_tract2cca
#' @format `xwalk_tract2cca_2010` is a tibble with
#' `r nrow(xwalk_tract2cca_2010)` rows and `r ncol(xwalk_tract2cca_2010)`
#' variables (no `emp_pct`).
"xwalk_tract2cca_2010"


#' Block Group-to-CCA Crosswalk
#'
#' This table contains a set of factors to apportion Census block group-level
#' data among Chicago Community Areas (CCAs). Separate factors are provided for
#' apportioning housing unit, household, and population attributes. All factors
#' were determined by calculating the percentage of a block group's housing
#' units, households and population that were located in each of its component
#' blocks, according to the 2020 Decennial Census, and then assigning each block
#' to a CCA (based on the location of the block's centroid point). **Use
#' `xwalk_blockgroup2cca` for data from the 2020 decennial census or the
#' American Community Survey (ACS) from 2020 onward. For data from the 2010
#' decennial census or ACS from 2010 through 2019, use
#' `xwalk_blockgroup2cca_2010`.**
#'
#' Generally speaking, block group boundaries align neatly with CCA boundaries
#' as they tend to follow similar features (e.g. rivers, major roads, rail
#' lines) but there are cases where the jobs, population, households and/or
#' housing units in a block group are split across multiple CCAs, or else are
#' partially within the City of Chicago and partially outside of it. For that
#' reason, it is not appropriate to use a one-to-one block group-to-CCA
#' assignment to apportion Census data among CCAs, and this crosswalk should be
#' used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since block group IDs appear multiple times in this table). Once
#' the data is joined, it should be multiplied by the appropriate factor
#' (depending whether the data of interest is measured at the housing unit,
#' household, person or job level), and then the result should be summed by CCA.
#' If calculating rates, this should only be done after the counts have been
#' summed to CCA. The resulting table can then be joined to `cca_sf` for
#' mapping, if desired.
#'
#' If your data is only available at the tract level, you can use
#' `xwalk_tract2cca` for a tract-level allocation instead.
#'
#' @format
#' `xwalk_blockgroup2cca` is a tibble with `r nrow(xwalk_blockgroup2cca)` rows
#' and `r ncol(xwalk_blockgroup2cca)` variables:
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
#'   \item{emp_pct}{Proportion of the block group's total jobs located in the
#'   specified CCA. Multiply this by a block group-level measure of an
#'   employment attribute (e.g. retail jobs) to estimate the CCA's portion.
#'   **Not available in `xwalk_blockgroup2cca_2010`.** Double.}
#' }
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#'
#' # View the block groups with housing units split between multiple CCAs
#' filter(xwalk_blockgroup2cca, hu_pct < 1)
#'
#' # Estimate CCA-level housing vacancy rates from block group-level Census data
#' df_blkgrp <- tidycensus::get_decennial(
#'   geography = "block group", variables = c("H1_001N", "H1_003N"),
#'   year = 2020, state = "IL", county = c("031", "043"), output = "wide"
#' ) %>%
#'   suppressMessages() %>%  # Hide tidycensus messages
#'   select(geoid_blkgrp = GEOID, hu_tot = H1_001N, hu_vac = H1_003N)
#'
#' df_cca <- xwalk_blockgroup2cca %>%
#'   left_join(df_blkgrp, by = "geoid_blkgrp") %>%
#'   mutate(hu_tot = hu_tot * hu_pct,
#'          hu_vac = hu_vac * hu_pct) %>%
#'   group_by(cca_num) %>%
#'   summarize_at(vars(hu_tot, hu_vac), sum) %>%
#'   mutate(vac_rate = hu_vac / hu_tot)
#' df_cca
#'
#' # Join to cca_sf for mapping
#' library(ggplot2)
#' cca_sf %>%
#'   left_join(df_cca, by = "cca_num") %>%
#'   ggplot() +
#'     geom_sf(aes(fill = vac_rate), lwd = 0.1) +
#'     scale_fill_viridis_c(direction = -1) +
#'     theme_void()
"xwalk_blockgroup2cca"

#' @rdname xwalk_blockgroup2cca
#' @format `xwalk_blockgroup2cca_2010` is a tibble with
#' `r nrow(xwalk_blockgroup2cca_2010)` rows and
#' `r ncol(xwalk_blockgroup2cca_2010)` variables (no `emp_pct`).
"xwalk_blockgroup2cca_2010"


#' Tract-to-Subzone Crosswalk
#'
#' This table contains a set of factors to apportion Census tract-level data
#' among the CMAP travel modeling subzones. Separate factors are provided for
#' apportioning housing unit, household, and population attributes. All factors
#' were determined by calculating the percentage of a tract's housing units,
#' households and population that were located in each of its component blocks,
#' according to the 2020 Decennial Census, and then assigning each block to a
#' subzone (based on the location of the block's centroid point). Subzones that
#' do not contain the centroid of any blocks with at least one housing unit,
#' household, person or job are *not* present in this table. **Use
#' `xwalk_tract2subzone` for data from the 2020 decennial census or the American
#' Community Survey (ACS) from 2020 onward. For data from the 2010 decennial
#' census or ACS from 2010 through 2019, use `xwalk_tract2subzone_2010`.**
#'
#' Other than in certain areas of Chicago, tracts tend to be significantly
#' larger than subzones and have highly irregular boundaries, so in most cases
#' the jobs, population, households and/or housing units in a tract are split
#' across multiple subzones. For that reason, it is not appropriate to use a
#' one-to-one tract-to-subzone assignment to apportion Census data among
#' subzones, and this crosswalk should be used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since tract IDs appear multiple times in this table). Once the
#' data is joined, it should be multiplied by the appropriate factor (depending
#' whether the data of interest is measured at the housing unit, household,
#' person or job level), and then the result should be summed by subzone ID. If
#' calculating rates, this should only be done after the counts have been summed
#' to subzone. The resulting table can then be joined to `subzone_sf` for
#' mapping, if desired.
#'
#' If your data is also available at the block group level, it is recommended
#' that you use that with `xwalk_blockgroup2subzone` instead of the tract-level
#' allocation. If the subzone geography is too granular for your needs, you can
#' use zones instead with `xwalk_tract2zone` or `xwalk_blockgroup2zone`.
#'
#' @format
#' `xwalk_tract2subzone` is a tibble with `r nrow(xwalk_tract2subzone)` rows and
#' `r ncol(xwalk_tract2subzone)` variables:
#' \describe{
#'   \item{geoid_tract}{Unique 11-digit tract ID, assigned by the Census Bureau.
#'   Corresponds to `tract_sf` (although that only includes the tracts in the
#'   7-county CMAP region). Character.}
#'   \item{subzone17}{Numeric subzone ID. Corresponds to `subzone_sf`. Integer.}
#'   \item{hu_pct}{Proportion of the tract's housing units (occupied or vacant)
#'   located in the specified subzone. Multiply this by a tract-level measure of
#'   a housing attribute (e.g. vacant homes) to estimate the subzone's portion.
#'   Double.}
#'   \item{hh_pct}{Proportion of the tract's households (i.e. occupied housing
#'   units) living in the specified subzone. Multiply this by a tract-level
#'   measure of a household attribute (e.g. car-free households) to estimate the
#'   subzone's portion. Double.}
#'   \item{pop_pct}{Proportion of the tract's total population (including group
#'   quarters) living in the specified subzone. Multiply this by a tract-level
#'   measure of a population attribute (e.g. race/ethnicity) to estimate the
#'   subzone's portion. Double.}
#'   \item{emp_pct}{Proportion of the tract's total jobs located in the
#'   specified subzone. Multiply this by a tract-level measure of an employment
#'   attribute (e.g. retail jobs) to estimate the subzone's portion.
#'   **Not available in `xwalk_tract2subzone_2010`.** Double.}
#' }
#'
#' @examples
#' # View the tract allocations for subzone17 == 1
#' dplyr::filter(xwalk_tract2subzone, subzone17 == 1)
#'
#' # Map the subzones missing from xwalk_tract2subzone (i.e. no HU/HH/pop/emp)
#' library(ggplot2)
#' ggplot(dplyr::anti_join(subzone_sf, xwalk_tract2subzone)) +
#'   geom_sf(fill = "red", lwd = 0.1) +
#'   geom_sf(data = subzone_sf, fill = NA, lwd = 0.1) +
#'   theme_void()
"xwalk_tract2subzone"

#' @rdname xwalk_tract2subzone
#' @format `xwalk_tract2subzone_2010` is a tibble with
#' `r nrow(xwalk_tract2subzone_2010)` rows and
#' `r ncol(xwalk_tract2subzone_2010)` variables (no `emp_pct`).
"xwalk_tract2subzone_2010"


#' Block Group-to-Subzone Crosswalk
#'
#' This table contains a set of factors to apportion Census block group-level
#' data among the CMAP travel modeling subzones. Separate factors are provided
#' for apportioning housing unit, household, and population attributes. All
#' factors were determined by calculating the percentage of a block group's
#' housing units, households and population that were located in each of its
#' component blocks, according to the 2020 Decennial Census, and then assigning
#' each block to a subzone (based on the location of the block's centroid
#' point). Subzones that do not contain the centroid of any blocks with at least
#' one housing unit, household, person or job are *not* present in this table.
#' **Use `xwalk_blockgroup2subzone` for data from the 2020 decennial census or
#' the American Community Survey (ACS) from 2020 onward. For data from the 2010
#' decennial census or ACS from 2010 through 2019, use
#' `xwalk_blockgroup2subzone_2010`.**
#'
#' Other than in certain areas of Chicago, block groups tend to be significantly
#' larger than subzones and have highly irregular boundaries, so in most cases
#' the jobs, population, households and/or housing units in a block group are
#' split across multiple subzones. For that reason, it is not appropriate to use
#' a one-to-one block group-to-subzone assignment to apportion Census data among
#' subzones, and this crosswalk should be used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since block group IDs appear multiple times in this table). Once
#' the data is joined, it should be multiplied by the appropriate factor
#' (depending whether the data of interest is measured at the housing unit,
#' household, person or job level), and then the result should be summed by
#' subzone ID. If calculating rates, this should only be done after the counts
#' have been summed to subzone. The resulting table can then be joined to
#' `subzone_sf` for mapping, if desired.
#'
#' If your data is only available at the tract level, you can use
#' `xwalk_tract2subzone` for a tract-level allocation instead. If the subzone
#' geography is too granular for your needs, you can use zones instead with
#' `xwalk_blockgroup2zone` or `xwalk_tract2zone`.
#'
#' @format
#' `xwalk_blockgroup2subzone` is a tibble with
#' `r nrow(xwalk_blockgroup2subzone)` rows and
#' `r ncol(xwalk_blockgroup2subzone)` variables:
#' \describe{
#'   \item{geoid_blkgrp}{Unique 12-digit block group ID, assigned by the Census
#'   Bureau. Corresponds to `blockgroup_sf` (although that only includes the
#'   block groups in the 7-county CMAP region). Character.}
#'   \item{subzone17}{Numeric subzone ID. Corresponds to `subzone_sf`. Integer.}
#'   \item{hu_pct}{Proportion of the block group's housing units (occupied or
#'   vacant) located in the specified subzone. Multiply this by a block
#'   group-level measure of a housing attribute (e.g. vacant homes) to estimate
#'   the subzone's portion. Double.}
#'   \item{hh_pct}{Proportion of the block group's households (i.e. occupied
#'   housing units) living in the specified subzone. Multiply this by a block
#'   group-level measure of a household attribute (e.g. car-free households) to
#'   estimate the subzone's portion. Double.}
#'   \item{pop_pct}{Proportion of the block group's total population (including
#'   group quarters) living in the specified subzone. Multiply this by a block
#'   group-level measure of a population attribute (e.g. race/ethnicity) to
#'   estimate the subzone's portion. Double.}
#'   \item{emp_pct}{Proportion of the block group's total jobs located in the
#'   specified subzone. Multiply this by a block group-level measure of an
#'   employment attribute (e.g. retail jobs) to estimate the subzone's portion.
#'   **Not available in `xwalk_blockgroup2subzone_2010`.** Double.}
#' }
#'
#' @examples
#' # View the block group allocations for subzone17 == 1
#' dplyr::filter(xwalk_blockgroup2subzone, subzone17 == 1)
#'
#' # Map the subzones missing from xwalk_blockgroup2subzone (i.e. no HU/HH/pop/emp)
#' library(ggplot2)
#' ggplot(dplyr::anti_join(subzone_sf, xwalk_blockgroup2subzone)) +
#'   geom_sf(fill = "red", lwd = 0.1) +
#'   geom_sf(data = subzone_sf, fill = NA, lwd = 0.1) +
#'   theme_void()
"xwalk_blockgroup2subzone"

#' @rdname xwalk_blockgroup2subzone
#' @format `xwalk_blockgroup2subzone_2010` is a tibble with
#' `r nrow(xwalk_blockgroup2subzone_2010)` rows and
#' `r ncol(xwalk_blockgroup2subzone_2010)` variables (no `emp_pct`).
"xwalk_blockgroup2subzone_2010"


#' Tract-to-Zone Crosswalk
#'
#' This table contains a set of factors to apportion Census tract-level data
#' among the CMAP travel modeling zones. Separate factors are provided for
#' apportioning housing unit, household, and population attributes. All factors
#' were determined by calculating the percentage of a tract's housing units,
#' households and population that were located in each of its component blocks,
#' according to the 2020 Decennial Census, and then assigning each block to a
#' zone (based on the location of the block's centroid point). Zones that do not
#' contain the centroid of any blocks with at least one housing unit, household,
#' person or job are *not* present in this table. **Use `xwalk_tract2zone` for
#' data from the 2020 decennial census or the American Community Survey (ACS)
#' from 2020 onward. For data from the 2010 decennial census or ACS from 2010
#' through 2019, use `xwalk_tract2zone_2010`.**
#'
#' Other than in certain areas of Chicago, tracts tend to be larger than zones
#' and have highly irregular boundaries, so in most cases the jobs, population,
#' households and/or housing units in a tract are split across multiple zones.
#' For that reason, it is not appropriate to use a one-to-one tract-to-zone
#' assignment to apportion Census data among zones, and this crosswalk should be
#' used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since tract IDs appear multiple times in this table). Once the
#' data is joined, it should be multiplied by the appropriate factor (depending
#' whether the data of interest is measured at the housing unit, household,
#' person or job level), and then the result should be summed by zone ID. If
#' calculating rates, this should only be done after the counts have been summed
#' to zone. The resulting table can then be joined to `zone_sf` for mapping, if
#' desired.
#'
#' If your data is also available at the block group level, it is recommended
#' that you use that with `xwalk_blockgroup2zone` instead of the tract-level
#' allocation. If the zone geography is too coarse for your needs, you can use
#' subzones instead with `xwalk_tract2subzone` or `xwalk_blockgroup2subzone`.
#'
#' @format
#' `xwalk_tract2zone` is a tibble with `r nrow(xwalk_tract2zone)` rows and
#' `r ncol(xwalk_tract2zone)` variables:
#' \describe{
#'   \item{geoid_tract}{Unique 11-digit tract ID, assigned by the Census Bureau.
#'   Corresponds to `tract_sf` (although that only includes the tracts in the
#'   7-county CMAP region). Character.}
#'   \item{zone17}{Numeric zone ID. Corresponds to `zone_sf`. Integer.}
#'   \item{hu_pct}{Proportion of the tract's housing units (occupied or vacant)
#'   located in the specified zone. Multiply this by a tract-level measure of a
#'   housing attribute (e.g. vacant homes) to estimate the zone's portion.
#'   Double.}
#'   \item{hh_pct}{Proportion of the tract's households (i.e. occupied housing
#'   units) living in the specified zone. Multiply this by a tract-level measure
#'   of a household attribute (e.g. car-free households) to estimate the zone's
#'   portion. Double.}
#'   \item{pop_pct}{Proportion of the tract's total population (including group
#'   quarters) living in the specified zone. Multiply this by a tract-level
#'   measure of a population attribute (e.g. race/ethnicity) to estimate the
#'   zone's portion. Double.}
#'   \item{emp_pct}{Proportion of the tracts's total jobs located in the
#'   specified zone. Multiply this by a tract-level measure of an employment
#'   attribute (e.g. retail jobs) to estimate the zone's portion.
#'   **Not available in `xwalk_tract2zone_2010`.** Double.}
#' }
#'
#' @examples
#' # View the tract allocations for zone17 == 55
#' dplyr::filter(xwalk_tract2zone, zone17 == 55)
#'
#' # Map the zones missing from xwalk_tract2zone (i.e. no HU/HH/pop/emp)
#' library(ggplot2)
#' ggplot(dplyr::anti_join(zone_sf, xwalk_tract2zone)) +
#'   geom_sf(fill = "red", lwd = 0.1) +
#'   geom_sf(data = zone_sf, fill = NA, lwd = 0.1) +
#'   theme_void()
"xwalk_tract2zone"

#' @rdname xwalk_tract2zone
#' @format `xwalk_tract2zone_2010` is a tibble with
#' `r nrow(xwalk_tract2zone_2010)` rows and `r ncol(xwalk_tract2zone_2010)`
#' variables (no `emp_pct`).
"xwalk_tract2zone_2010"


#' Block Group-to-Zone Crosswalk
#'
#' This table contains a set of factors to apportion Census block group-level
#' data among the CMAP travel modeling zones. Separate factors are provided for
#' apportioning housing unit, household, population and employment attributes.
#' All factors were determined by calculating the percentage of a block group's
#' housing units, households, population and employment that were located in
#' each of its component blocks, according to the 2020 Decennial Census and 2019
#' LEHD, and then assigning each block to a zone (based on the location of the
#' block's centroid point). Zones that do not contain the centroid of any blocks
#' with at least one housing unit, household, person or job are *not* present in
#' this table. **Use `xwalk_blockgroup2zone` for data from the 2020 decennial
#' census or the American Community Survey (ACS) from 2020 onward. For data from
#' the 2010 decennial census or ACS from 2010 through 2019, use
#' `xwalk_blockgroup2zone_2010`.**
#'
#' Other than in certain areas of Chicago, block groups tend to be larger than
#' zones and have highly irregular boundaries, so in most cases the jobs,
#' population, households and/or housing units in a block group are split across
#' multiple zones. For that reason, it is not appropriate to use a one-to-one
#' block group-to-zone assignment to apportion Census data among zones, and this
#' crosswalk should be used instead.
#'
#' To use this crosswalk effectively, Census data should be joined to it (not
#' vice versa, since block group IDs appear multiple times in this table). Once
#' the data is joined, it should be multiplied by the appropriate factor
#' (depending whether the data of interest is measured at the housing unit,
#' household, person or job level), and then the result should be summed by zone
#' ID. If calculating rates, this should only be done after the counts have been
#' summed to zone. The resulting table can then be joined to `zone_sf` for
#' mapping, if desired.
#'
#' If your data is only available at the tract level, you can use
#' `xwalk_tract2zone` for a tract-level allocation instead. If the zone
#' geography is too coarse for your needs, you can use subzones instead with
#' `xwalk_blockgroup2subzone` or `xwalk_tract2subzone`.
#'
#' @format
#' `xwalk_blockgroup2zone` is a tibble with `r nrow(xwalk_blockgroup2zone)` rows
#' and `r ncol(xwalk_blockgroup2zone)` variables:
#' \describe{
#'   \item{geoid_blkgrp}{Unique 12-digit block group ID, assigned by the Census
#'   Bureau. Corresponds to `blockgroup_sf` (although that only includes the
#'   block groups in the 7-county CMAP region). Character.}
#'   \item{zone17}{Numeric zone ID. Corresponds to `zone_sf`. Integer.}
#'   \item{hu_pct}{Proportion of the block group's housing units (occupied or
#'   vacant) located in the specified zone. Multiply this by a block group-level
#'   measure of a housing attribute (e.g. vacant homes) to estimate the zone's
#'   portion. Double.}
#'   \item{hh_pct}{Proportion of the block group's households (i.e. occupied
#'   housing units) living in the specified zone. Multiply this by a block
#'   group-level measure of a household attribute (e.g. car-free households) to
#'   estimate the zone's portion. Double.}
#'   \item{pop_pct}{Proportion of the block group's total population (including
#'   group quarters) living in the specified zone. Multiply this by a block
#'   group-level measure of a population attribute (e.g. race/ethnicity) to
#'   estimate the zone's portion. Double.}
#'   \item{emp_pct}{Proportion of the block group's total jobs located in the
#'   specified zone. Multiply this by a block group-level measure of an
#'   employment attribute (e.g. retail jobs) to estimate the zone's portion.
#'   **Not available in `xwalk_blockgroup2zone_2010`.** Double.}
#' }
#'
#' @examples
#' # View the block group allocations for zone17 == 55
#' dplyr::filter(xwalk_blockgroup2zone, zone17 == 55)
#'
#' # Map the zones missing from xwalk_blockgroup2zone (i.e. no HU/HH/pop/emp)
#' library(ggplot2)
#' ggplot(dplyr::anti_join(zone_sf, xwalk_blockgroup2zone)) +
#'   geom_sf(fill = "red", lwd = 0.1) +
#'   geom_sf(data = zone_sf, fill = NA, lwd = 0.1) +
#'   theme_void()
"xwalk_blockgroup2zone"

#' @rdname xwalk_blockgroup2zone
#' @format `xwalk_blockgroup2zone_2010` is a tibble with
#' `r nrow(xwalk_blockgroup2zone_2010)` rows and
#' `r ncol(xwalk_blockgroup2zone_2010)` variables (no `emp_pct`).
"xwalk_blockgroup2zone_2010"
