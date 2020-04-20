library(tidyverse)

tab <- data.frame(
  linhas  = c("t1", "t2", "t3"),
  valores = c("a,b,c", "a,d,e,h", "f,c,g")
)

max_val <- max(str_count(tab$valores, ",")) + 1


tab_mod <- tab %>%
  separate(valores, into = paste0("val", 1:max_val), ) %>%
  pivot_longer(cols = starts_with("val"),
               names_to = "val",
               values_to = "valores") %>%
  filter(!is.na(valores)) %>%
  group_by(valores) %>%
  summarise(
    linhas = linhas %>% unique() %>% str_c(collapse = ",")
  )

# v_simples
tab_mod <- tab %>%
  separate(valores, into = paste0("val", 1:max_val), ) %>%
  pivot_longer(cols = starts_with("val"),
               names_to = "val",
               values_to = "valores") %>%
  filter(!is.na(valores)) %>%
  group_by(valores) %>%
  summarise(
    linhas = str_c(unique(linhas), collapse = ",")
  )

