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
