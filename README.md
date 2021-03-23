
<!--

  ####### UUUUUUUU        ,ad8888ba,   88b           d88         db         88888888ba
  ####### :UUUUUUU       d8"'    `"8b  888b         d888        d88b        88      "8b
  #######. :UUUUUU      d8'            88`8b       d8'88       d8'`8b       88      ,8P
  ########  :UUUUU      88             88 `8b     d8' 88      d8'  `8b      88aaaaaa8P'
  #########:  :UUU      88             88  `8b   d8'  88     d8YaaaaY8b     88""""""'
  ##########:    '      Y8,            88   `8b d8'   88    d8""""""""8b    88
  #############:.        Y8a.    .a8P  88    `888'    88   d8'        `8b   88
  ################        `"Y8888Y"'   88     `8'     88  d8'          `8b  88
    
    
                                  PROUDLY PRESENTS
                                                                                               
                                                                                               
                                                                                               
 ,adPPYba,  88,dPYba,,adPYba,   ,adPPYYba,  8b,dPPYba,    ,adPPYb,d8   ,adPPYba,   ,adPPYba,   
a8"     ""  88P'   "88"    "8a  ""     `Y8  88P'    "8a  a8"    `Y88  a8P_____88  a8"     "8a  
8b          88      88      88  ,adPPPPP88  88       d8  8b       88  8PP"""""""  8b       d8  
"8a,   ,aa  88      88      88  88,    ,88  88b,   ,a8"  "8a,   ,d88  "8b,   ,aa  "8a,   ,a8"  
 `"Ybbd8"'  88      88      88  `"8bbdP"Y8  88`YbbdP"'    `"YbbdP"Y8   `"Ybbd8"'   `"YbbdP"'   
                                            88            aa,    ,88                           
                                            88             "Y8bbdP"                            


             An R package made with ♥ in Chicago by and for CMAP staff.
-->

# cmapgeo <!--<img src="man/figures/logo.png" align="right" alt="cmapplot logo" width="128">-->

<!-- badges: start -->
<!-- badges: end -->

The cmapgeo package is a repository of geodata files representing
various geographic and administrative boundaries in the Chicago region.
Data is in the [sf](https://r-spatial.github.io/sf/) (simple features)
format, and includes boundaries for:

-   counties
-   municipalities
-   Chicago Community Areas
-   Census tracts, block groups, blocks and public use microdata areas
    (PUMAs)
-   [Chicago Metropolitan Agency for
    Planning](https://www.cmap.illinois.gov) travel modeling zones and
    subzones
-   legislative districts

## Installation

You can install the released version of cmapgeo from
[CRAN](https://CRAN.R-project.org) with:

``` r
## Install current version from GitHub
devtools::install_github("CMAP-REPOS/cmapgeo", build_vignettes=TRUE)

## Then load the package as you would any other
library(cmapgeo)
```
