% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fbind.R
\name{fbind}
\alias{fbind}
\title{fbind}
\usage{
fbind(x, y)
}
\arguments{
\item{x}{a vector (will be coerced to character)}

\item{y}{a vector (will be coerced to character)}
}
\value{
a vector that combines both inputs
}
\description{
binds two factor vectors
}
\examples{
x <- c("a", "b")
y <- c("d", "e")
fbind(x,y)
}
