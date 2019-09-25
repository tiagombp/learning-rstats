insert_into <- function(x, y, where = 1) {
  if (where == 1) { # first col
    return(cbind(y,x))
  } else if (where > ncol(x)) { # last col
    return(cbind(x,y))
  } else {
    return(cbind(x[1:where-1], y, x[where:ncol(x)]))
  }
}

