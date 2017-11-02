# Pega os varios links da pagina


library(XML)

links <- c("https://www.astro.com/astro-databank/McCartney,_Paul",
		   "https://www.astro.com/astro-databank/Lennon,_John",
		   "https://www.astro.com/astro-databank/Starr,_Ringo",
		   "https://www.astro.com/astro-databank/Harrison,_George")


data <- data.frame()

total <- length(links)
counter <- 0
print('Processando :')
for (link in links){
	
	
	
	# Lê o site da web, linha por linha
	pagina = readLines(link)
	
	pagina = htmlParse(pagina)  # Fala com o R para entender as linhas como um doc HTML0
	page = xmlRoot(pagina)    # Tira as coisas que não estão dentro das TAGs HTML

	# Captura uma tag especifica da pagina
	txt = getNodeSet(page,"/html/body/div[@id='content']/*/div[@id='mw-content-text']/table[@class='infobox toccolours']/tr/td/table[@bgcolor='#f9f9f9']/tr/td")
	txt = xmlSApply(txt,xmlValue)
	nome = txt[1]
	genero = substr(txt[2],10,10)
	
	page <- data.frame(nome,genero)
	data <- rbind(data,page)
	
	counter <- counter + 1 
	print(paste(counter*100/total,'% Concluido'))
}
data
