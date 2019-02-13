caminho <- "C:/Users/tiago.pereira/OneDrive - Secretaria do Tesouro Nacional/GT-CEAD/resources/fonts"
lista_arquivos <- list.files(caminho, pattern = "*.ttf", recursive = TRUE)

caminho_destino <- "C:/Users/tiago.pereira/OneDrive - Secretaria do Tesouro Nacional/GT-CEAD/resources/todas_as_fontes"
dir.create(caminho_destino)

file.copy(paste(caminho, lista_arquivos, sep = "/"), caminho_destino)
