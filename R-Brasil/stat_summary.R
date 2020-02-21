library(tidyverse)

df <- mpg %>%
  group_by(manufacturer) %>%
  summarise(media = mean(displ)) %>%
  ungroup() %>%
  right_join(mpg)

ggplot(df, aes(x = manufacturer)) +
  geom_boxplot(aes(y = displ)) +
  geom_point(color = "red", aes(y = media))

ggplot(df, aes(x = manufacturer, y = displ)) +
  geom_boxplot() +
  stat_summary(fun.y = mean, geom = "point", color = "blue") +
  geom_point(color = "red", aes(y = media))
