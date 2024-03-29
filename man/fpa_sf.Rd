% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{fpa_sf}
\alias{fpa_sf}
\title{CMAP Facility Planning Areas (FPAs)}
\format{
A multipolygon \code{sf} object with 111 rows and 5
variables:
\describe{
\item{fpa}{Full name of FPA (including parent- and sub-FPA). Character.}
\item{parent_fpa}{Name of parent FPA (same as \code{fpa} if not part of a
sub-FPA). Character.}
\item{sub_fpa}{Name of sub-FPA, which may have multiple parent FPAs.
Character.}
\item{sqmi}{Area in square miles. Double.}
\item{geometry}{Feature geometry. \code{sf} multipolygon.}
}
}
\source{
\href{https://datahub.cmap.illinois.gov/dataset/facility-planning-areas-fpa}{CMAP Data Hub (temporarily offline)}
}
\usage{
fpa_sf
}
\description{
This dataset represents wastewater service boundaries (Facility Planning
Areas, or FPAs) approved by IEPA as of 1 April 2014, after which IEPA ceased
approving FPA boundaries. No updates to this data set have occurred since
that date, and no additional updates are anticipated.
}
\details{
CMAP is the designated areawide water-quality management planning agency for
the seven counties of northeastern Illinois, with responsibility for
reviewing wastewater permits, facility plans, and related topics to ensure
consistency with the federally-approved Illinois Water Quality Management
Plan and the Areawide Water Quality Management Plan.
}
\examples{
# Display the FPAs with ggplot2
library(ggplot2)
ggplot(fpa_sf) + geom_sf(lwd = 0.1) + theme_void()
}
\seealso{
\url{https://www.cmap.illinois.gov/programs/water/water-quality/wastewater-planning}
}
\keyword{datasets}
