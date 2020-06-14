ggplot(mtcars, aes(x = disp, y = mpg)) + 
  geom_point() + 
  facet_wrap(~cyl)

rotulos <- c(
  "4" = "quatro",
  "6" = "seis",
  '8' = "oito"
)

ggplot(mtcars, aes(x = disp, y = mpg)) + 
  geom_point() + 
  facet_wrap(~cyl, labeller = labeller(cyl = rotulos))
