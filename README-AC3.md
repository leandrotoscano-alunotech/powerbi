# AC3 — IBC-Br (Indicador de Atividade Econômica)

### 🎯 Objetivo
Apresentar o IBC-Br (série 24363) como indicador da atividade econômica brasileira, integrando-o ao modelo final do dashboard consolidado.

---

## 🧠 Etapas Realizadas

### **1) Coleta dos Dados**
- Fonte oficial: **Banco Central do Brasil — SGS**
- Série utilizada: **24363 (IBC-Br)**
- Importação via Power Query em CSV:
  ```
  https://api.bcb.gov.br/dados/serie/bcdata.sgs.24363/dados?formato=csv
  ```

### **2) Transformações no Power Query**
- Conversão de tipos (Data / Número Decimal)
- Padronização do nome das colunas:
  - `data`
  - `valor`
- Tratamento de nulos
- Aplicação de locale (pt-BR)
- Renomeada para: **IBCBr**

### **3) Relacionamento no Modelo**
- Relacionamento criado:
  ```
  Calendario[Data] 1:* IBCBr[data]
  ```

### **4) Medidas Criadas em DAX**
As medidas principais foram:

```DAX
IBCBr Média Mês :=
AVERAGEX (
    VALUES ( 'Calendario'[Mes_Ano] ),
    CALCULATE ( AVERAGE ( IBCBr[valor] ) )
)

IBCBr Var Mensal % :=
VAR Atual =
    CALCULATE ( SUM ( IBCBr[valor] ) )
VAR Anterior =
    CALCULATE (
        SUM ( IBCBr[valor] ),
        DATEADD ( 'Calendario'[Data], -1, MONTH )
    )
RETURN DIVIDE ( Atual - Anterior, Anterior )

IBCBr Var Anual % :=
VAR Atual =
    CALCULATE ( SUM ( IBCBr[valor] ) )
VAR AnoAnterior =
    CALCULATE (
        SUM ( IBCBr[valor] ),
        DATEADD ( 'Calendario'[Data], -1, YEAR )
    )
RETURN DIVIDE ( Atual - AnoAnterior, AnoAnterior )
```

---

## 📊 Indicadores Exibidos na Página
- **Card:** IBC-Br Média Mês  
- **Gráfico:** IBC-Br Mensal (Linha)

Esses elementos representam a AC3 de forma simples, clara e funcional.

---

## 📝 Observações
- O IBC-Br funciona como uma prévia do PIB.
- As variações mensal e anual permitem avaliar tendência econômica.
- A integração completa da AC3 com o calendário garante filtros consistentes em todo o painel.

---

## ✔ Status: AC3 Concluída
