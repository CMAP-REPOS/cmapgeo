% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{municipality_sf}
\alias{municipality_sf}
\title{Municipalities}
\format{
A multipolygon \code{sf} object with 284 rows and
4 variables:
\describe{
\item{geoid_place}{Unique 7-digit place/municipality ID, assigned by the
Census Bureau. Character.}
\item{municipality}{Municipality name. Character.}
\item{sqmi}{Area in square miles. Double.}
\item{geometry}{Feature geometry. \code{sf} multipolygon.}
}
}
\source{
US Census Bureau
\href{https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html}{TIGER/Line}
}
\usage{
municipality_sf
}
\description{
The 284 municipalities (also referred to as "incorporated places" in Census
Bureau terminology) that are at least partially within the 7-county Chicago
Metropolitan Agency for Planning (CMAP) region. From the US Census Bureau's
TIGER/Line shapefiles, 2023 vintage.
}
\details{
Census Bureau description:

\emph{"Incorporated Places are those reported to the Census Bureau as legally in
existence as of January 1, as reported in the latest Boundary and Annexation
Survey (BAS), under the laws of their respective states. An incorporated
place is established to provide governmental functions for a concentration of
people as opposed to a minor civil division (MCD), which generally is created
to provide services or administer an area without regard, necessarily, to
population. Places always are within a single state or equivalent entity, but
may extend across county and county subdivision boundaries. An incorporated
place usually is a city, town, village, or borough, but can have other legal
descriptions."}
}
\examples{
# Display the municipalities with ggplot2
library(ggplot2)
ggplot(municipality_sf) + geom_sf(lwd = 0.1) + theme_void()
}
\keyword{datasets}
