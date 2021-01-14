# Converter uma data do excel quando ela vem como código (tipo 42705)
# o pulo do gato é o "origin"
# https://stackoverflow.com/questions/43230470/how-to-convert-excel-date-format-to-proper-date-with-lubridate
as.Date(42705, origin = "1899-12-30")

# um exemplo da utilidade para se setar um aes no ggplot2
ggplot(mtcars, aes(wt, mpg)) + geom_path(aes(color = "path")) + geom_line(aes(color = "line"))


# importando fontes -------------------------------------------------------

extrafont::ttf_import("C:/Users/familia/Downloads/fonts/")

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


# fazer uma operação em cima dos valores de colunas cujos nomes se --------
# sejam números

mutate_at(.vars = vars(matches('\\d')), .funs = ~.*1e3)


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



# detectar múltiplos padrões ----------------------------------------------

# supondo que eu tenha: 
palavras <- c(NA, NA, "Estoque anterior1", "DPMFi", "DPFe", NA, "Estoque mês em análise", 
              "DPMFi", "DPFe", NA, "Variação Nominal", "DPMFi", "DPFe", NA, 
              "I - Gestão da Dívida - TN (I.1 + I.2)", NA, "I.1 - Emissão/Resgate Líquido", 
              NA, "I.1.1 - Emissões", "- Emissões Oferta Pública (DPMFi) 2", 
              "- Trocas Ofertas Públicas (DPMFi)3", "- Emissões Diretas (DPMFi) 4", 
              "- Emissões (DPFe) 5", NA)

# se eu quiser detectar as ocorrências de uma lista de termos que está num vetor, por exemplo:
termos_de_interesse <- c("DPMFi", "DPFe")

# veja que o paste/collapse transforma o vetor numa string no formato que preciso para detectar múltiplos termos (ou seja, termos separados por "|"):
paste(termos_de_interesse, collapse = "|")
# > "DPMFi|DPFe"

# posso usar:
str_detect(palavras, paste(termos_de_interesse, collapse = "|"))
# > c(NA, NA, FALSE, TRUE, TRUE, NA, FALSE, TRUE, TRUE, NA, FALSE, 
# TRUE, TRUE, NA, FALSE, NA, FALSE, NA, FALSE, TRUE, TRUE, TRUE, 
# TRUE, NA)

# agora o melhor: se eu quiser que ele me retorne não se tem ou não um dos termos desejados, mas o próprio termo desejado que foi encontrado naquela posição do vetor de palavras, posso usar str_extract:
str_extract(palavras, paste(termos_de_interesse, collapse = "|"))

# que me retorna, lindamente:
# > c(NA, NA, NA, "DPMFi", "DPFe", NA, NA, "DPMFi", "DPFe", NA, NA, 
#   "DPMFi", "DPFe", NA, NA, NA, NA, NA, NA, "DPMFi", "DPMFi", "DPMFi", 
#   "DPFe", NA)



# filtrar condicionalmente ------------------------------------------------

a <- letters[1:4]
b <- 1:4
df <- tibble::tibble(a, b)

match <- c("a", "b")

match <- NULL

library(tidyverse)

df %>% filter(a %in% match)
df %>% filter(TRUE)

df %>% filter(ifelse(is.null(match), TRUE , a %in% match)) # não funciona
df %>% filter(if_else(is.null(match), TRUE, a %in% match)) # dá erro por os valores em true e false serem de tipos/tamanhos diferentes (vetor x valor atômico)

df %>% filter(if (is.null(match)) TRUE
              else a %in% match)



# incluindo imagem / logo no rodape (ou outro lugar) ----------------------

# como visto em: https://github.com/bbc/bbplot/blob/master/R/finalise_plot.R

grafico <- ggplot2::ggplot(mpg, aes(displ, cyl)) + ggplot2::geom_point()
rodape <- grid::grobTree(grid::linesGrob(x = grid::unit(c(0,1), "npc"), y = grid::unit(1.1, "npc")),
                         grid::textGrob("Fonte:", x = 0.004, hjust = 0, gp = grid::gpar(fontsize=16)),
                         grid::rasterGrob(png::readPNG("logo_STN.png"), x = 0.9))

