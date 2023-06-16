#
# Funciones para descargar, guardar y manipular rasters.
#

# Calcular cambio entre dos mapas
change_between_map_data <- function(map_1_data, map_2_data) {
  change_data <- cbind(map_1_data$count, map_2_data$count)
  change_data <- data.frame(change_data)
  names(change_data)[1] <- "map_1"
  names(change_data)[2] <- "map_2"

  increase <- change_data["map_2"] - change_data["map_1"]
  change_data["change"] <- increase
  change_data["change_percent"] <- (increase / change_data["map_1"]) * 100

  return(change_data)
}

# Crea un filtro para ser usado por una solicitud a Earth Engine
create_filter <- function(bounds, initial_date_string, final_date_string) {
  filter <- ee$Filter$And(
    ee$Filter$bounds(bounds),
    ee$Filter$date(initial_date_string, final_date_string)
  )

  return(filter)
}

# Crea un dataframe a partir de un raster para cuantificar la distribucion de
# coberturas
create_dataframe_from_raster <- function(raster) {
  data_land_coverage <- data.frame(freq(raster))
  data_land_coverage <- data_land_coverage[1:9, ] # Elimina NA del conteo

  names(data_land_coverage)[1] <- "class_key"

  total_data_points <- sum(data_land_coverage$count)
  data_land_coverage$coverage_percent <- 100 * (data_land_coverage$count / total_data_points)

  data_land_coverage$class_name <- factor(class_names, levels = class_names)
  data_land_coverage$palette <- vis_palette

  return(data_land_coverage)
}

# Elimina un .tif del disco, usado para eliminar un raster no compatible 
# que queda como residuo de la solicitud a Earth Engine
delete_tif <- function(filename) {
  if (file.exists(filename)) {
    file.remove(filename)
  }
}

# Descarga la imagen desde Dynamic World, calcula la media de todas las imagenes 
# capturadas segun el filtro
download_median_clipped <- function(filter, region_geometry) {
  dw_collection <- ee$ImageCollection("GOOGLE/DYNAMICWORLD/V1")$filter(filter)
  return(dw_collection$median()$clip(region_geometry))
}

# Descarga el raster y cambia el formato a 32bit int SpatRaster para optimizarlo
# y hacerlo compatible con Dinamica EGO 
download_raster <- function(dw_clipped_region, name, region_geometry) {
  raster <- ee_as_raster(
    image = dw_clipped_region$select("label"),
    dsn = name,
    region = region_geometry,
    scale = 30,
    via = "drive"
  )

  raster <- rast(raster)

  return(raster)
}

# Carga dataframe desde disco
load_dataframe <- function(file = "data.Rds") {
  readRDS(file = file)
}


# Carga raster desde disco
load_raster <- function(filename) {
  terra::rast(filename)
}

# Guarda dataframe en disco
save_dataframe <- function(dataframe, name = "data", overwrite = TRUE) {
  saveRDS(dataframe, file = paste(name, "_data.Rda", sep = ""))
}

# Guarda raster en disco
save_raster <- function(raster, filename = "Raster", overwrite = TRUE) {
  writeRaster(
    raster,
    paste(filename, "_terra.tif", sep = ""),
    overwrite = overwrite,
    datatype = "INT1U"
  )
}
