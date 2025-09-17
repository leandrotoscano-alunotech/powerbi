# Indicadores do Brasil — Selic (Power BI)

Dashboard em Power BI que monitora a **Taxa Selic (SGS/BCB — série 11)** agregada em **média mensal**, com controle de período e comprovação da fonte oficial.

## KPIs
- **Selic Média Mês** — média da Selic **diária (% a.d.)** no mês selecionado.
- **Atualizado até** — última data de observação **dentro do intervalo filtrado**.

## O que o dashboard analisa
- **Nível e trajetória** da Selic ao longo do tempo (MM-AAAA).
- **Efeito do período** escolhido via **slicer de data** (YTD, últimos 12 meses, intervalo customizado).
- **Transparência**: rodapé com a fonte e cartão “Atualizado até”.

## Visuais
- **Card**: Selic Média Mês  
- **Linha mensal**: Selic Média Mês por mês (MM-AAAA)  
- **Segmentador de Data** (controla todos os visuais)  
- **Rodapé**: *Fonte: Banco Central do Brasil — SGS (série 11, Selic diária, CSV)*

## Dados e Fonte
- **Fonte oficial (CSV):** Banco Central do Brasil — **SGS**  
  - Selic diária (série **11**), exemplo por ano:  
    `https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados?formato=csv&dataInicial=01/01/2025&dataFinal=31/12/2025`
- **Observação:** o endpoint tem limite em `/ultimos/N`; a ingestão é **por ano** e depois **combinada**.

## Reprodutibilidade
- **Power Query (M):** `powerbi/M_Selic.m` (Web.Contents + carga anual + tipagem)
- **Modelagem/DAX:** `powerbi/DAX_Medidas.txt` (Calendario, Selic Mensal Média, MoM, Atualizado até)
- **PBIX:** `powerbi/Indicadores-BCB-AC1.pbix`

## Como usar
1. Abra o PBIX.  
2. Ajuste o **slicer de data**.  
3. Leia o **KPI** e a **linha** para entender nível e tendência.  
4. Confira o **“Atualizado até”** (última data dentro do recorte).
