
lancamentos <- c(
  F,F,T,T,F,F,F,F,F,F,
  T,T,F,F,F,F,T,T,F,F,
  T,F,F,F,T,F,F,F,T,T,
  T,T,F,F,F,F,T,T,T,F,
  T,F,F,T,F,F,T,F,T,F,
  F,F,T,T,T,T,T,F,F,F,
  T,T,F,T
)

complementos <- sample(c(T,F), replace=TRUE, size=100000)

lancamentos <- c(lancamentos, complementos)

n_lancamento <- 1:length(lancamentos)

tab <- data.frame(n_lancamento, lancamentos) %>%
  mutate(lado = ifelse(lancamentos, "cara", "coroa"),
         vlr = 1) %>%
  select(-lancamentos) %>%
  spread(lado, vlr, fill = 0) %>%
  mutate(cara_ac = cumsum(cara),
         coroa_ac = cumsum(coroa),
         prob_cara = cara_ac / n_lancamento,
         prob_coroa = coroa_ac / n_lancamento)

ggplot(tab, aes(x = n_lancamento)) +
  geom_line(aes(y = prob_cara), color = "blue", size = 1) +
  geom_line(aes(y = prob_coroa), color = "green", size = 1) +
  geom_hline(yintercept = 0.5, color = "goldenrod", size = 2, linetype = "dashed")

