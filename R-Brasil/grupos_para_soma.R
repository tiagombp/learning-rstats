library(tidyverse)

col_a <- runif(30)*1000

df <- data.frame(ab = col_a)

df_proc <- df %>%
  mutate(
    grupo = (row_number()-1) %/% 5) %>%
  group_by(grupo) %>%
  mutate(soma_grupo = sum(ab))

