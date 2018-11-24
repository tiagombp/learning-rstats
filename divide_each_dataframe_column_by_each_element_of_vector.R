library(tidyverse)

# tenho essa data frame
X <- data.frame("a" = rep(10, 10), "b" = rep(20,10), "c" = rep(30,10))

# quero dividir cada coluna pelo elemento correspondente nesse vetor:
vector_x <- c("a" = 10, "b" = 20, "c" = 30)

# se eu tenho um data frame com uma única observação e várias variáveis,
# como se fosse o vetor, eu sei que funciona. a questão é como gerar esse
# vetor de forma simples.

vector_dataframed <- as.matrix((vector_x))

# me resulta em um data frame com uma variável. 
# posso transpô-lo e convertê-lo em data.frame:

vector_dataframed <- as.data.frame(t(vector_dataframed))

# agora sim, vamos dividir:

X_alterado <- X %>%
  mutate_all(funs(. / vector_dataframed$.))

### Outra solução para a conversão do vetor em data frame:
vector_dataframed2 <- data.frame(as.list(vector_x))

X_alterado2 <- X %>%
  mutate_all(funs(. / vector_dataframed2$.))

# comparando os resultados:
identical(vector_dataframed, vector_dataframed2)
identical(X_alterado, X_alterado2)
