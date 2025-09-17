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
        List.Transform(
            ListaAnos,
            (y) =>
                let di = #date(y,1,1),
                    df = if y = AnoFinal then Date.From(DateTime.LocalNow()) else #date(y,12,31)
                in  GetCSV(di, df)
        ),
    Concatenada = Table.Combine(TabelasPorAno),
    Renomeada   = Table.RenameColumns(Concatenada, {{"valor","selic"}}),
    Ordenada    = Table.Sort(Renomeada, {{"data", Order.Ascending}})
in
    Ordenada
