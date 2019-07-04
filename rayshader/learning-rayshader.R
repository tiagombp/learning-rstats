# https://github.com/tylermorganwall/rayshader

# https://www.curso-r.com/blog/2019-02-10-sf-miojo/

# https://www.tylermw.com/3d-ggplots-with-rayshader/

library(rayshader)
library(ggplot2)
library(readxl)
library(tidyverse)
library(brazilmaps)
library(sf)
library(viridis)
library(extrafont)

loadfonts()

dados_ibge <- read_excel("ibge_mun.xls", sheet = "Variáveis externas")

mapa <- get_brmap("City") 
mapa_dados <- mapa %>% 
  inner_join(dados_ibge, c("City" = "CodMun")) %>% 
  rename(pop = `POP EST`,
         catPop = `CLASSE POP`)


mapa <- ggplot(mapa_dados) + 
  geom_sf(aes(fill = pop), color = NA) + 
  scale_fill_viridis(direction = -1, labels = function(x){format(x/1e3, decimal.mark = ",", big.mark = ".")}) + 
  labs(fill = "População") +
  theme_classic() + 
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(family = "Source Sans Pro"),
        legend.position = "bottom")

#render_depth(focallength=100,focus=0.72)

plot_gg(mapa,multicore=TRUE,width=8,height=8,scale=350)
render_camera(fov = 70, zoom = 0.5, theta = 130, phi = 35)
render_camera(fov = 45, zoom = 0.35, theta = 10, phi = 40)
# phi: azimuth
# theta: rotação

render_movie("teste.mp4")

#
#render_camera()



# gg = ggplot(diamonds, aes(x, depth)) +
#   stat_density_2d(aes(fill = stat(nlevel)), 
#                   geom = "polygon",
#                   n = 100,bins = 10,contour = TRUE) +
#   facet_wrap(clarity~.) +
#   scale_fill_viridis_c(option = "A")
# plot_gg(gg,multicore=TRUE,width=5,height=5,scale=250)

# ver:
# https://github.com/kraaijenbrink/warmingstripes-3d/blob/master/animate.r
