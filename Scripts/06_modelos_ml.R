# ==========================================================
# PROYECTO: Machine Learning - Mercado Laboral INE
# Script: 06_modelos_ml.R
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
library(nnet)
library(rpart)

#------------------------------------------------------------
# 3. Cargar datos
#------------------------------------------------------------

datos_modelo <- readRDS("data/datos_finales.rds")

#------------------------------------------------------------
# 4. Configurar validación cruzada
#------------------------------------------------------------

set.seed(123)

control <- trainControl(
  method = "LOOCV"
)

#------------------------------------------------------------
# 5. Entrenar Regresión Logística Multinomial
#------------------------------------------------------------

modelo_logistico <- train(
  Clase_Paro ~ .,
  data = datos_modelo,
  method = "multinom",
  trControl = control,
  preProcess = c("center", "scale"),
  trace = FALSE
)

#------------------------------------------------------------
# 6. Resultados
#------------------------------------------------------------

print(modelo_logistico)

#------------------------------------------------------------
# 7. Guardar modelo
#------------------------------------------------------------

saveRDS(
  modelo_logistico,
  "output/modelo_logistico.rds"
)


#------------------------------------------------------------
# Árbol de decisión
#------------------------------------------------------------

set.seed(123)

modelo_arbol <- train(
  Clase_Paro ~ .,
  data = datos_modelo,
  method = "rpart",
  trControl = control,
  tuneGrid = expand.grid(cp = seq(0.001, 0.05, by = 0.005))
)
#------------------------------------------------------------
# 8. Resultados
#------------------------------------------------------------

print(modelo_arbol)

#------------------------------------------------------------
# 9. Guardar modelo
#------------------------------------------------------------

saveRDS(
  modelo_arbol,
  "output/modelo_arbol.rds"
)

#------------------------------------------------------------
# Random Forest
#------------------------------------------------------------

library(randomForest)

set.seed(123)

modelo_rf <- train(
  Clase_Paro ~ .,
  data = datos_modelo,
  method = "rf",
  trControl = control,
  preProcess = c("center", "scale"),
  tuneLength = 5,
  importance = TRUE
)
#------------------------------------------------------------
# 10. Resultados
#------------------------------------------------------------

print(modelo_rf)

#------------------------------------------------------------
# 11. Guardar modelo
#------------------------------------------------------------

saveRDS(
  modelo_rf,
  "output/modelo_rf.rds"
)

#------------------------------------------------------------
# Máquina de Vectores de Soporte (SVM)
#------------------------------------------------------------

library(e1071)

set.seed(123)

modelo_svm <- train(
  Clase_Paro ~ .,
  data = datos_modelo,
  method = "svmRadial",
  trControl = control,
  preProcess = c("center", "scale"),
  tuneLength = 5
)
#------------------------------------------------------------
# 12. Resultados
#------------------------------------------------------------

print(modelo_svm)

#------------------------------------------------------------
# 13. Guardar modelo
#------------------------------------------------------------

saveRDS(
  modelo_svm,
  "output/modelo_svm.rds"
)

#------------------------------------------------------------
# 14. Importancia de las variables (Random Forest)
#------------------------------------------------------------
varImp(modelo_rf)
plot(varImp(modelo_rf))

