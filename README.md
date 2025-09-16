 Software Product: Analysis, Specification, Project & Implementation — ADS 5A

**Projeto (Dados/BI):** Indicadores do Brasil (BCB) — Power BI  
**Aluno:** Leandro Espada Toscano · **RA:** 2302581  
**Data:** 15/09/2025

## Links
- **Board:** https://github.com/users/leandrotoscano-alunotech/projects/2/views/1
- **Repositório:** https://github.com/leandrotoscano-alunotech/powerbi
- **PBIX (AC1):** `powerbi/Indicadores-BCB-AC1.pbix`
- **Vídeo da AC1:** _cole aqui o link do Loom/Drive_

---

## Visão geral (AC1)
Entrega de uma página **Overview** no Power BI usando **dados reais** do **Banco Central do Brasil (SGS)** — **Selic diária (série 11)**, consumidos em **CSV**.  
A AC1 demonstra a funcionalidade mínima do produto BI:
- Ingestão e **transformação** no **Power Query (M)**;
- **Modelagem** com **Tabela Calendário (DAX)** e relacionamento;
- **Medidas** para KPI e comparação mensal;
- Visual: **KPI** + **linha temporal por mês (AAAA‑MM)** + **segmentador de data**;
- **Transparência da fonte**: rodapé e URL oficial.

> **Unidade:** a série 11 retorna **% a.d. (ao dia)**. No relatório a métrica é apresentada como **média mensal**.

---

## Fontes de dados (CSV oficiais)
- **Selic diária — série 11** (2015 → atual):  
  `https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados?formato=csv&dataInicial=01/01/AAAA&dataFinal=31/12/AAAA`  
  _Obs.: o endpoint `/ultimos/N` tem limite pequeno; por isso a carga é feita **por ano** e depois combinada._

- **IPCA mensal — série 433** (para AC2):  
  `https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=csv&dataInicial=01/01/2015&dataFinal=31/12/2025`

---

## Como reproduzir (Power Query + DAX)

### 1) Power Query (M) — Selic (carregar por ano)
**Transformar Dados → Consulta em branco → Editor Avançado** e cole:

```m
let
    AnoInicial = 2015,
    AnoFinal   = Date.Year(Date.From(DateTime.LocalNow())),
    Formata = (d as date) as text => Date.ToText(d, "dd/MM/yyyy", "pt-BR"),

    GetCSV = (di as date, df as date) as table =>
        let
            Fonte = Web.Contents(
                "https://api.bcb.gov.br",
                [
                  RelativePath = "dados/serie/bcdata.sgs.11/dados",
                  Query = [formato = "csv", dataInicial = Formata(di), dataFinal = Formata(df)],
                  Headers = [Accept="text/csv", #"User-Agent"="PowerQuery"]
                ]
            ),
            Csv = Csv.Document(Fonte, [Delimiter=";", Columns=2, Encoding=65001, QuoteStyle=QuoteStyle.None]),
            Cab = Table.PromoteHeaders(Csv, [PromoteAllScalars=true]),
            Tipos = Table.TransformColumnTypes(Cab, {{"data", type date}, {"valor", type number}}, "pt-BR")
        in
            Tipos,

    ListaAnos = {AnoInicial..AnoFinal},
    TabelasPorAno =
        List.Transform(ListaAnos, (y) =>
            let di = #date(y,1,1),
                df = if y = AnoFinal then Date.From(DateTime.LocalNow()) else #date(y,12,31)
            in  GetCSV(di, df)
        ),
    Concatenada = Table.Combine(TabelasPorAno),
    Renomeada   = Table.RenameColumns(Concatenada, {{"valor","selic"}}),
    Ordenada    = Table.Sort(Renomeada, {{"data", Order.Ascending}})
in
    Ordenada
```

Credenciais: **Anônimo** · Nível de privacidade: **Público**.

### 2) DAX — Tabela Calendário e Medidas
Crie a tabela e as medidas abaixo.

```DAX
Calendario =
ADDCOLUMNS(
    CALENDAR(MIN(Selic[data]), MAX(Selic[data])),
    "Ano", YEAR([Date]),
    "Mes", MONTH([Date]),
    "AnoMes", FORMAT([Date], "YYYY-MM")
)

Selic Mensal Média :=
AVERAGEX(
    VALUES(Calendario[AnoMes]),
    CALCULATE(AVERAGE(Selic[selic]))
)

Selic M-1 :=
CALCULATE([Selic Mensal Média], DATEADD(Calendario[Date], -1, MONTH))

Selic MoM % :=
DIVIDE([Selic Mensal Média] - [Selic M-1], [Selic M-1])

-- Opcional: exibir com símbolo de %
Selic Mensal Média (%) := DIVIDE([Selic Mensal Média], 100)

Atualizado até := MAX(Selic[data])
```

**Relacionamento:** `Calendario[Date]` ↔ `Selic[data]`.  
**Formatos sugeridos:**  
- `Selic Mensal Média` → Número com 2 casas (ex.: 0,05);  
- `Selic Mensal Média (%)` → Percentual (2 casas);  
- `Selic MoM %` → Percentual (1–2 casas);  
- `Atualizado até` → Data curta.

---

## Página “Overview” (o que foi entregue)
- **KPI**: `Selic Mensal Média` (ou `%`).  
- **Linha**: `Selic Mensal Média` por `Calendario[AnoMes]` (ordenado por `Calendario[Date]`).  
- **Segmentador**: `Calendario[Date]`.  
- **Rodapé**: _“Fonte: Banco Central do Brasil — SGS (série 11, Selic diária, CSV)”_.  
- **Card**: `Atualizado até`.

---

## Como comprovar a fonte no vídeo
1. **Power Query → Etapa “Fonte”**: mostrar `Web.Contents` com `bcdata.sgs.11` e `formato=csv`.  
2. **Abrir o CSV no navegador** (por ano):  
   `https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados?formato=csv&dataInicial=01/01/2025&dataFinal=31/12/2025`.

---

## Estrutura do repositório
```
/powerbi
  Indicadores-BCB-AC1.pbix
  README-BI.md  (este arquivo)
/video
  AC1.mp4  (ou link no README)
```

---

## Próximas entregas
- **AC2:** adicionar **IPCA (série 433)**, relacionar ao Calendário e criar medidas `IPCA % Mês`, `IPCA MoM %`, `IPCA 12m %`. Página **Comparativo (Selic × IPCA)**.  
- **AC3:** incluir **IBC‑Br (24363)** + drillthrough por Ano.  
- **Final:** correlação Selic × IPCA, YoY e polimento visual.

---

## Requisitos atendidos — AC1
- [x] Fonte **real** e pública (BCB/SGS — CSV)  
- [x] **Transformação** no Power Query (tipagem/limpeza)  
- [x] **Modelagem** com Calendário e relacionamento  
- [x] **Medidas** (Média, MoM, Atualizado até)  
- [x] **Visual**: KPI + Linha + Segmentador + Rodapé  
- [x] Board, GitHub e vídeo
