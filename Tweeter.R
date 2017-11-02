# Aula 1 - Dados do Facebook

## Facebook
# Aplicativo de analise
# Tem que instalar o aplicativo na sua conta do facebook: https://apps.facebook.com/netvizz/
# Pega uma pagina aleatória  https://www.facebook.com/jairmessias.bolsonaro/
# e olha o ID dela no site: https://lookup-id.com
# Tbm tem a opção de usar o Rfacebook
# https://www.facebook.com/kunumilab/ 1069546463089588
# https://pt-br.facebook.com/strideragro/   184654105048045
# https://www.facebook.com/novoSpottedUFMG 



# Estou colocando o workspace na pasta que eu criei pra centralizar os arquivos que eu gerar
#setwd("C:/Users/mq003.LMCS/Desktop/Vittor")
# Lembrar que os dados estão em uma pasta separada
#list.files()

###
### Olhando os dados do facebook
###

# Data.frame melhorado e otimizado pra ler dado pra caramba
# Rez a lenda que roda rapidin, mais rapido que data frame
library(data.table)

# Esse banco de dados é o que contem estatisticas gerais da pagina(likes, reações e etc)
#stats <- fread("data_bostonaro/fullstats.tab", encoding="Latin-1")
# Pega os nomes das variaveis que o programa retornou pra nozeszzzz
#names(stats)



# Esse banco de dados é o que contem estatisticas gerais da pagina(likes, reações e etc)
comments <- fread("kunumi/page_1069546463089588_2017_09_27_21_38_45_comments.tab", encoding="Latin-1")
# Pega os nomes das variaveis que o programa retornou pra nozeszzzz
names(comments)


# Usa um pipe(???) para fazer algumas ações
library(magrittr)
library(tm)
library(wordcloud)

# Processamento do texto
texto <- comments$post_text
texto <- comments$comment_message
# Coloca tudo em minusculo, retica pontuação
conteudo <- texto %>% tolower %>% removePunctuation %>% removeWords( . ,
                  c(stopwords('pt'),"parabãns","vão","pra","vai","estã","atã","paãs","vocã","sã","ðÿ˜","ðÿ") )

#todas_palavras <- paste(conteudo, collapse = "")

pal2 = brewer.pal(8, "Dark2")
wordcloud(enc2native(conteudo), min.freq = 100, max.words = 200 , random.oder = F, colors = pal2)




# Análise por clusterização

corpus <- Corpus(VectorSource(enc2native(conteudo)))
tdm <- TermDocumentMatrix(corpus)
tdm <- removeSparseTerms(tdm, sparse = 0.98)
df <- as.data.frame(as.matrix(tdm))
dim(df)
df.scale <- scale(df)
d <- dist(df.scale, method = "euclidean")
fit.ward2 <- hclust(d, method = "ward.D2")
plot(fit.ward2)


