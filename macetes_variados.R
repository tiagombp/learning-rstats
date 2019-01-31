# Converter uma data do excel quando ela vem como código (tipo 42705)
# o pulo do gato é o "origin"
# https://stackoverflow.com/questions/43230470/how-to-convert-excel-date-format-to-proper-date-with-lubridate
as.Date(42705, origin = "1899-12-30")

# um exemplo da utilidade para se setar um aes no ggplot2
ggplot(mtcars, aes(wt, mpg)) + geom_path(aes(color = "path")) + geom_line(aes(color = "line"))


#rstats performance tip: if you must grow a vector in a loop, make sure there's only one reference to it so that R doesn't have to make a copy on each iteration.

# 6 seconds:
x <- integer()
for(i in 1:5e4) x <- c(x, i)

# 0.02 seconds:
x <- integer()
for(i in 1:5e4) x[i] <- i