ggpubr::ggarrange(grafico, rodape, ncol = 1, nrow = 2, 
                  heights = c(1, 0.080))


# plotly ------------------------------------------------------------------

line = list(shape = "spline") # With "spline" the lines are drawn using spline interpolation. Ficam suavizadas.



# remover os ticks de um legenda de fill ou color -------------------------

#dentro do scale_color ou scale_fill: guide = guide_colourbar(ticks = FALSE)
# https://ggplot2.tidyverse.org/reference/guide_colourbar.html

scale_color_viridis(#...
                    guide = guide_colourbar(ticks = FALSE)) 


# para não exibir uma legenda específica (tipo color, ou fill) ------------

+ guides(color = "none")
# https://ggplot2.tidyverse.org/reference/guides.html

# gganimate - remover o aspecto pixelado de linhas e pontos ---------------

animate(#nome do objeto, 
  type = "cairo")


# gganimate problema com acentos ------------------------------------------

geom_text(aes(label = enc2native(coluna_do_label)))



# acompanhar execução de código -------------------------------------------

# Uma dica complementar a isso é inserir comandos cat() no código para imprimir uma mensagem para ver em que ponto da execução o código tá


# fazer transformações com base no {frame_along} em strings ---------------

gif_linhas_dpf <- grafico_linha_dpf +
  transition_reveal(Periodo) +
  labs(subtitle = paste("Estoque atualizado pelo IPCA até {lubridate::year(frame_along)}/{meses[lubridate::month(frame_along)]}")) 


# regex -------------------------------------------------------------------

x <- c("apple", "banana pie", "pear", "banana", "bananacake")
str_view(x, "banana")
str_view(x, "\\bbanana\\b")



# iterate over something --------------------------------------------------

vetor <- 1:10

for (i in seq_along(vetor)) {
  # do something
}

# Hadley's tip: avoid

for (i in 1:length(vetor)) {
  # do something
}

# because it fails in unhappy way if vetor has length 0


# para usar o mutate scoped e dar nome às novas variáveis -----------------

y <- data.frame(a = c(-2,  1, -2,  7,  2), 
                b = c( 6,  4, -1,  6, -3), 
                c = c(-5,  5, -4,  3,  2))

y

y %>% 
  mutate_all(funs(. > 0)) %>%
  mutate(or  = a | b | c,
         and = a & b & c)

y %>% 
  mutate_all(.funs = list(`>0` = ~(. > 0))) %>%
  mutate(or  = a | b | c,
         and = a & b & c)


# gganimate shadow apenas de algumas camadas ------------------------------

+ shadow_mark(exclude_layer = 2)  # o número da camada a excluir. assumi até agora que o número é a ordem em que elas aparecem no objeto ggplot.


# slopegraph com ajuste de margens (margin) e vetor de posicioname --------

load("desp_extremos.RData")

slope <- ggplot(desp_extremos, aes(x = Periodo, 
                                   y = valor, 
                                   color = classificador,
                                   group = classificador)) +
  geom_point(size = 3) +
  geom_line(size = .5) +
  geom_text(aes(label = ifelse(Periodo == 1,
                               paste0(classificador, "  ", round(valor,0), " bi  "),
                               paste0("  ", round(valor,0), " bi  (", var, ")")),
                y = ifelse(Periodo == 1, valor,
                           valor + c(0,0,.5,0,-10,0,-2.7,0))),
            hjust = "outward", vjust = "center",
            family = "Open Sans Condensed") +
  labs(y = NULL, x = NULL) +
  coord_cartesian(clip = "off", expand = FALSE) +
  #scale_x_discrete(expand = expand_scale(add = c(0, 0))) +
  scale_color_manual(values = paleta_darker) +
  tema() + theme(axis.line = element_blank(),
                 axis.text = element_blank(),
                 axis.ticks = element_blank(),
                 plot.margin =  margin(.5, 3, 0, 4.7, "cm"))

