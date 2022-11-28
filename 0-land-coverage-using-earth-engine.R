# //////////////////////////////// Requisitos previos //////////////////////////

# Python Version mayor a 3
# RTools
# Google Cloud SDK

# //////////////////////////////// Paquetes ////////////////////////////////////

install.packages("remotes")
install.packages("reticulate")
install.packages("googledrive")
install.packages("rgee")
install.packages("terra")
install.packages("tidyverse")
install.packages("stringi")
install.packages("plotly")

# //////////////////////////////// Earth Engine ////////////////////////////////

# En caso de error seguir los pasos:
#
# Paso 1: Limpiar cache
# rm(list = ls(all.names = TRUE))
# gc()
#
# Paso 2: instalar rgee desde github
# remotes::install_github("r-spatial/rgee", force = TRUE)
#
# Paso 3: Reiniciar sesion y luego Limpiar entorno
# rgee::ee_clean_pyenv()
#
# Paso 4: Reiniciar sesion y continuar con la instalacion de ee

rgee::ee_install()

rgee::ee_Initialize(drive = T)

# //////////////////////////////// Librerias ///////////////////////////////////

library(remotes)
library(reticulate)
library(googledrive)
library(rgee)
library(terra)
library(tidyverse)
library(plotly)

source("1-data-download-and-format.R")
source("2-data-display.R")

# //////////////////////////////// SCRIPT //////////////////////////////////////


# Crear limites espacio-temporales
# Usando zonas administrativas de primer nivel (regiones)
# region_list <- ee$List(c("", "Biobio"))
# region_filter <- ee$Filter(ee$Filter$inList("ADM1_NAME", region_list))
# region_geometry <- ee$FeatureCollection("FAO/GAUL/2015/level1")$filter(region_filter)$geometry()

# Usando zonas administrativas de segundo nivel (provincias)
region_list <- ee$List(c("", "Cauquenes"))
region_filter <- ee$Filter(ee$Filter$inList("ADM2_NAME", region_list))
region_geometry <- ee$FeatureCollection("FAO/GAUL/2015/level2")$filter(region_filter)$geometry()


map_1_name <- "Cauquenes_enero_2018"
map_2_name <- "Cauquenes_enero_2021"
map_1_filter <- create_filter(region_geometry, "2018-01-01", "2018-02-01")
map_2_filter <- create_filter(region_geometry, "2021-01-01", "2021-02-01")


# Obtener regiones y rasters
map_1_clipped_region <- download_median_clipped(map_1_filter, region_geometry)
map_2_clipped_region <- download_median_clipped(map_2_filter, region_geometry)
map_1_raster <- download_raster(map_1_clipped_region, map_1_name, region_geometry)
map_2_raster <- download_raster(map_2_clipped_region, map_2_name, region_geometry)


# Guardar en disco y cargar en memoria Spatraster. Eliminar raster normal del disco.
save_raster(map_1_raster, map_1_name)
save_raster(map_2_raster, map_2_name)

map_1_raster <- load_raster(paste(map_1_name, "_terra.tif", sep = ""))
map_2_raster <- load_raster(paste(map_2_name, "_terra.tif", sep = ""))

delete_tif(paste(map_1_name, ".tif", sep = ""))
delete_tif(paste(map_2_name, ".tif", sep = ""))


# Crear dataframes a partir de rasters para analisis de estadisticas
map_1_data <- create_dataframe_from_raster(map_1_raster)
map_2_data <- create_dataframe_from_raster(map_2_raster)
change_data <- change_between_map_data(map_1_data, map_2_data)

save_dataframe(map_1_data, map_1_name)
save_dataframe(map_2_data, map_2_name)
save_dataframe(change_data, "change")


# Graficar
draw_rgb_region(map_1_clipped_region, map_2_clipped_region, geometry = region_geometry)
draw_coverage_bars(change_data)
