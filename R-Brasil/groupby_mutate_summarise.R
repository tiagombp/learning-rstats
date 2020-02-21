library(tidyverse)

mpg %>% 
  head(10) %>% 
  select(model) %>%
  group_by(model) %>%
  mutate(numero_da_linha = row_number(),
         paridade = unlist(purrr::map(numero_da_linha, function(numero_da_linha) {
           if (numero_da_linha %% 2 == 0) return("É par")
           else return("não é par")
         })))

paridade = function(numero_da_linha) {
  if (numero_da_linha %% 2 == 0)
  {return("É par!")}
  else {return("não é par!")}}
  
  group_by(model) %>%
  mutate(qde_de_carros = n(),
         maior_displ = max(displ),
         media_cyl = mean(cyl),
         num_linha = row_number())
