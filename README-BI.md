# Power BI — Selic (BCB/SGS série 11)

**Data:** 17/09/2025

## Fonte (CSV)
- `https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados?formato=csv&dataInicial=01/01/AAAA&dataFinal=31/12/AAAA`

> O endpoint `/ultimos/N` possui limite; a extração é feita **por ano** e depois **combinada**.

## Power Query (M) e DAX
- Script M: `powerbi/M_Selic.m`
- Medidas DAX: `powerbi/DAX_Medidas.txt`

## Arquivos
- PBIX: `powerbi/Indicadores-BCB-AC1.pbix`
- Preview: `powerbi/img/overview.png`
