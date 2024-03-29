% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cmapgeo.R
\docType{data}
\name{cmap_crs}
\alias{cmap_crs}
\title{Geodata Coordinate System}
\format{
An object of class \code{numeric} of length 1.
}
\usage{
cmap_crs
}
\description{
The EPSG code of the coordinate system that all datasets in cmapgeo have been
projected in -- specifically, Illinois State Plane East (NAD83, ft). It can
be used as the \code{crs} parameter in \code{sf::st_transform()} to reproject other
\code{sf} objects that have a different projection.
}
\examples{
\dontrun{
  # Reproject any other sf object to match cmapgeo coordinate system
  my_sf_data <- sf::st_transform(my_sf_data, crs = cmap_crs)
}

# View projection specification
sf::st_crs(cmap_crs)

}
\seealso{
\url{https://epsg.io/3435}
}
\keyword{datasets}
