df <- data.frame(a=sample(0:10, size=10, replace=TRUE),
                 b=sample(20:30, size=10, replace=TRUE))
df[df$a==0,'a'] <- NA
df$a <- as.factor(df$a)
df





# isso funciona
df %>% mutate_if(is.factor, as.character) %>% mutate_all(replace_na, 0)

# se for pra manter como factor
df2 <- df %>% mutate_if(is.factor, ~addNA(.)) 

levels(df2$a) <- c(levels(df2$a),"0")

df2 %>% mutate_all(replace_na, 0)

# como mudar os levels de vários fatores no df?

df3 <- df

levels(df3$a) <- c(levels(df3$a), 0, NA)

df3 %>% mutate_all(replace_na, 0)


addLevels <- function(var) {
  if(is.factor(var)) {
    levels(var) <- c(levels(var), 0, NA)
  }
}

