d1 <- 1:10
r1 <- 1:10
d2 <- 1:10
r2 <- 1:10

D1 <- data.frame(d1)
D2 <- data.frame(d2)
R1 <- data.frame(r1)
R2 <- data.frame(r2)

# D <- D1 %>% 
#   full_join(D2, by = NULL) %>%
#   full_join(R1, by = NULL) %>%
#   full_join(R2, by = NULL)

D <- merge(D1, D2)
D <- merge(D, R1)
D <- merge(D, R2)

D <- D %>%
  mutate(media = (d1/r1 + d2/r2)/2,
         total = (d1 + d2) / (r1 + r2))

plot(D$media, D$total)
