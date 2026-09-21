# ==========================================================
# Resultado final
# Predicción del nivel de desempleo mediante Machine Learning
# Script: 07_graficos.R
# Autor: Luis Alfonso de Jorge Aparicio
# ==========================================================

#------------------------------------------------------------
# 1. Limpiar entorno
#------------------------------------------------------------

rm(list = ls())

#------------------------------------------------------------
# 2. Librerías
#------------------------------------------------------------

library(ggplot2)
library(readr)
library(caret)

#------------------------------------------------------------
# 3. Cargar resultados
#------------------------------------------------------------

resultados <- read.csv(
  "output/resultados_modelos.csv",
  stringsAsFactors = FALSE
)

print(resultados)

#------------------------------------------------------------
# 4. Gráfico comparativo de Accuracy
#------------------------------------------------------------

# Identificar el mejor modelo
resultados$Grupo <- ifelse(
  resultados$Modelo == "Regresión logística",
  "Mejor modelo",
  "Resto"
)

grafico_accuracy <- ggplot(
  resultados,
  aes(
    x = reorder(Modelo, Accuracy),
    y = Accuracy,
    fill = Grupo
  )
) +
  geom_col(width = 0.7) +
  geom_text(
    aes(label = round(Accuracy, 3)),
    hjust = -0.15,
    size = 4
  ) +
  coord_flip() +
  scale_fill_manual(
    values = c(
      "Mejor modelo" = "#2C7FB8",
      "Resto" = "#A6CEE3"
    )
  ) +
  scale_y_continuous(
    limits = c(0, 1)
  ) +
  labs(
    title = "Comparación de la precisión de los modelos",
    subtitle = "Validación cruzada Leave-One-Out (LOOCV)",
    x = "",
    y = "Accuracy"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

print(grafico_accuracy)

ggsave(
  filename = "figures/Figura4_Accuracy.png",
  plot = grafico_accuracy,
  width = 8,
  height = 5,
  dpi = 300
)

#------------------------------------------------------------
# 5. Gráfico comparativo de Kappa
#------------------------------------------------------------

grafico_kappa <- ggplot(
  resultados,
  aes(
    x = reorder(Modelo, Kappa),
    y = Kappa,
    fill = Grupo
  )
) +
  geom_col(width = 0.7) +
  geom_text(
    aes(label = round(Kappa, 3)),
    hjust = -0.15,
    size = 4
  ) +
  coord_flip() +
  scale_fill_manual(
    values = c(
      "Mejor modelo" = "#2C7FB8",
      "Resto" = "#A6CEE3"
    )
  ) +
  labs(
    title = "Comparación de la concordancia de los modelos",
    subtitle = "Índice Kappa (LOOCV)",
    x = "",
    y = "Kappa"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

print(grafico_kappa)

ggsave(
  filename = "figures/Figura5_Kappa.png",
  plot = grafico_kappa,
  width = 8,
  height = 5,
  dpi = 300
)

#------------------------------------------------------------
# 5. Gráfico comparativo de Kappa
#------------------------------------------------------------

grafico_kappa <- ggplot(
  resultados,
  aes(
    x = reorder(Modelo, Kappa),
    y = Kappa,
    fill = Grupo
  )
) +
  geom_col(width = 0.7) +
  geom_text(
    aes(label = round(Kappa, 3)),
    hjust = -0.15,
    size = 4
  ) +
  coord_flip() +
  scale_fill_manual(
    values = c(
      "Mejor modelo" = "#2C7FB8",
      "Resto" = "#A6CEE3"
    )
  ) +
  labs(
    title = "Comparación del índice Kappa de los modelos",
    subtitle = "Validación cruzada Leave-One-Out (LOOCV)",
    x = "",
    y = "Kappa"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

print(grafico_kappa)

ggsave(
  filename = "figures/Figura5_Kappa.png",
  plot = grafico_kappa,
  width = 8,
  height = 5,
  dpi = 300
)
modelo_rf <- readRDS("output/modelo_rf.rds")

#------------------------------------------------------------
# 6. Importancia de variables (Random Forest)
#------------------------------------------------------------

modelo_rf <- readRDS("output/modelo_rf.rds")

imp_rf <- varImp(modelo_rf)

# Convertir a data.frame
imp_df <- imp_rf$importance
imp_df$Variable <- rownames(imp_df)

# Calcular la importancia máxima entre las tres clases
imp_df$Importancia <- apply(
  imp_df[, c("Bajo", "Medio", "Alto")],
  1,
  max
)

# Ordenar
imp_df <- imp_df[order(imp_df$Importancia), ]

# Gráfico
grafico_rf <- ggplot(
  imp_df,
  aes(
    x = reorder(Variable, Importancia),
    y = Importancia
  )
) +
  geom_col(fill = "#2C7FB8") +
  coord_flip() +
  labs(
    title = "Importancia de variables - Random Forest",
    x = "",
    y = "Importancia"
  ) +
  theme_minimal(base_size = 13)

print(grafico_rf)

ggsave(
  filename = "figures/Figura6_Importancia_RF.png",
  plot = grafico_rf,
  width = 8,
  height = 6,
  dpi = 300
)
