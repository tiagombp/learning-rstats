# Converter uma data do excel quando ela vem como código (tipo 42705)
# o pulo do gato é o "origin"
# https://stackoverflow.com/questions/43230470/how-to-convert-excel-date-format-to-proper-date-with-lubridate
as.Date(42705, origin = "1899-12-30")