# ==========================================================
# PROYECTO: Machine Learning - Mercado Laboral INE
# Script: 04_preprocesamiento.R
# Autor: Luis Alfonso de Jorge Aparicio
# ==========================================================

#------------------------------------------------------------
# 1. Limpiar entorno
#------------------------------------------------------------

rm(list = ls())

#------------------------------------------------------------
# 2. Librerías
#------------------------------------------------------------

library(dplyr)

#------------------------------------------------------------
# 3. Cargar datos limpios
#------------------------------------------------------------

datos_wide <- readRDS("data/datos_limpios.rds")

#------------------------------------------------------------
# 4. Crear variable objetivo
#------------------------------------------------------------

terciles <- quantile(
  datos_wide$Paro_Total,
  probs = c(0.33, 0.66)
)

print(terciles)

datos_wide$Clase_Paro <- cut(
  datos_wide$Paro_Total,
  breaks = c(
    -Inf,
    terciles[1],
    terciles[2],
    Inf
  ),
  labels = c(
    "Bajo",
    "Medio",
    "Alto"
  ),
  include.lowest = TRUE
)

#------------------------------------------------------------
# 5. Convertir variables categóricas
#------------------------------------------------------------

datos_wide$Tipo_municipio <- as.factor(datos_wide$Tipo_municipio)

datos_wide$Clase_Paro <- as.factor(datos_wide$Clase_Paro)

#------------------------------------------------------------
# 6. Comprobar clases
#------------------------------------------------------------

table(datos_wide$Clase_Paro)

#------------------------------------------------------------
# 7. Estructura final
#------------------------------------------------------------

str(datos_wide)

#------------------------------------------------------------
# 8. Guardar dataset preparado
#------------------------------------------------------------

saveRDS(datos_wide, "data/datos_modelo.rds")