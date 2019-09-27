# vetores para os testes

a <- c("R is free software and comes with ABSOLUTELY NO WARRANTY.","You are welcome to redistribute it under certain conditions.","Type 'license()' or 'licence()' for distribution details.","","R is a collaborative project with many contributors.","Type 'contributors()' for more information and","on how to cite R or R packages in publications.","","Type 'demo()' for some demos, 'help()' for on-line help, or","'help.start()' for an HTML browser interface to help.","Type 'q()' to quit R.")
b <- c("", a) # caso com a primeira linha em branco
c <- c("", a, "") # caso com a última linha em branco

# função

arruma_vetor_baguncado <- function(vetor_baguncado) {
  
  k <- 1 # vai controlar a posição dos elementos do vetor de saída, "vetor_arrumado"
  texto_concatenado <- NULL # vai acumulando o texto das linhas não vazias
  vetor_arrumado <- NULL # vai ser o vetor de saída, com as linhas corrigidas
  
  for (i in 1:length(vetor_baguncado)) {
    if (vetor_baguncado[i] == "" & i == 1) { # (1)
      next
    } 
    
    else if (vetor_baguncado[i] == "" | i == length(vetor_baguncado)) { # (2)
      vetor_arrumado[k] <- texto_concatenado
      texto_concatenado <- NULL
      k <- k + 1
    } 
    
    else {
      texto_concatenado <- paste0(texto_concatenado, vetor_baguncado[i])
    }
  }
  
  return(vetor_arrumado)
}

# (1): se a linha em branco for a primeira, não faz nada, pula para a próxima linha

# (2): quando ele encontra uma linha em branco (ou quando chega ao fim do vetor baguncado), acrescenta o texto que foi sendo concatenado à próxima posição do vetor de saída, e reinicia a variavel que estava acumulando o texto.

# (3): se não é uma linha em branco, e nem o final do vetor de entrada (bagunçado), pega o texto da linha atual e acrescenta ao texto acumulado/concatenado.



# testes

a
b
c
arruma_vetor_baguncado(a)
arruma_vetor_baguncado(b)
arruma_vetor_baguncado(c)