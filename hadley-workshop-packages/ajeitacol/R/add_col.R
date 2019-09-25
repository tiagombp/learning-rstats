add_col <- function(x, name, value, where) {
  y <- data.frame(y = value)
  insert_into(x, setNames(y, name), where)
}
