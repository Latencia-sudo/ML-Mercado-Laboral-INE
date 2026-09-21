# ============================================================
# PROYECTO: Machine Learning - Mercado Laboral INE
# Script: 01_Carga_datos.R
# Asignatura: Machine Learning
# Autor: Luis Alfonso de Jorge Aparicio
# ============================================================

# Limpiar el entorno
rm(list = ls())

# Cargar librerías
library(readr)
library(dplyr)

# Cargar el dataset
datos <- read_csv2("data/mercado_laboral_ine.csv")

# Exploración inicial
head(datos)
str(datos)
dim(datos)
names(datos)
summary(datos)
