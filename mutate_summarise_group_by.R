library(gapminder)
install.packages('gapminder
                 ')
library(dplyr)

x <- data.frame("cat" = c("A", "B", "A", "A", "B", "C"), "value" = c(1, 2, 3, 4, 5, 6))

x %>% summarise(media = mean(value))

x %>% group_by(cat) %>%
  mutate(media_mu = mean(value)) 

x %>% group_by(cat) %>%
  summarise(media_mu = mean(value))

