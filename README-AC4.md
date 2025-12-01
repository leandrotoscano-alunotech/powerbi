# LEIA-ME: Indicadores do Brasil (BCB) — IPCA (Power BI)

Dashboard em Power BI que analisa o comportamento mensal do IPCA (inflação) e outros indicadores macroeconômicos do Brasil, utilizando dados oficiais do Banco Central do Brasil (BCB).

---

## Estrutura do Projeto

O projeto é dividido nas seguintes etapas de desenvolvimento (ACs) e o resultado final.

### AC1: Selic e Power Query
Configuração inicial do Power BI, conexão de dados (Selic via CSV) e criação de uma Tabela Calendário.

### AC2: IPCA e Comparativo
Integração dos dados de IPCA (série 433), criação de medidas básicas e visuais de linha para a comparação mensal.

### AC3: IBC-Br e Detalhamento (Drill-through)
Integração do IBC-Br (Índice de Atividade Econômica), criando a funcionalidade de drill-through para análise detalhada do índice.

---

## Análises Finais e Funcionalidade FINAL

Esta seção finaliza o projeto com a integração da Correlação e a análise Year-over-Year (YoY), completando o escopo do projeto.

### 📊 Correlação Selic x IPCA

Implementação de um **Gráfico de Dispersão** para visualizar a relação estatística entre a **Taxa Selic Mensal** e o **IPCA Mensal (Inflação)**. 
- **Objetivo:** Analisar como os movimentos da taxa de juros básica (Selic) se comportam em relação às variações da inflação oficial do país, ajudando a entender o 'lag' temporal na resposta do Banco Central à inflação.

### 📈 Análise Year-over-Year (YoY)

Criação da medida **IPCA_Variacao_YoY** (Year-over-Year) para calcular a variação percentual do IPCA do mês atual em comparação com o mesmo mês do ano anterior.
- **Objetivo:** Fornecer uma visão de longo prazo sobre a tendência inflacionária, removendo a sazonalidade e indicando o crescimento ou declínio real do índice no período de 12 meses.