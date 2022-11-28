#
# Funciones y datos para visualizar mapas e informacion.
#


class_names <- c(
  "water", "trees", "grass", "flooded_vegetation", "crops",
  "shrub_and_scrub", "built", "bare", "snow_and_ice"
)

vis_palette <- c(
  "#419BDF", "#397D49", "#88B053", "#7A87C6",
  "#E49635", "#DFC35A", "#C4281B", "#A59B8F",
  "#B39FE1"
)

draw_coverage_bars <- function(change_data) {
  data <- data.frame(
    change_data,
    class_names,
    vis_palette
  )

  df <- data %>%
    pivot_longer(cols = 1:2)
  df$change <- df$change * c(0, 1)
  df$change_percent <- df$change_percent * c(0, 1)

  names(df)[3] <- "type"
  names(df)[5] <- "map"

  df %>%
    ggplot(aes(x = map, y = value)) +
    geom_col(fill = df$vis_palette) +
    facet_grid(~ factor(type, class_names)) +
    scale_y_continuous(labels = scales::comma) +
    geom_text(
      aes(label = ifelse(
        (change_percent <= 0),
        "",
        paste("+", round(change_percent, digits = 2), "%", sep = "")
      )),
      nudge_y = 1,
      vjust = -1,
      color = "chartreuse4"
    ) +
    geom_text(
      aes(label = ifelse(
        (change_percent >= 0),
        "",
        paste(round(change_percent, digits = 2), "%", sep = "")
      )),
      nudge_y = 1,
      vjust = -1,
      color = "firebrick2"
    )
}

draw_rgb_region <- function(clipped_region_1, clipped_region_2 = NULL, geometry) {
  rgb_map_1 <- clipped_region_1$select("label")$visualize(min = 0, max = 8, palette = vis_palette)$divide(255)

  Map$centerObject(eeObject = geometry)

  if (is.null(clipped_region_2)) {
    Map$addLayer(
      geometry,
      {},
      "Region"
    ) +
      Map$addLayer(
        rgb_map_1,
        {},
        "Cobertura de suelo 1"
      )
  } else {
    rgb_map_2 <- clipped_region_2$select("label")$visualize(min = 0, max = 8, palette = vis_palette)$divide(255)

    Map$addLayer(
      geometry,
      {},
      "Region"
    ) +
      Map$addLayer(
        rgb_map_1,
        {},
        "Cobertura de suelo 1"
      ) +
      Map$addLayer(
        rgb_map_2,
        {},
        "Cobertura de suelo 2"
      )
  }
}

plot_map_data <- function(map_data) {
  plot <- ggplot(
    map_data,
    aes(x = class_name, y = count, fill = class_name, text = paste("percentage: ", coverage_percent, "%"))
  ) +
    geom_bar(stat = "identity", width = 0.5, alpha = 0.9) +
    scale_y_continuous(labels = function(count) format(count, scientific = FALSE)) +
    coord_flip() +
    theme_bw() +
    scale_fill_manual(values = map_data$palette)

  ggplotly(plot, tooltip = c("class_name", "count", "text"))
}
