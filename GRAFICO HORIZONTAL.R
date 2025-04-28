# Carregar bibliotecas necessárias
if (!require(WDI)) install.packages("WDI")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")
if (!require(scales)) install.packages("scales")

library(WDI)
library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)

# Baixar dados do PIB nominal para o ano de 2023
dados_2023 <- WDI(country = 'all', indicator = 'NY.GDP.MKTP.CD', start = 2023, end = 2023)

# Limpar dados e classificar grupo
dados_2023_limpo <- dados_2023 %>%
  filter(!is.na(NY.GDP.MKTP.CD)) %>%
  mutate(grupo = ifelse(country == "Brazil", "Brasil", "Outros Países"))

# Selecionar os 20 países com maior PIB
dados_top20 <- dados_2023_limpo %>%
  arrange(desc(NY.GDP.MKTP.CD)) %>%
  slice(1:20)

# Se o Brasil não estiver no top 20, adiciona ele
if (!"Brazil" %in% dados_top20$country) {
  dados_brasil <- dados_2023_limpo %>% filter(country == "Brazil")
  dados_top20 <- bind_rows(dados_top20, dados_brasil)
}

# Organizar para o gráfico
dados_top20 <- dados_top20 %>%
  arrange(NY.GDP.MKTP.CD) %>%
  mutate(pais = factor(country, levels = country))  # Ordem no gráfico

# Gráfico de colunas horizontal
grafico_top20 <- ggplot(dados_top20, aes(x = NY.GDP.MKTP.CD, y = pais, fill = grupo)) +
  geom_col() +
  scale_fill_manual(
    values = c("Brasil" = "red", "Outros Países" = "#FFD700"),
    name = "Grupo"
  ) +
  labs(
    title = "Maiores PIBs Nominais em 2023 (Incluindo Brasil)",
    x = "PIB (em dólares americanos correntes)",
    y = "País"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5, family = "sans"),
    axis.title = element_text(size = 12, family = "sans"),
    axis.text = element_text(size = 10, family = "sans"),
    legend.position = "top"
  ) +
  scale_x_continuous(labels = label_number(big.mark = ".", decimal.mark = ","))

# Exibir o gráfico
print(grafico_top20)
