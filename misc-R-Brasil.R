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
