library(tidyverse)
devtools::load_all()

# Define CMAP colors
cmap_colors <- sort(c(
  blue_dk = "#1e478e",
  green_dk = "#3e6730",
  red_dk = "#ca3428",
  gold_dk = "#d3b42b",
  blue_lt = "#ade0ee",
  green_lt = "#6dae4f",
  gold_lt = "#e6daaf"
))

# Create simplified geodata for logo map
twp_logo <- township_sf %>%
  rmapshaper::ms_simplify(keep = 0.002)

cnty_logo <- twp_logo %>%
  rmapshaper::ms_dissolve("county_fips")

reg_logo <- cnty_logo %>%
  rmapshaper::ms_dissolve()

# Plot the map
logo_map <- ggplot() +
  geom_sf(data = twp_logo, color = cmap_colors["green_lt"], fill = NA, lwd = 0.1) +
  geom_sf(data = cnty_logo, color = cmap_colors["green_lt"], fill = NA, lwd = 0.5) +
  geom_sf(data = reg_logo, color = cmap_colors["green_lt"], fill = NA, lwd = 0.8) +
  theme_void() +
  ggpubr::theme_transparent()

# Create the hexagonal logo
sysfonts::font_add_google("Economica", "Economica")
#showtext::showtext_auto()
logo <- hexSticker::sticker(
  logo_map, s_x = 1, s_y = 0.7, s_width = 1.25, s_height = 1.25,  # Map size/position
  package = "cmapgeo", p_family = "Economica", p_color = cmap_colors["blue_lt"],  # Title appearance
  p_size = 32, p_y = 1.48,  # Title size/position
  h_fill = cmap_colors["blue_dk"], h_color = cmap_colors["blue_lt"],  # Hexagon fill/border colors
  filename="man/figures/logo.png"  # Output location
)
plot(logo)

# Create a no-text variant
logo_notext <- hexSticker::sticker(
  logo_map, s_x = 1, s_y = 0.94, s_width = 1.7, s_height = 1.7,  # Map size/position
  package = "",  # Empty string for logo title
  h_fill = cmap_colors["blue_dk"], h_color = cmap_colors["blue_lt"],  # Hexagon fill/border colors
  filename="man/figures/logo_notext.png"  # Output location
)
plot(logo_notext)
