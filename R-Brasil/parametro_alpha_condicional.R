library(tidyverse)
library(lubridate)

periodo <- seq(ymd("2020-01-01"), 
               ymd("2020-12-31"), 
               by="weeks")

data <- data.frame(
  periodo = periodo,
  valores = runif(length(periodo)) + 2)
)

data %>% ggplot(aes(x = periodo, y = valores)) + 
  geom_line(alpha = ifelse(periodo >= ymd("2020-06-01"), .4, 1),
            size = 2, color = "steelblue") +
  scale_y_continuous(limits = c(0,NA)) +
  theme_bw() + 
  theme(legend.position = "none",
        panel.grid = element_blank())

data2 <- data %>%
  mutate(is_forecast = periodo >= ymd("2020-06-01"))

data2 %>% ggplot(aes(x = periodo, y = valores, alpha = is_forecast)) + 
  geom_line() +
  scale_y_continuous(limits = c(0,NA)) +
  scale_alpha_manual(values = c("T" = .5, "F" = 1)) +
  theme_minimal() + 
  theme(legend.position = "none")

