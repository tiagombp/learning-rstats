library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(colorspace)
library(extrafont)

# frescurinhas ------------------------------------------------------------


loadfonts()

tema <- function(){
  theme_minimal() +
    theme(
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(),
      axis.ticks = element_blank(),
      axis.ticks.length.x = unit("0.25", "cm"),
      axis.line = element_blank(),
      axis.text.y = element_blank(),
      axis.text.x = element_text(family = "Roboto Slab", size = 12, face = "bold",
                               color = "black"),
      legend.position = 'none',
      plot.background = element_rect(fill = "ghostwhite", color = NA))
}


# gera uma base fake ------------------------------------------------------

paises <- strsplit(c("Brazil, Chile, Germany, Israel, Italy, Mexico, Poland, Portugal, Tunisia, Turkey"), ", ")[[1]]

pisa_fake <- data.frame(
  Pais = paises,
  Maths   = runif(length(paises), min = 500, max = 600),
  Reading = runif(length(paises), min = 500, max = 600),
  Science = runif(length(paises), min = 500, max = 600)
)


# faz um ranking dos países -----------------------------------------------

pisa_fake_long <- pisa_fake %>%
  gather(-Pais, key = Materia, value = Nota)

pisa_fake_ranking <- pisa_fake %>%
  mutate_at(vars(-Pais), .funs = ~dense_rank(-.)) %>%
  gather(-Pais, key = Materia, value = Posicao)

pisa_fake_completo <- pisa_fake_long %>%
  left_join(pisa_fake_ranking)

numero_Materias  <- length(unique(pisa_fake_completo$Materia))
primeira_Materia <- unique(pisa_fake_completo$Materia)[1]
numero_Paises    <- length(unique(pisa_fake_completo$Pais))



# faz o gráfico -----------------------------------------------------------


ggplot(pisa_fake_completo, aes(x = Materia, y = Posicao, group = Pais, color = Pais)) +
  geom_line(size = 1.5) +
  geom_point(aes(color = Pais), size = 12) +
  geom_text(aes(label = round(Nota)), color = "ghostwhite", size = 4, 
            family = "Source Serif Pro", fontface = "bold", vjust = 0.4) +
  geom_text(aes(label = paste0(Posicao, 'º'), x = numero_Materias + 0.15), size = 4, 
            fontface = "bold", family = "Source Serif Pro", hjust = "left", 
            vjust = 0.4, color = "#bfbfbf") +
  geom_text(aes(label = ifelse(Materia == primeira_Materia, as.character(Pais), NA), 
                x = 0.45, color = Pais, fontface = "bold", size = 4),
            family = "Source Serif Pro", hjust = "left", vjust = "center") +
  labs(x = NULL, y = NULL) +
  coord_cartesian(clip = "off") +
  scale_x_discrete(position = "top") +
  scale_y_reverse() +
  scale_color_discrete_qualitative(palette = "Dark 3") +
  #scale_color_viridis_d(option = "plasma") +
  tema()

ggsave(plot = last_plot(), filename = "pisa_fake.png", height = 4, width = 6, type = "cairo-png")
