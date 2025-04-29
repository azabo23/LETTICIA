# Carregar bibliotecas necessárias
if (!require(WDI)) install.packages("WDI")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")

library(WDI)
library(ggplot2)
library(dplyr)
library(tidyr)

# Baixar dados do PIB nominal de 1980 até 2023 (ou o ano mais recente disponível)
dados_pib <- WDI(country = 'all', indicator = 'NY.GDP.MKTP.CD', start = 1980, end = 2023)

# Limpar dados e classificar grupo
dados_limpos <- dados_pib %>%
  filter(!is.na(NY.GDP.MKTP.CD)) %>%
  mutate(grupo = ifelse(country == "Brazil", "Brasil", "Outros Países"))

# Para dados em painel, vamos apenas mostrar o Brasil e outros países ao longo do tempo
# Não vamos filtrar por ano, pois queremos todos os anos disponíveis
# Ordenação dos dados
dados_limpos <- dados_limpos %>%
  mutate(country = factor(country, levels = unique(country)))  # Organizar os países na ordem que aparecem

# Gráfico de colunas em painel, destacando o Brasil
grafico_painel <- ggplot(dados_limpos, aes(x = year, y = NY.GDP.MKTP.CD, fill = grupo)) +
  geom_bar(stat = "identity", position = "identity", width = 0.8, 
           aes(alpha = ifelse(grupo == "Brasil", 1, 0.4))) +  # Remover bordas
  scale_fill_manual(
    values = c("Brasil" = "#006400", "Outros Países" = "#FFD700"),  # Verde escuro para o Brasil
    name = "Grupo"
  ) +
  labs(
    title = "PIB Nominal (1980-2023): Brasil vs Outros Países",
    x = "Ano",
    y = "PIB (em US$ correntes)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5, family = "sans"),
    axis.title = element_text(size = 12, family = "sans"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),  # Rotacionar nomes dos anos
    axis.text.y = element_text(size = 10),
    legend.position = "top"
  ) +
  scale_y_continuous(labels = scales::label_number(big.mark = ".", decimal.mark = ","))  # Formatar números no eixo Y

# Exibir o gráfico
print(grafico_painel)
