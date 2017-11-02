library(XML)

url = 'http://www.camara.leg.br/internet/deputado/RelVotacoes.asp?nuLegislatura=55&nuMatricula=487&dtInicio=01/01/2017&dtFim=30/12/2017'
pagina = readLines(url)
pagina = htmlParse(pagina)  # Fala com o R para entender as linhas como um doc HTML
pagina = xmlRoot(pagina)    # Tira as coisas que não estão dentro das TAGs HTML


# Captura uma tag especifica da pagina
txt = getNodeSet(pagina,"/html/head")
txt = xmlSApply(txt,xmlValue)