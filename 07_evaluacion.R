
# ==========================================================
# Resultado final
# Predicción del nivel de desempleo mediante Machine Learning
# Script: 07_evaluacion.R
# Autor: Luis Alfonso de Jorge Aparicio
# ==========================================================

#------------------------------------------------------------
# 1. Limpiar entorno
#------------------------------------------------------------

rm(list = ls())

#------------------------------------------------------------
# 2. Librerías
#------------------------------------------------------------

library(caret)
library(ggplot2)

#------------------------------------------------------------
# 3. Cargar modelos
#------------------------------------------------------------

modelo_logistico <- readRDS("output/modelo_logistico.rds")
modelo_arbol     <- readRDS("output/modelo_arbol.rds")
modelo_rf        <- readRDS("output/modelo_rf.rds")
modelo_svm       <- readRDS("output/modelo_svm.rds")

#------------------------------------------------------------
# 4. Crear tabla de resultados
#------------------------------------------------------------

resultados <- data.frame(
  
  Modelo = c(
    "Regresión logística",
    "Árbol de decisión",
    "Random Forest",
    "SVM"
  ),
  
  Accuracy = c(
    max(modelo_logistico$results$Accuracy),
    max(modelo_arbol$results$Accuracy),
    max(modelo_rf$results$Accuracy),
    max(modelo_svm$results$Accuracy)
  ),
  
  Kappa = c(
    max(modelo_logistico$results$Kappa),
    max(modelo_arbol$results$Kappa),
    max(modelo_rf$results$Kappa),
    max(modelo_svm$results$Kappa)
  )
  
)

#------------------------------------------------------------
# 5. Ordenar resultados
#------------------------------------------------------------

resultados <- resultados[order(-resultados$Accuracy), ]

print(resultados)

#------------------------------------------------------------
# 6. Guardar resultados
#------------------------------------------------------------

write.csv(
  resultados,
  "output/resultados_modelos.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

