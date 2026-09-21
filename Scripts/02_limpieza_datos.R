# ==========================================================
# PROYECTO: Machine Learning - Mercado Laboral INE
# Script: 02_limpieza_datos.R
# Autor: Luis Alfonso de Jorge Aparicio
# ==========================================================

#------------------------------------------------------------
# 1. Limpiar entorno
#------------------------------------------------------------

rm(list = ls())

#------------------------------------------------------------
# 2. Librerías
#------------------------------------------------------------

library(readr)
library(dplyr)
library(tidyr)

#------------------------------------------------------------
# 3. Cargar datos
#------------------------------------------------------------

datos <- read_csv2(
  "data/mercado_laboral_ine.csv",
  show_col_types = FALSE
)

#------------------------------------------------------------
# 4. Crear variable auxiliar
#------------------------------------------------------------

datos <- datos %>%
  mutate(
    Variable = paste(
      `Tipo de tasa`,
      `Personas sin y con discapacidad`,
      sep = "_"
    )
  )

#------------------------------------------------------------
# 5. Transformar a formato ancho
#------------------------------------------------------------

datos_wide <- datos %>%
  pivot_wider(
    id_cols = c(Año, `Tipo de municipio`),
    names_from = Variable,
    values_from = Total
  )

#------------------------------------------------------------
# 6. Renombrar variables
#------------------------------------------------------------

colnames(datos_wide) <- c(
  "Año",
  "Tipo_municipio",
  "Actividad_Total",
  "Actividad_Sin_Discapacidad",
  "Actividad_Con_Discapacidad",
  "Empleo_Total",
  "Empleo_Sin_Discapacidad",
  "Empleo_Con_Discapacidad",
  "Paro_Total",
  "Paro_Sin_Discapacidad",
  "Paro_Con_Discapacidad"
)

#------------------------------------------------------------
# 7. Comprobaciones
#------------------------------------------------------------

cat("Dimensiones del dataset:\n")
print(dim(datos_wide))

cat("\nNombres de las variables:\n")
print(names(datos_wide))

cat("\nValores perdidos:\n")
print(colSums(is.na(datos_wide)))

cat("\nDuplicados:\n")
print(sum(duplicated(datos_wide)))

#------------------------------------------------------------
# 8. Convertir variable categórica
#------------------------------------------------------------

datos_wide$Tipo_municipio <- as.factor(datos_wide$Tipo_municipio)

cat("\nEstructura del dataset:\n")
str(datos_wide)

# Guardar el dataset limpio
saveRDS(datos_wide, "data/datos_limpios.rds")



