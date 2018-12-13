library(tidyverse)

mat <- matrix(1:(21*21), ncol = 21)

tab <- as.data.frame(mat)

tab2 <- tab %>%
  rename_all(funs(. = 0:20)) %>%
  mutate(n11 = 0:20) %>%
  gather(-n11, key = n12, value = value) %>%
  select(-value) %>%
  mutate(n12 = as.integer(n12))

tab3 <- tab2 %>%
  rename_all(funs(. = c("n21", "n22")))

tabelao <- merge(tab2, tab3)

tabelao <- tabelao %>%
  mutate(total = sum(c(1:4)))        