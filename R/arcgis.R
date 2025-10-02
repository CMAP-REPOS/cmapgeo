#' Load data from online ArcGIS resources
#' 
#' `sf_from_arcgis()` loads data from online sources like the Data Catalog, ArcGIS Online, and ArcGIS Enterprise as an sf dataframe.
#' 
#' @param url the ArcGIS API URL of the Feature Layer
#' @param where an SQL expression to filter the data. Defaults to returning all data. 
#' See the where request parameter in the ArcGIS REST API docs for more info:
#' https://developers.arcgis.com/rest/services-reference/enterprise/query-feature-service-layer/#request-parameters
#' @param columns a list of columns to include in the data, when left blank all columns will be returned
#' @param geo_filter a geography to filter the data too. Can either be a URL to a Feature Layer or an sf dataframe
#' @param region_filter when TRUE, use the CMAP region as the geo_filter. Ignored if a geo_filter is provided
#' @param townships when TRUE, include the two border townships in the CMAP region. When FALSE, use the seven county definition of the CMAP region
#' @param cmap_crs when TRUE, convert the sf dataframe to the standard CMAP Coordinate Reference System
#' @param clip when TRUE, clip the features to the exact border of the geo_filter. when FALSE include any features that intersect with the geo_filter.
#' @param quiet when TRUE, surpress progress and warning messages
#' @return sf dataframe
#'  
#' @examples
#' 
#' \dontrun{
#' 
#' cmap = sf_from_arcgis("https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/Shapefile_CMAP_MPA_Boundary_September_2014/FeatureServer/0")
#' 
#' zones = sf_from_arcgis(
#'     url = "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/CMAP_Modeling_Zones_2017/FeatureServer/0",
#'     where = "cmap = 1",
#'     columns = c("zone17", "county_name")
#' )
#' 
#' alt_fuel_corridors = sf_from_arcgis(
#'     "https://services1.arcgis.com/4yjifSiIG17X0gW4/arcgis/rest/services/Alternative_Fuel_Corridors/FeatureServer/5",
#'     region_filter = T
#' )
#' 
#' alt_fuel_corridors_clip = sf_from_arcgis(
#'     "https://services1.arcgis.com/4yjifSiIG17X0gW4/arcgis/rest/services/Alternative_Fuel_Corridors/FeatureServer/5",
#'     region_filter = T,
#'     clip = T
#' )
#' 
#' alt_fuel_stations = sf_from_arcgis(
#'     "https://services9.arcgis.com/RHVPKKiFTONKtxq3/arcgis/rest/services/Alternate_Fuel/FeatureServer/0",
#'     geo_filter = "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/CMAP_Modeling_Zones_2017/FeatureServer/0"
#' )
#' 
#' alt_fuel_stations = sf_from_arcgis(
#'     "https://services9.arcgis.com/RHVPKKiFTONKtxq3/arcgis/rest/services/Alternate_Fuel/FeatureServer/0",
#'     geo_filter = cmap %>% filter(FIPSCNTY == "111")
#'     where = "Fuel_Type LIKE '%ELEC%'"
#'     columns = c("Station_Id", "Fuel_Type")
#' )
#' 
#' }
#' 
#' @import sf
#' @import dplyr
#' @importFrom arcgisutils auth_binding
#' @importFrom arcgisbinding arc.check_product
#' 
#' @export
sf_from_arcgis <- function(
  url,
  where = "1=1",
  columns = c("*"),
  geo_filter = NULL,
  region_filter = FALSE,
  townships = TRUE,
  to_cmap_crs = TRUE,
  clip = FALSE,
  quiet = FALSE
) {

  #
  # Parameter Validation
  #

  # TODO

  #
  # Get Data
  

  # establish GIS session and get token
  arc.check_product()
  token <- auth_binding()$access_token

  # calculate the bbox if a geofilter is being used
  if (!is.null(geo_filter)) {
    if ("character" %in% class(geo_filter)) {
      message("Getting your geography filter from ArcGIS...")
      geo_filter_sf <- esri2sf(geo_filter, token = token, crs = NULL)
      bbox <- st_bbox(geo_filter_sf)
    } else if ("sf" %in% class(geo_filter)) {
      geo_filter_sf <- geo_filter
      bbox <- st_bbox(geo_filter_sf)
    } else {
      simpleError("geo_filter must be a URL character vector or an sf dataframe.")
    }
  } else if (region_filter) {
    message("Getting the CMAP region boundary to filter data to...")
    mpa <- esri2sf(
        "https://services5.arcgis.com/LcMXE3TFhi1BSaCY/arcgis/rest/services/Shapefile_CMAP_MPA_Boundary_September_2014/FeatureServer/0",
        token = token,
        crs = NULL
    )
    if (townships) {
      geo_filter_sf <- mpa
      bbox <- st_bbox(geo_filter_sf)
    } else {
      geo_filter_sf <- mpa |> 
        filter(FIPSCNTY %in% c("031", "043", "089", "093", "097", "111", "197"))
      bbox <- st_bbox(geo_filter_sf)
    }
  } else {
    geo_filter_sf <- NULL
    bbox <- NULL
  }

  # get the data using esri2sf
  message("Getting dataset from ArcGIS...")
  data <- esri2sf(
    url,
    # outFields is giving me an error I can't figure out when I give it anything other than c("*"), so doing it manually for now
    # outFields = columns,
    where = where,
    bbox = bbox,
    token = token,
    crs = NULL,
    progress = T
  )

  # manual fix for outFields not working
  if (columns[1] != c("*")) { # there is probably a better way to write this if statement
    data <- data %>% 
      select(columns)
  }

  # get only features that actually intersect with the geo_filter
  if (!is.null(geo_filter_sf)) {
    message("Getting features that intersect with the geography filter.")
    data <- data %>% 
      st_filter(st_transform(geo_filter_sf, st_crs(data)), .predicate = st_intersects)

    if (clip) {
      message("Clipping data to exact geography filter boundaries. Warning: this assumes attributes don't change based on the spatial data, and can take awhile on large datasets.")
      data <- data %>% 
        st_intersection(
          st_transform(geo_filter_sf, st_crs(data))
        )
    }
  }

  # convert to standard cmap crs
  if (to_cmap_crs) {
    message("Transforming to the standard CMAP Coordinate Reference System. Set to_cmap_crs to FALSE to keep the original CRS.")
    data <- st_transform(data, cmap_crs)
  }

  return(data)
}
    