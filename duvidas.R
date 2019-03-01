# por que a seleção de variáveis no dplyr, no caso dos scoped, é diferente da seleção do gather?
# por exemplo:

dados <- tibble(z = 1:10, x = 1:10, y = 1:10, d = letters[1:10])

dados %>%
  mutate_at(vars(c("z":"y")), ~ . * 10) %>% 
  gather(c("z":"y"), key = "variaveis", value = "valores") 

# read_csv2 e read.csv2. O primeiro zoneia o encoding da coluna. Deve dar para configurar.

questão do aes quando a variável é data. o ifelse normal dá erro, mas com o if_else funciona.

exemplo.

load("dados_exemplo.RData")

ggplot(dados_graf %>% filter(Ano %in% c("2017", "2018")), aes(y = y, yend = yend, xend = Periodo)) +
  geom_point(aes(x = Periodo, y = ifelse(fatores == "Estoque_ant", yend, NA))) +
  geom_label(aes(x = Periodo, y = ifelse(fatores == "Estoque_ant", yend-1e5, NA),
                 label = paste0(
                   format(round(yend/1e6,2), big.mark = ".", decimal.mark = ","),
                   " bi")), 
             family = "Source Sans Pro", fill = "dimgrey", color = "white", size = 2) +
  geom_segment(aes(color = ifelse(fatores == "Estoque_ant", 
                                  "invisivel", 
                                  as.character(fatores)),
                   x = if_else(fatores == "Resgates", Periodo + 10, Periodo), # (1)
                   xend = if_else(fatores == "Resgates", Periodo + 10, Periodo)), size = 2) +
  geom_segment(aes(x = Periodo + 10, 
                   xend = prox_periodo, 
                   y = ifelse(fatores == "Estoque_ant", prox_estoque, NA),
                   yend = ifelse(fatores == "Estoque_ant", prox_estoque, NA)),
               linetype = "dotted") +
  scale_color_manual(values = c("Juros" = "red", 
                                "Emissões" = "firebrick",
                                "Resgates" = "dodgerblue",
                                "estoque" = NA)) +
  scale_y_continuous(labels = function(x) {format(x/1e6, big.mark = ".", decimal.mark = ",")}) +
  tema()

# (1) por algum motivo, o ifelse normal não funciona aqui. Dá um erro de tipo. Pesquisar um dia.