library(XML)

url = 'http://www.camara.leg.br/internet/deputado/RelVotacoes.asp?nuLegislatura=55&nuMatricula=487&dtInicio=01/01/2017&dtFim=30/12/2017'
pagina = readLines(url)
pagina = htmlParse(pagina)  # Fala com o R para entender as linhas como um doc HTML
pagina = xmlRoot(pagina)    # Tira as coisas que não estão dentro das TAGs HTML


# Captura uma tag especifica da pagina
# /html/body/div[2]/div/div/div/div/div[2]/table/tbody/tr[1]/td[1]
# class="tabela-padrao-bootstrap table-bordered"


txt = getNodeSet(pagina,'/html/body/div[2]/div/div/div/div/div[1]/h3/a')
txt = xmlSApply(txt,xmlValue)

l <- unlist(strsplit(txt,'/') )
m <- unlist(strsplit(l[1],'-') )

nome <- trimws(m[1])
partido <- trimws(m[2])
estado <- l[2]

classeLinha = getNodeSet(pagina,'body/div[2]/div/div/div/div/div[1]/table/tr')
classeLinha = xmlSApply(classeLinha, xmlGetAttr, name = 'class')
classeLinha

bd <- data.frame()
colnames(bd) <- c('dia','presença')

for ( l in 1:length(classeLinha) ){
	
	if( classeLinha[l] == 'even'){
		
		txt = getNodeSet(pagina,paste0('body/div[2]/div/div/div/div/div[1]/table/tr[',toString(l),']/td[1]',sep = "") )
		txt = xmlSApply(txt,xmlValue)
		dia <- trimws(txt)
		print(dia)
			
		txt = getNodeSet(pagina,paste0('body/div[2]/div/div/div/div/div[1]/table/tr[',toString(l),']/td[3]',sep = "") )
		txt = xmlSApply(txt,xmlValue)
		presenca <- trimws(txt)
		presenca <- trimws(presenca)
		print(presenca)
		
	}
	
}
