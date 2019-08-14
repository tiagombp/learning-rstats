# gera uma base fake

paises <- strsplit(c("Brazil, Chile, Germany, Israel, Italy, Mexico, Poland, Portugal, Tunisia, Turkey"), ", ")[[1]]

pisa_fake <- data.frame(
  Pais = paises,
  Maths   = runif(length(paises), min = 500, max = 600),
  Reading = runif(length(paises), min = 500, max = 600),
  Science = runif(length(paises), min = 500, max = 600)
)

# rankeando os paises

ranking_pisa <- pisa_fake %>%
  mutate_at(vars(-Pais), .funs = ~dense_rank(-.)) %>%
  gather(-UF, -pop, - REGIAO, key = Variavel, value = Valor) %>%
  filter(Variavel %in% c("DCL", "pct_DCL_RCL", "DCL_pop"))

