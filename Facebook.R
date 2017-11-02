# Aula 2 - Dados do Tweeter

## Tweeter
# No tweeter tem que criar um app no site: https://apps.twitter.com/app/new
# Cadastrar o celular e pegar as chaves
# Consumer Key (API Key)	cLZh3beJO3PWY3EKn2wB7wF1g
# Consumer Secret (API Secret)	WpeonMUnR400hDeOFV0OoUoFsE3tkFgOER9lPD8xXQy5PwvHGl
# Access Level	Read and write (modify app permissions)
# Owner	Vittorfp
# Owner ID	85087120
# Access Token	85087120-LcD1SxmoACbttnro07V0Rb8sBB1t3azrb5WZBl88g
# Access Token Secret	zttG39HOncLAg2Ba1AnGn0oKgqu1x6G2bw9CRSP4GBgwv


#install.packages(c("twitteR","wordcloud","tm","plyr","magrittr","igraph"), dependencies=T)

library(twitteR)
library(wordcloud)
library(tm)
library(plyr)
library(magrittr)

# Coloca as chaves
consumer_key <- "cLZh3beJO3PWY3EKn2wB7wF1g"
consumer_secret <- "WpeonMUnR400hDeOFV0OoUoFsE3tkFgOER9lPD8xXQy5PwvHGl"
access_token <- "85087120-LcD1SxmoACbttnro07V0Rb8sBB1t3azrb5WZBl88g"
access_secret <- "zttG39HOncLAg2Ba1AnGn0oKgqu1x6G2bw9CRSP4GBgwv"

# Estabelece a conexão
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

# Faz a busca e coloca num objeto bd
tweets <- searchTwitter("teatro amador", n=2000, lang = 'pt')
bd <- ldply(tweets, function(t) t$toDataFrame() )
View(bd)


# Extrai o texto dos tweets
text <- sapply(tweets, function(x) x$getText())

# Tira links
text <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", text)
text <- gsub("https", "", text)
text <- gsub("http", "", text)
grep("http", text)


# Prepara o Corpus para análise
head(text)
texto <- iconv(text, 'UTF-8', 'ASCII') 
texto <- iconv(text, from="UTF-8", to="latin1")
inshead(texto)
conteudo = texto %>% tolower %>% removePunctuation %>% removeWords(., stopwords('en')) %>% 
	removeWords(., stopwords('es')) %>%	removeWords(., stopwords('pt')) %>%	removeWords(., c('gênero','género','gabrlelplnhelro','youtube','ver','glezsba','sei','nao','tipo','bem','ter','rcp01','hsstdh'))



# Monta wordclouds
wordcloud(enc2native(conteudo), min.freq = 2, max.words = 100, random.order = F)

pal2 <- brewer.pal(8,"Dark2")
wordcloud(enc2native(conteudo), min.freq=1,max.words=100, random.order=F, colors=pal2)
#title(xlab = "Twitter, 26/09/2017, 15:00")



# Análise de clusterização
corpus <- Corpus(VectorSource(enc2native(conteudo)))
tdm <- TermDocumentMatrix(corpus)
tdm <- removeSparseTerms(tdm, sparse = 0.98)
df <- as.data.frame(as.matrix(tdm))
dim(df)
df.scale <- scale(df)
d <- dist(df.scale, method = "euclidean")
fit <- hclust(d)
plot(fit)

#Usando outro algoritmo
fit.ward2 <- hclust(d, method = "ward.D2")
plot(fit.ward2)
rect.hclust(fit.ward2, h=15)

# Se quisermos trabalhar com análise de redes sociais
library(igraph)
matriz <- as.matrix(df)
g <- graph_from_incidence_matrix(matriz)
is.bipartite(g)
g

#plot(g, vertex.size=4, vertex.label=V(g)$name, vertex.color=as.numeric(V(g)$type))
g2 <- bipartite_projection(g, which = "FALSE")
#plot(g2, edge.width=log(E(g2)$weight), vertex.shape="none")


grau = degree(g2)
plot(g2,
     edge.width = log(E(g2)$weight),
     vertex.shape = "none",
     vertex.label.cex = scale(grau) +1,
     vertex.label.color = adjustcolor("red", .7)
     )

plot(g2,     vertex.shape = "none")
