library(tidyverse)
library(readxl)

grid <- read_excel("./grid_letras.xlsx", sheet = "export")

new_grid <- as.data.frame(grid[,-1])

gera_grid <- function(grid_inicial) {
  
  coordenadas <- data.frame()
  
  n <- 1
  
  for (x in 1:dim(grid_inicial)[2]) {
    for (y in 1:dim(grid_inicial)[1]) {
      if (!is.na(grid_inicial[y,x])) {
        coordenadas[n,1] <- x
        coordenadas[n,2] <- y
        n <- n+1
      }
    }
  }
  
  coordenadas_export <- coordenadas %>%
    rename(x = V1,
           y = V2) %>%
    mutate(nome = paste("ponto_", row_number()))
  
  return(coordenadas_export)
}


exportar <- gera_grid(new_grid)

#testa
ggplot(exportar, aes(x = x, y = y)) + 
  geom_point()  + 
  scale_y_reverse()

#grava / exporta
write.csv(exportar, file = "grid.csv")
