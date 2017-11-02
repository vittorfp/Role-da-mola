#install.packages("XML",dependencies = TRUE)
# Raspar paginas da web

library(XML)


install.packages(c('XML','magrittr'))


# Lê o site da web, linha por linha
pagina = readLines("https://www.astro.com/astro-databank/Lennon,_John")

pagina = htmlParse(pagina)  # Fala com o R para entender as linhas como um doc HTML0
page = xmlRoot(pagina)    # Tira as coisas que não estão dentro das TAGs HTML

# Captura o titulo da pagina
titulo = getNodeSet(pagina,"/html/body/div[@id='content']/*/div[@id='mw-content-text']/table[@class='infobox toccolours']/tr//img")
titulo = xmlSApply(titulo,xmlGetAttr,name='alt')
sol <- titulo[2]
sol <- substr(sol,3,5)
lua <- titulo[4]
lua <- substr(lua,3,5)
asc <- titulo[5]
asc <- substr(asc,3,5)
titulo = xmlSApply(titulo,xmlValue)
titulo

# Captura uma tag especifica da pagina

txt = getNodeSet(page,"/html/body/div[@id='content']/*/div[@id='mw-content-text']/table[@class='infobox toccolours']/tr/td/table[@bgcolor='#f9f9f9']/tr/td")


# Lê o site da web, linha por linha
pagina = readLines("https://www.astro.com/astro-databank/Adams,_Douglas")

pagina = htmlParse(pagina)  # Fala com o R para entender as linhas como um doc HTML0
page = xmlRoot(pagina)    # Tira as coisas que não estão dentro das TAGs HTML
page

txt <- getNodeSet(page,"/html/body/div[@id='content']/div[@id='bodyContent']/div[@id='mw-content-text']/p| 
				  /html/body/div[@id='content']/div[@id='bodyContent']/div[@id='mw-content-text']/h2")
txt <- xmlSApply(txt,xmlValue)
txt <- paste(txt, collapse = " ")
txt


txt <- getNodeSet(page,"/html/body/div[@id='content']/div[@id='bodyContent']/div[@id='mw-content-text']/p  | 
				  		/html/body/div[@id='content']/div[@id='bodyContent']/div[@id='mw-content-text']/h2| 
				  		/html/body/div[@id='content']/div[@id='bodyContent']/div[@id='mw-content-text']//li")

txt <- xmlSApply(txt,xmlValue)

content <- list("","","","","")
for (t in txt){
	
	switch(t,
		   "Categories"    = { index = 1;  f <- 1},
		   "Source Notes"  = { index = 2;  f <- 1 },
		   "Biography"     = { index = 3;  f <- 1 },
		   "Relationships" = { index = 4;  f <- 1 },
		   "Events"        = { index = 5;  f <- 1 },
		   					 { f <- 0 }
		   )
	
	if(index != 0 && f == 0){
		print(index)
		content[index] <- paste0(content[index],t)
	}
}

categories    <- content[1]
sources       <- content[2]
bio           <- content[3]
relationships <- content[4]
events        <- content[5]


txt




sapply(as.character(txt),substr,2,2)

for(node in txt){
	
}

txt = xmlSApply(txt,xmlValue)
nome = txt[1]
genero = txt[2]
nome
genero

genero = getNodeSet(page,"/html/body/div[@id='content']/*/div[@id='mw-content-text']/table[@class='infobox toccolours']/tr/td/table[@bgcolor='#f9f9f9']/tr/td")
genero = xmlSApply(genero,xmlValue)

genero

# Exibe qual é o User Agent
pagina <- readLines("http://www.whoishostingthis.com/tools/user-agent/")
pagina = htmlParse(pagina)  # Fala com o R para entender as linhas como um doc HTML0
page = xmlRoot(pagina)    # Tira as coisas que não estão dentro das TAGs HTML
titulo = getNodeSet(pagina,"//div[@class='info-box user-agent']")
titulo = xmlSApply(titulo,xmlValue)
titulo

