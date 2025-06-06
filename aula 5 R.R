# API (PORTA/FORMA DE ACESSO REMOTO)
# ACESSAMOS OS DADOS DO BANCO MUNDIAL (WORLD BANK)
# WORLD DEVELOPMENT INDICATORS (WDI)
# INDICADORES DE DESENVOLVIMENTO MUNDIAL

#PIB (PRODUTO INTERNO BRUTO)
#WDI - WORLD DEVELOPMENT INDICATORS 
# OS DADOS DO BANCO MUNDIAL SÃO ACESSADOS

install.packages("WDI")
library(WDI) # SEMPRE CHAMA O PACOTE 

# PROCURAM AS VIGNETTES
# PÁGINAS COM INSTRUÇÕES DOS PACOTES

# GDP (current US$)(NY.GDP.MKTP.CD)
# PIB PREÇOS CORRENTES EM DÓLAR NORTE-AMERICANO
# CÓDIGO:NY.GDP.MKTP.CD

# VAMOS PESQUISAR O TERMO 'GDP' NO WDI 

varpib <-WDIsearch('GDP') # CRIAR OBJETO COM O RES

# BUSCAR OS DADOS COM CÓDIGO DO SITE
options(scipen = 999) # AJUSTA A NOT. CIENT. 
dadospib <- WDI(country = 'all',
                indicator ='NY.GDP.MKTP.CD')
paises <- ('BR', 'US')
dadospibbbrus <-  WDI(country = paises,
                     indicator ='NY.GDP.MKTP.CD',
                     start = 2023, end = 2023)
                     
#corte transversal                                   
dadospib2023 <-  WDI(country = 'all',
                      indicator ='NY.GDP.MKTP.CD',
                      start = 2023, end = 2023)

#serie temporal
dadospibbr <- WDI(country = 'br',
                   indicator ='NY.GDP.MKTP.CD'
                  start = 2023, end = 2023)
                  
