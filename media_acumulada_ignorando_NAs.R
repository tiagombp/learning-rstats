df <- data.frame(category=c("cat1","cat1","cat2","cat1","cat2","cat2","cat1","cat2"),
                 value=c(NA,2,3,4,5,NA,7,8))


media_cum <- df$value[1]

for (i in 2:length(df$value)) {
  soma_acum <- sum(df$value[1:i], na.rm = TRUE)
  qde_nao_nas <- length(which(!is.na(df$value[1:i])))
  media_cum_ponto <- soma_acum / qde_nao_nas
  
  media_cum <- c(media_cum, media_cum_ponto)
}


df$media_cum <- media_cum
df
