# Cobertura de suelo usando Earth Engine y R

![Alt text](https://github.com/DreamyBit/LandCoverageEE-R/blob/readme/docs/orissa.png?sanitize=true)

## Caracteristicas

- Gráfica uso de suelo de cualquier parte del mundo usando el dataset [dynamic world v1][dw1].
- Facilita la selección de zonas geográficas usando los dataset GAUL de [primer][gaul1] y [segundo][gaul2] nivel.
- Precisión de hasta 10m por pixel.
- Permite comparar y graficar el cambio en uso de suelo entre dos años.
- Permite descargar datos del uso de suelo en formato raster.
- Rasters extraídos son compatibles con Dinamica EGO y QGis.

## Requisitos

El presente proyecto depende de la instalación previa de las siguientes tecnologías para su correcto funcionamiento:

- Python 3
- Google Cloud SDK
- R
- RTools

## Uso

El funcionamiento del proyecto se encuentra explicado en [esta guía][gitguide] la cual forma parte del [repositorio][repo] del proyecto.

Un ejemplo creado usando la Región del Biobío, Chile es el siguiente.

![Alt text](https://github.com/DreamyBit/LandCoverageEE-R/blob/readme/docs/BiobioRGB2018-2021.gif?sanitize=true)

Donde la variación entre el año 2018 y el año 2021 se representa en el siguiente gráfico de forma puntual y porcentual.

![Alt text](https://github.com/DreamyBit/LandCoverageEE-R/blob/readme/docs/BiobioChange2018-2021.png?sanitize=true)

## Licencia

GNU General Public License v3.0

   [dw1]: <https://developers.google.com/earth-engine/datasets/catalog/GOOGLE_DYNAMICWORLD_V1>
   [gaul1]: <https://developers.google.com/earth-engine/datasets/catalog/FAO_GAUL_2015_level1>
   [gaul2]: <https://developers.google.com/earth-engine/datasets/catalog/FAO_GAUL_2015_level2>
   [gitguide]: <https://github.com/DreamyBit/LandCoverageEE-R/blob/main/Guia%20Script%20-%20Covertura%20de%20suelo%20usando%20Earth%20Engine%20y%20R.pdf>
   [repo]: <https://github.com/DreamyBit/LandCoverageEE-R>
