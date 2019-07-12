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

# como a área inteira do município é projetada, o mais lógico talvez fosse usar a densidade média no município, e não a população.

mapa <- ggplot(mapa_dados) + 
  geom_sf(aes(fill = pop), color = NA) + 
  scale_fill_viridis(direction = -1,
                     option = "magma",
                     #breaks = c(1e3, 100e3, 10000e3),
                     #trans = "log", #para usar uma escala de log
                     labels = function(x){format(x/1e6, decimal.mark = ",", big.mark = ".")}) + 
  labs(fill = "População \n(milhões)") +
  theme_classic() + 
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(family = "Source Sans Pro"),
        legend.position = "none",
        legend.text = element_text(size = 10),
        plot.background = element_blank(),
        panel.background = element_blank())

#render_depth(focallength=100,focus=0.72)

plot_gg(mapa,multicore=TRUE,width=12,height=12,scale=350)
render_camera(fov = 70, zoom = 0.5, theta = 20, phi = 35)
render_camera(fov = 75, zoom = 0.45, theta = 0, phi = 40)
render_camera(fov = 45, zoom = 0.35, theta = 0, phi = 30)
render_camera(fov = 45, zoom = 0.35, theta = 10, phi = 50)
render_camera(fov = 90, zoom = 0.15, theta = 10, phi = 20)

render_camera(fov = 45, zoom = 0.25, theta = 0, phi = 30)
render_camera(fov = 15, zoom = 0.25, theta = 0, phi = 30)
render_camera(fov = 45, zoom = 0.45, theta = 10, phi = 40)
render_camera(fov = 45, zoom = 0.35, theta = 10, phi = 40)
# phi: azimuth
# theta: rotação
# dá para passar vetores de zoom, fov, theta e phi para fazer a câmera passear.
render_snapshot("brasil3d.png")
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
