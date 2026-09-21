# ==========================================================
# PROYECTO: Machine Learning - Mercado Laboral INE
# Script: 03_analisis_exploratorio.R
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
library(ggplot2)

#------------------------------------------------------------
# 3. Cargar y preparar datos
#------------------------------------------------------------

datos <- read_csv2(
  "data/mercado_laboral_ine.csv",
  show_col_types = FALSE
)

datos <- datos %>%
  mutate(
    Variable = paste(
      `Tipo de tasa`,
      `Personas sin y con discapacidad`,
      sep = "_"
    )
  )

datos_wide <- datos %>%
  pivot_wider(
    id_cols = c(Año, `Tipo de municipio`),
    names_from = Variable,
    values_from = Total
  )

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

datos_wide$Tipo_municipio <- as.factor(datos_wide$Tipo_municipio)

#------------------------------------------------------------
# 4. Estadísticos descriptivos
#------------------------------------------------------------

summary(datos_wide)

#------------------------------------------------------------
# 5. Histograma de la tasa de paro
#------------------------------------------------------------

ggplot(datos_wide,
       aes(x = Paro_Total)) +
  geom_histogram(bins = 8) +
  labs(
    title = "Distribución de la tasa de paro",
    x = "Tasa de paro",
    y = "Frecuencia"
  )

#------------------------------------------------------------
# 6. Boxplot por tipo de municipio
#------------------------------------------------------------

ggplot(datos_wide,
       aes(x = Tipo_municipio,
           y = Paro_Total)) +
  geom_boxplot() +
  labs(
    title = "Tasa de paro por tipo de municipio",
    x = "Tipo de municipio",
    y = "Paro (%)"
  )

#------------------------------------------------------------
# 7. Matriz de correlaciones
#------------------------------------------------------------

variables_num <- datos_wide %>%
  select(-Tipo_municipio)

cor(variables_num)
