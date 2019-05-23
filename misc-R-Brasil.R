library(DiagrammeR)
grViz("
      digraph {
      
      graph[splines=ortho, nodesep=1]
      
      node[shape=Mrecord]
      A;B;C;D;
      
      A->{B,C,D}
      }
      ")

library(tidyverse)
tibble(ID = c(rep(1:3, 2), 4), 
       Nombres = c("Felipe",  "Monica", "Jaime", 
                   "Jaime", "Jaime", "João", "Maria")) %>%
  group_by(ID) %>%
  summarise(Name1 = first(Nombres),
            Name2 = nth(Nombres,2)) %>%
  select(-ID)


# sugestão Sillas
df <- tibble(ID = c(rep(1:3, 2), 4), 
             Nombres = c("Felipe",  "Monica", "Jaime", "Jaime", "Jaime", "João", "Maria"))


inner_join(df, df, by = "ID")


# george converter uma tabela hierárquica -----------------------------------------------

secao   <- c("secA", NA, NA, NA, NA, NA, NA)
divisao <- c(NA, "div1", NA, NA, NA, NA, NA)
grupo   <- c(NA, NA, "grp1", NA, "grp2", NA, NA)
classe  <- c(NA, NA, NA, "cls1", NA, "cls2", "cls3")
nomes   <- c("seção A", "divisão 1", "Grupo 1", "Classe 1", "Grupo 2", "Classe 2", "Classe 3")

tab <- data.frame(secao, divisao, grupo, classe, nomes)

tab_bonitinha <- tab %>% 
  mutate_at(.vars = vars(-nomes), 
            .funs = ~ifelse(!is.na(.), 
                            paste(., nomes, sep = "|"), 
                          NA)) %>%
  fill(secao) %>%
  fill(divisao) %>%
  fill(grupo) %>%
  fill(classe) %>%
  filter(!is.na(classe)) %>%
  select(-nomes) %>%
  rowwise() %>%
  mutate_all(.funs = list(
    cod = ~str_split(., "\\|")[[1]][1],
    nm  = ~str_split(., "\\|")[[1]][2])
  ) %>%
  select(contains("_"))




separate(secao, sep = "|", into = c("_cod", "_nm"))
mutate_all(.funs = list(nm = ))

tab_bonitinha2 <- tab %>% 
  mutate_at(.vars = vars(-nomes), 
            .funs = list(
              nm = ~ifelse(!is.na(.), paste(., nomes), NA))) %>%
  fill(secao_nm) %>%
  fill(divisao_nm) %>%
  fill(grupo_nm) %>%
  fill(classe_nm) %>%
  filter(!is.na(classe_nm)) %>%
  select(contains("_nm"))


# gráfico de barras -------------------------------------------------------

val <- c(464,557,630,747,837,940,1036,1167,1290,1293,1331,1359)
ano <- 2007:2018

desp_bahia <- data.frame("despesas" = val, "Ano" = ano)

ggplot(desp_bahia, aes(y = despesas, x = as.character(anos))) + 
  geom_col(width = 0.7, fill = "goldenrod") +
  geom_text(aes(label = format(despesas, 
                               big.mark = ".", 
                               decimal.mark = ",")),
            nudge_y = 50, family = "Open Sans", size = 3, color = "darkgoldenrod") +
  scale_y_continuous(labels = function(x) {format(x, big.mark = ".", decimal.mark = ",")}) +
  labs(x = NULL,
      y = NULL,
      title = "Orçamento Aplicado (sic) nas Universidades Estaduais da Bahia",
      subtitle = "Valores reais? nominais? Bom, em milhões de R$, de qualquer forma",
      caption = "Fonte: Gráfico show de bola do Governo da Bahia") +
  tema() + theme(title = element_text(color = "grey20"),
                 plot.subtitle = element_text(color = "darkgoldenrod"))

ggsave(filename = "bahia_deflac.png", width = 7, height = 5)

ipca <- rev(c(4.46, 5.90, 4.31, 5.91, 6.50, 5.84, 5.91, 6.41, 10.67, 6.29, 2.95))
names(ipca) <- 2007:2017

deflator <- 1
ult_deflator <- 1

for (el in ipca) {
  ult_deflator <- ult_deflator * (1 + el/100)
  deflator <- c(deflator, ult_deflator)
}

deflator <- rev(deflator)
desp_bahia$deflator <- deflator

desp_bahia_deflat <- desp_bahia %>%
  mutate(desp_deflac = despesas * deflator) %>%
  gather(c(despesas, desp_deflac), key = "variavel", value = "valor")
  
ggplot(desp_bahia_deflat, aes(y = valor, fill = variavel, x = as.character(Ano))) + 
  geom_col(position = "dodge2", width = 0.7) +
  # geom_text(aes(label = format(despesas, 
  #                              big.mark = ".", 
  #                              decimal.mark = ",")),
  #           nudge_y = 50, family = "Open Sans", size = 3, color = "darkgoldenrod") +
  scale_y_continuous(labels = function(x) {format(x, big.mark = ".", decimal.mark = ",")}) +
  scale_fill_manual(values = c("despesas" = "goldenrod", "desp_deflac" = "#0885A6"),
                    labels = c("despesas" = "Valores nominais", "desp_deflac" = "Valores reais (preços de 2018)")) +
  labs(x = NULL,
       y = NULL,
       title = "Orçamento Aplicado (sic) nas Universidades Estaduais da Bahia",
       subtitle = "Valores nominais x valores reais (a preços de 2018), em milhões de R$",
       caption = "Fonte: Gráfico show de bola do Governo da Bahia e IpeaData",
       fill = NULL) +
  tema() + theme(title = element_text(color = "grey20"),
                 plot.subtitle = element_text(color = "grey40"),
                 legend.position = "bottom",
                 legend.text = element_text(size = 8, color = "grey40"),
                 legend.key.size = unit(0.1, "inches"))

