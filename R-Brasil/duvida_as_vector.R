library(readxl)
library(tidyverse)

dados <- read_excel("./R-Brasil/artigos.xlsx")

urls <- dados$Link 
destinations <- dados$Nome

for(i in seq_along(urls)){ 
  download.file(urls[i], paste0(destinations[i],".pdf")) 
}                   

as.vector(dados %>% select(Nome))

as.vector(data.frame(a = c(1,2), b = c(3,4))[,1])
as.vector(data.frame(a = c(1,2), b = c(3,4)) %>% select(a))

x <- matrix(data = 1:6, nrow = 2, byrow = TRUE)
x
as.vector(x)
