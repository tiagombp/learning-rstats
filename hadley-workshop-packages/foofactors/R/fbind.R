#' fbind
#'
#' binds two factor vectors
#'
#' @param x a vector (will be coerced to character)
#' @param y a vector (will be coerced to character)
#'
#' @return a vector that combines both inputs
#' @export
#'
#' @examples
#' x <- c("a", "b")
#' y <- c("d", "e")
#' fbind(x,y)
fbind <- function(x, y) {
  return(factor(c(as.character(x), as.character(y))))
}

