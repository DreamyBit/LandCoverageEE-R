# Cobertura de suelo usando Earth Engine y R

![Alt text](https://github.com/DreamyBit/LandCoverageEE-R/blob/readme/docs/orissa.png?sanitize=true)

## Caracteristicas

- Grafica uso de suelo de cualquier parte del mundo usando el dataset [dynamic world v1][dw1]
- Facilita la seleccion de zonas geograficas usando los dataset GAUL de [primer][gaul1] y [segundo][gaul2] nivel
- Precision de hasta 10m por pixel
- Permite comparar y graficar el cambio en uso de suelo entre dos años
- Permite descargar datos del uso de suelo en formato raster
- Rasters extraidos son compatibles con Dinamica EGO y QGis

## Requisitos

El presente proyecto depende de la instalacion previa de las siguientes tecnologias para su correcto funcionamiento:

- Python 3
- Google Cloud SDK
- R
- RTools

## Uso

El funcionamiento del proyecto se encuentra explicado en [esta guia][gitguide] la cual forma parte del [repositorio][repo] del proyecto

## Licencia

GNU General Public License v3.0

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [dw1]: <https://developers.google.com/earth-engine/datasets/catalog/GOOGLE_DYNAMICWORLD_V1>
   [gaul1]: <https://developers.google.com/earth-engine/datasets/catalog/FAO_GAUL_2015_level1>
   [gaul2]: <https://developers.google.com/earth-engine/datasets/catalog/FAO_GAUL_2015_level2>
   [gitguide]: <https://github.com/DreamyBit/LandCoverageEE-R/blob/main/Guia%20Script%20-%20Covertura%20de%20suelo%20usando%20Earth%20Engine%20y%20R.pdf>
   [repo]: <https://github.com/DreamyBit/LandCoverageEE-R>
