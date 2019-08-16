library(brazilmaps)
library(sf)
library(tidyverse)

mapa_mun <- get_brmap("City")
mapa_uf  <- get_brmap("State")

mapa_mun_altamira <- mapa_mun %>% mutate(colorido = ifelse(nome == "ALTAMIRA", "Altamira", "Demais municípios")) %>%
  group_by(colorido) %>% 
  summarise()

mapa_uf_para <- mapa_uf %>% mutate(colorido = ifelse(nome == "PARÁ", "Pará", "Demais estados"))

plot <- ggplot() +
  geom_sf(data = mapa_uf_para, aes(fill = colorido), color = "grey") +
  geom_sf(data = mapa_mun_altamira, aes(fill = colorido), color = NA) +
  scale_fill_manual(values = c("Altamira" = "goldenrod", 
                               "Pará" = "khaki",
                               "Demais estados" = "ghostwhite",
                               "Demais municípios" = "transparent")) +
  theme_minimal() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        legend.position = 'none')

ggsave(plot, file = "mapa.png", device = "png", type = "cairo")


# Você pode pegar o mapa da america do sul por países, e do brasil por estados, e plotar duas camadas de geom_sf(), cada uma apontando para um dos dataframes

# vou fazer um exemplo

# para ficar mais leve e ele renderizar (bem) mais rápido, como no meu caso não preciso dos demais municípios, eu poderia fazer um group_by pela variável que usei para determinar o município de interesse (ou o estado de interesse, no seu caso) junto com um summarise():
  
  mapa_mun_altamira <- mapa_mun %>% mutate(colorido = ifelse(nome == "ALTAMIRA", "Altamira", "Demais municípios")) %>%
  group_by(colorido) %>% 
  summarise()
  
# em vez de fazer o pobre R plotar 5570 "geometrias", das quais 5569 serão transparentes, ele só plota 2, das quais uma será transparente.

# na verdade não sei quase nada de mapas, aprendi com o tutorial do curso-R e experimentações, e agradeço aos céus pelo brazilmaps e pelo geom_sf(). por isso, se alguém me pedisse para incluir uma rosa dos ventos num gráfico, eu acho que usaria ggplot2 mesmo apelando para o grid e o ggpubr. :flushed:
  
# tipo o que a BBC faz para incluir o logo da empresa nos gráficos que eles geram em R (:heart:):
  
# https://github.com/bbc/bbplot/blob/master/R/finalise_plot.R