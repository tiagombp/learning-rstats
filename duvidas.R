# por que a seleção de variáveis no dplyr, no caso dos scoped, é diferente da seleção do gather?
# por exemplo:

dados <- tibble(z = 1:10, x = 1:10, y = 1:10, d = letters[1:10])

dados %>%
  mutate_at(vars(c("z":"y")), ~ . * 10) %>% 
  gather(c("z":"y"), key = "variaveis", value = "valores") 
