# ==========================================================
# PROYECTO: Machine Learning - Mercado Laboral INE
# Script: 05_preparacion_modelos.R
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
# 3. Cargar datos
#------------------------------------------------------------

datos_modelo <- readRDS("data/datos_modelo.rds")

#------------------------------------------------------------
# 4. Eliminar variables que producirían data leakage
#------------------------------------------------------------

datos_modelo <- datos_modelo %>%
  select(
    -Paro_Total,
    -Paro_Sin_Discapacidad,
    -Paro_Con_Discapacidad
  )

#------------------------------------------------------------
# 5. Comprobar estructura
#------------------------------------------------------------

str(datos_modelo)

summary(datos_modelo)

#------------------------------------------------------------
# 6. Guardar dataset final
#------------------------------------------------------------

saveRDS(datos_modelo,
        "data/datos_finales.rds")