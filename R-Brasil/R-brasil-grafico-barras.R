library(tidyverse)

ano <- 2016:2019

valor_nao_contestado <- runif(length(ano), min = 0, max = 1000)
valor_deferido       <- runif(length(ano), min = 0, max = 1000)
valor_indeferido     <- runif(length(ano), min = 0, max = 1000)
valor_em_analise     <- runif(length(ano), min = 0, max = 1000)

tabela <- data.frame(ano, valor_nao_contestado, valor_deferido, valor_indeferido, valor_em_analise)

tabela_para_grafico <- tabela %>%
  gather(contains("valor"), key = "tipo_valor", value = "valor")

grafico <- ggplot(tabela_para_grafico, aes(x = tipo_valor, y = valor, fill = as.character(ano))) +
  geom_col(position = position_dodge(0.9), color = "white") +
  scale_x_discrete(labels = c("valor_nao_contestado" = "Valor Não Contestado",
                              "valor_deferido"       = "Valor Deferido",
                              "valor_indeferido"     = "Valor Indeferido",
                              "valor_em_analise"    =  "Valor em Análise")) +
  geom_text(aes(label = paste("R$", round(valor, 0)), y = valor + 30), 
            position = position_dodge(0.9), size = 2, hjust = "center") +
  labs(x = NULL, y = "R$ bilhões", fill = NULL) +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.title.y = element_text(hjust = 1),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

ggsave(grafico, type = "cairo", filename = "grafico.png")
