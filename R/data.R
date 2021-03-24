# Datasets created with data-raw/load_chicago_geojson.R -------------------

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
#' @source [Chicago Data Portal](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Community-Areas-current-/cauq-8yn6)
#'
#' @examples
#' # Display the CCAs with ggplot2
#' library(ggplot2)
#' ggplot(data = cca_sf) + geom_sf(lwd = 0.1) + theme_void()
"cca_sf"


#' Chicago Wards (2015-Present)
#'
#' The official boundaries of the current Chicago Wards (established in May of
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
#' @source [Chicago Data Portal](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Wards-2015-/sp34-6z76)
#'
#' @examples
#' # Display the wards with ggplot2
#' library(ggplot2)
#' ggplot(data = ward_sf) + geom_sf(lwd = 0.1) + theme_void()
"ward_sf"



# Datasets created with data-raw/load_datahub_shp.R -----------------------

#' CMAP Travel Modeling Subzones (2017)
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
#'   \item{cmap}{Is subzone in the CMAP MPO area? (The MPO area includes the 7
#'   CMAP counties, plus Aux Sable Township in Grundy County and Sandwich &
#'   Somonauk Townships in DeKalb County.) Logical.}
#'   \item{chicago}{Is subzone in the City of Chicago? (Approximate, in some
#'   cases.) Logical.}
#'   \item{cbd}{Is subzone in the Chicago Central Business District? (CBD is
#'   defined as the area bounded by Chicago Ave, Halsted St, Roosevelt Rd, and
#'   Lake Michigan.) Logical.}
#'   \item{township_range}{4-digit ID of the
#'   \href{https://clearinghouse.isgs.illinois.edu/data/reference/illinois-plss-townships}{PLSS township}
#'   the subzone is in; first 2 digits are township, last 2 are range. Character.}
#'   \item{county_fips}{5-digit FIPS code of the county the subzone is in; first
#'   2 digits are the state FIPS code. Character.}
#'   \item{state}{State the subzone is in (IL, IN or WI). Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source [CMAP Data Hub](https://datahub.cmap.illinois.gov/dataset/cmap-modeling-zone-systems/resource/c4e47fca-0030-4b66-9221-947120c9c24f)
#'
#' @examples
#' # Display the subzones with ggplot2
#' library(ggplot2)
#' ggplot(data = subzone_sf) + geom_sf(lwd = 0.1) + theme_void()
"subzone_sf"


#' CMAP Travel Modeling Zones (2017)
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
#'   \item{cmap}{Is zone in the CMAP MPO area? (The MPO area includes the 7
#'   CMAP counties, plus Aux Sable Township in Grundy County and Sandwich &
#'   Somonauk Townships in DeKalb County.) Logical.}
#'   \item{chicago}{Is zone in the City of Chicago? (Approximate, in some
#'   cases.) Logical.}
#'   \item{cbd}{Is zone in the Chicago Central Business District? (CBD is
#'   defined as the area bounded by Chicago Ave, Halsted St, Roosevelt Rd, and
#'   Lake Michigan.) Logical.}
#'   \item{township_range}{4-digit ID of the
#'   \href{https://clearinghouse.isgs.illinois.edu/data/reference/illinois-plss-townships}{PLSS township}
#'   the zone is in; first 2 digits are township, last 2 are range. Character.}
#'   \item{county_fips}{5-digit FIPS code of the county the zone is in; first
#'   2 digits are the state FIPS code. Character.}
#'   \item{state}{State the zone is in (IL, IN or WI). Character.}
#'   \item{sqmi}{Area in square miles. Double.}
#'   \item{geometry}{Feature geometry. `sf` polygon.}
#' }
#'
#' @source [CMAP Data Hub](https://datahub.cmap.illinois.gov/dataset/cmap-modeling-zone-systems/resource/8dd37215-98dc-4244-9623-2d28c4e1611c)
#'
#' @examples
#' # Display the zones with ggplot2
#' library(ggplot2)
#' ggplot(data = zone_sf) + geom_sf(lwd = 0.1) + theme_void()
"zone_sf"
