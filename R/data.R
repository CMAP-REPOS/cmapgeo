# Datasets created with data-raw/load_chicago_geojson.R -------------------

#' Chicago Community Areas (CCAs)
#'
#' The official boundaries of the Chicago Community Areas. Obtained 3/24/2021.
#'
#' @format A multipolygon `sf` object with `r nrow(cca_sf)` rows and
#'   `r ncol(cca_sf)` variables:
#' \describe{
#'   \item{cca_name}{Community area name. Character.}
#'   \item{cca_num}{Numeric ID, as assigned by the City of Chicago. Integer.}
#' }
#'
#' @source [Chicago Data Portal](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Community-Areas-current-/cauq-8yn6)
#'
#' @examples
#' # Display the CCAs with ggplot2
#' library(ggplot2)
#' ggplot(data = cca_sf) + geom_sf() + theme_void()
"cca_sf"


#' Chicago Wards
#'
#' The official boundaries of the current Chicago Wards (established in May of
#' 2015). Obtained 3/24/2021.
#'
#' @format A multipolygon `sf` object with `r nrow(ward_sf)` rows and
#'   `r ncol(ward_sf)` variables:
#' \describe{
#'   \item{ward_num}{Ward number. Integer.}
#' }
#'
#' @source [Chicago Data Portal](https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Wards-2015-/sp34-6z76)
#'
#' @examples
#' # Display the wards with ggplot2
#' library(ggplot2)
#' ggplot(data = ward_sf) + geom_sf() + theme_void()
"ward_sf"
