insert_into <- function(x, y, where = 1) {
  if (where == 1) { # first col
    return(cbind(y,x))
  } else if (where > ncol(x)) { # last col
    return(cbind(x,y))
  } else {
    x_first <- x[,1:where-1]
    x_last  <- x[,where:ncol(x)]
    return(cbind(x_first, y, x_last))
  }
}
# Hint: cbind() will be useful
# Add the columns of df2 to df1 at position where

x <- mpg
y <- mpg[,2:4]

z <- insert_into(x, y, where = 42)

usethis::create_package("~/Documents/Github/ajeitacol")

test()
test_coverage()
