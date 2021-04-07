#' cmapgeo
#'
#' This package is a repository of geodata files representing various geographic
#' and administrative boundaries in the Chicago region, maintained by the
#' Chicago Metropolitan Agency for Planning (CMAP). Data is in the `sf` (simple
#' features) format.
#'
#' Detailed documentation can be viewed at
#' \url{https://cmap-repos.github.io/cmapgeo}.
#'
#' Please report issues and suggest improvements at
#' \url{https://github.com/CMAP-REPOS/cmapgeo/issues}.
#'
#' @name cmapgeo
#' @docType package
#' @keywords internal
"_PACKAGE"



# Exported variables ------------------------------------------------------

#' Geodata Coordinate System
#'
#' The EPSG code of the coordinate system that all datasets in cmapgeo have been
#' projected in -- specifically, Illinois State Plane East (NAD83, ft). It can
#' be used as the `crs` parameter in `sf::st_transform()` to reproject other
#' `sf` objects that have a different projection.
#'
#' @seealso <https://epsg.io/3435>
#'
#' @examples
#' \dontrun{
#'   # Reproject any other sf object to match cmapgeo coordinate system
#'   my_sf_data <- sf::st_transform(my_sf_data, crs = cmap_crs)
#' }
#'
#' sf::st_crs(cmap_crs)  # View projection specification
#'
#' @export
cmap_crs <- 3435


#' County FIPS Code Lists
#'
#' A named list comprising four named vectors, each of which contains the FIPS
#' codes (as 5-character strings) for the counties in one of the four primary
#' geographic divisions of CMAP's travel model and socioeconomic forecasts: the
#' 7-county CMAP region, as well as the external counties in Illinois, Indiana,
#' and Wisconsin.
#'
#' @examples
#' county_fips_codes$cmap  # 7-county CMAP region
#' county_fips_codes$xil   # Travel model external Illinois counties
#' county_fips_codes$xin   # Travel model external Indiana counties
#' county_fips_codes$xwi   # Travel model external Wisconsin counties
#' county_fips_codes$msa   # Chicago-Naperville-Elgin, IL-IN-WI MSA counties
#'
#' # Get the names of the CMAP counties
#' names(county_fips_codes$cmap)
#'
#' # Combine the 4 travel model divisions into a single vector
#' unlist(county_fips_codes[c("cmap", "xil", "xin", "xwi")])
#'
#' @export
county_fips_codes <- list(
  cmap = c(
    Cook = "17031",
    DuPage = "17043",
    Kane = "17089",
    Kendall = "17093",
    Lake = "17097",
    McHenry = "17111",
    Will = "17197"
  ),
  xil = c(
    Boone = "17007",
    DeKalb = "17037",
    Grundy = "17063",
    Kankakee = "17091",
    LaSalle = "17099",
    Lee = "17103",
    Ogle = "17141",
    Winnebago = "17201"
  ),
  xin = c(
    Lake = "18089",
    LaPorte = "18091",
    Porter = "18127"
  ),
  xwi = c(
    Kenosha = "55059",
    Racine = "55101",
    Walworth = "55127"
  ),
  msa = c(
    Cook_IL = "17031",
    DeKalb_IL = "17037",
    DuPage_IL = "17043",
    Grundy_IL = "17063",
    Kane_IL = "17089",
    Kendall_IL = "17093",
    Lake_IL = "17097",
    McHenry_IL = "17111",
    Will_IL = "17197",
    Jasper_IN = "18073",
    Lake_IN = "18089",
    Newton_IN = "18111",
    Porter_IN = "18127",
    Kenosha_WI = "55059"
  )
)



# Internal variables ------------------------------------------------------

# Define sq. ft. per sq. mile for calculating area in sq. miles
sqft_per_sqmi <- 5280 ** 2
