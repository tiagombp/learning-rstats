library(tidyverse)
library(lubridate)

meses <- c("janeiro","fevereiro","março","abril","maio",
           "junho","julho","agosto","setembro","outubro",
           "novembro","dezembro")

df <- data.frame(Dia = sample(1:20),
                 Mes = sample(c("janeiro","fevereiro","março","abril","maio",
                          "junho","julho","agosto","setembro","outubro",
                          "novembro","dezembro"), 20, replace = TRUE),
                 Ano = rep(2019,20))

df_com_data <- df %>% 
  mutate(
    data = make_date(year = Ano, 
                     month = match(Mes, meses), 
                     day = Dia))

lubridate::make_date(year = 2019, month = 1)
