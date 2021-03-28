library(tidyverse)
devtools::load_all()

# Define CMAP colors
cmap_colors <- sort(c(
  blue_dk = "#0f3e8b",
  green_dk = "#7dc242",
  red_dk = "#d93636",
  gold_dk = "#cca62b",
  blue_lt = "#73c9e3",
  green_lt = "#c7de75",
  red_lt = "#e5a872",
  gold_lt = "#e6d170"
))

# Create simplified geodata for logo map
twp_logo <- township_sf %>%
  rmapshaper::ms_simplify(keep = 0.002)

cnty_logo <- twp_logo %>%
  rmapshaper::ms_dissolve("county_fips")

reg_logo <- cnty_logo %>%
  rmapshaper::ms_dissolve()

# Plot the map
logo_map2 <- ggplot() +
  geom_sf(data = twp_logo, color = cmap_colors["green_lt"], fill = NA, lwd = 0.1) +
  geom_sf(data = cnty_logo, color = cmap_colors["green_lt"], fill = NA, lwd = 0.5) +
  geom_sf(data = reg_logo, color = cmap_colors["green_lt"], fill = NA, lwd = 0.8) +
  theme_void() +
  ggpubr::theme_transparent()

# Create the hexagonal logo
sysfonts::font_add_google("Economica", "Economica")
#showtext::showtext_auto()
s <- hexSticker::sticker(
  logo_map2, s_x = 1, s_y = 0.7, s_width = 1.25, s_height = 1.25,  # Map size/position
  package = "cmapgeo", p_family = "Economica", p_color = cmap_colors["blue_lt"],  # Title appearance
  p_size = 32, p_y = 1.48,  # Title size/position
  h_fill = cmap_colors["blue_dk"], h_color = cmap_colors["blue_lt"],  # Hexagon fill/border colors
  filename="man/figures/logo.png"  # Output location
)
plot(s)
