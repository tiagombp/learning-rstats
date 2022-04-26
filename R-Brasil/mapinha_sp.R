library(sf)
library(tidyverse)

mun_sp <- geobr::read_municipality(code_muni = 3550308)

ggplot() + 
  geom_sf(data = mun_sp)
