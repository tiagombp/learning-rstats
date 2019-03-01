# Converter uma data do excel quando ela vem como código (tipo 42705)
# o pulo do gato é o "origin"
# https://stackoverflow.com/questions/43230470/how-to-convert-excel-date-format-to-proper-date-with-lubridate
as.Date(42705, origin = "1899-12-30")

# um exemplo da utilidade para se setar um aes no ggplot2
ggplot(mtcars, aes(wt, mpg)) + geom_path(aes(color = "path")) + geom_line(aes(color = "line"))



# rstats performance tip: if you must grow a vector in a loop, make sure there's only one reference to it so that R doesn't have to make a copy on each iteration.

# 6 seconds:
x <- integer()
for(i in 1:5e4) x <- c(x, i)

# 0.02 seconds:
x <- integer()
for(i in 1:5e4) x[i] <- i



# filtrar pelo número da coluna
mtcars %>% filter(.[2] == 6)



# formatar eixo
+ scale_y_continuous(labels=function(x) {format(x, big.mark = ".", decimal.mark=",", scientific = FALSE)})

# ou

+ scale_y_continuous(labels=scales::format_format(big.mark = ".", decimal.mark = ",", scientific = FALSE))




# Processa tabela da dívida / Inconsistência seleção de variáveis dplyr, tidyr

recurso_TT <- resource_show(id="530e012d-1f9d-41a9-8cab-49849313e018", url="https://apickan.tesouro.gov.br/ckan")
download.file(recurso_TT$url, destfile = "./exec_divida.csv", mode = 'wb')
tabela <- read.csv2("exec_divida.csv")

# Processamento dos dados 

dados <- tabela %>%
  mutate_at(vars(c("janeiro":"dezembro")), ~as.numeric(as.character(.))) %>% #(1)
  gather(c("janeiro":"dezembro"), key = "Mês", value = "Valor") %>%
  mutate(Valor = replace_na(Valor, 0))

# (1) nova syntaxe do dplyr. para passar o range de variáveis, tive que sar o "vars".

meses <- tibble(Mês = unique(dados$Mês), num_Mes = str_pad(1:12, 2, pad = "0")) # (2)

# (2) beautiful, esse str_pad

dados <- dados %>%
  left_join(meses) %>%
  mutate(Data = as.Date(paste(Exercício, num_Mes, "01", sep = "-")))




# preencher uma coluna com o último valor válido

x <- data.frame(Titulos = rep(c("Prefixados", "Inflacao", "Cambio"),2), 
                Emissao_Resgate = c("Emissao", NA, NA, "Resgate", NA, NA))
                
x %>% fill(Emissao_Resgate)
# just like magic


# expandir escala
# https://ggplot2.tidyverse.org/reference/expand_scale.html
scale_y_continuous(labels=function(x) {format(x/1e9, big.mark = ".", decimal.mark=",", scientific = FALSE)}, expand = expand_scale(mult = c(0, .1))) 

expand_scale(mult = 0, add = 0)

# Arguments
# 
# mult	
# vector of multiplicative range expansion factors. If length 1, both the lower and upper limits of the scale are expanded outwards by mult. If length 2, the lower limit is expanded by mult[1] and the upper limit by mult[2].
# 
# add	
# vector of additive range expansion constants. If length 1, both the lower and upper limits of the scale are expanded outwards by add units. If length 2, the lower limit is expanded by add[1] and the upper limit by add[2].