ggsave(plot = slope, "slope.png", h = 7, w = 5, type = "cairo-png")



# mapas (sumarizar, colorir municípios e mostrar bordas estados) ----------

# dá para a partir de um mapa de município gerar o mapa de estados, só por meio de um summarise

library(brazilmaps)
library(sf)

mapa_mun <- get_brmap("City") 

mapa_uf <- mapa_mun %>% group_by(State) %>% summarise()

# obvio que dava pra fazer tb (e, por sinal, fica menor na memória):
mapa_uf2 <- get_brmap("State") 


# anotações ---------------------------------------------------------------

  annotate("rect", ymin = quantile(dados_roe$ROE, 0.1), ymax = quantile(dados_roe$ROE, 0.9), fill = 'YellowGreen', xmin = -Inf, xmax = +Inf, alpha = 0.1) +
  geom_hline(yintercept = quantile(dados_roe$ROE, 0.9), linetype = "dotted") +
  geom_hline(yintercept = quantile(dados_roe$ROE, 0.1), linetype = "dotted") +
  annotate("text", x = 0.2, y = quantile(dados_roe$ROE, 0.9), vjust = -0.5,
         label = percent(quantile(dados_roe$ROE, 0.9), accuracy = 0.1), hjust = "inward", family = "Lora", color = cor_anotacoes, size = 3.5) +
  annotate("text", x = 0.2, y = quantile(dados_roe$ROE, 0.1), vjust = 1.4,
           label = percent(quantile(dados_roe$ROE, 0.1), accuracy = 0.1), hjust = "inward", family = "Lora", color = cor_anotacoes, size = 3.5) +
  annotate("curve", x = 0.5, xend = 0.55, 
           yend = 1, y = quantile(dados_roe$ROE, 0.5),
           curvature = -0.2, linetype = "dotted", color = cor_anotacoes) +
  labs(title = "Distribuição do ROE das empresas", x = NULL, y = NULL) +
  annotate("text", x = 0.55, y = 1,
           label = "80% das empresas têm ROE nessa faixa", hjust = "inward", family = "Lora", size = 3, color = cor_anotacoes, fontface = "italic") +


# inverter ordem na legenda -----------------------------------------------

+guides(fill = guide_legend(reverse=TRUE))  
  

# problema acnetuação gganimate -------------------------------------------

## quando vc importa uma coluna do excel, pode dar erro de acentuação / encoding no gganimate.
  
# a solução que tenho a sugerir, da qual não me orgulho kkkk, seria pegar a coluna que tem os labels, pegar os "níveis" dela (usando um unique(df$coluna_com_labels) ), reescrever esses níveis na mão (tipo labels_nao_cagados <- c("Ácéntôs_pra_que_te_quero", ...) ), e transformar a coluna original do dataframe em fator, passando esses nomes que vc escreveu na mão como o argumento levels (tipo, df$coluna_com_labels <- factor(df$coluna_com_labels, levels = labels_nao_cagados) )



# funções com dplyr -------------------------------------------------------

## um exemplo:

plota_sumario <- function(variavel) {
  
  quo_var <- enquo(variavel)
  
  ggplot(honras_simples_pre %>%
           group_by(!! quo_var) %>%
           summarise(valor = sum(valor)),
         aes(y = reorder(!! quo_var, valor), x = valor)) +
    geom_col()
}

# ver https://dplyr.tidyverse.org/articles/programming.html
# !!enquo(variavel)



# NAs ---------------------------------------------------------------------

mutate_at(.vars = vars(-time_minute), .funs = ~replace(., is.na(.), 0))
  

# quantas ocorrências únicas de uma determinada variável? -----------------

> ploa %>% select(acao) %>% unique() %>% unlist() %>% length()
[1] 1185
> ploa %>% select(acao) %>% unique() %>% nrow()
[1] 1185
> ploa %>% select(acao) %>% distinct() %>% nrow()
[1] 1185  
