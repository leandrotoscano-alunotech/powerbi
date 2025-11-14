let
    Fonte = Csv.Document(
        Web.Contents("https://api.bcb.gov.br/dados/serie/bcdata.sgs.24363/dados?formato=csv"),
        [Delimiter = ",", Columns = 2, Encoding = 65001, QuoteStyle = QuoteStyle.None]
    ),
    PromotedHeaders = Table.PromoteHeaders(Fonte, [PromoteAllScalars = true]),
    ChangedType = Table.TransformColumnTypes(PromotedHeaders, {
        {"data", type date},
        {"valor", type number}
    })
in
    ChangedType
