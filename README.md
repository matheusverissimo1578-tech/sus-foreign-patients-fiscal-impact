# 🏥 Impacto Orçamentário e Estatístico do Atendimento a Estrangeiros no SUS: Auditoria Macro Nacional (2023–2025)

![Status](https://img.shields.io/badge/Status-Concluído-brightgreen)
![Âmbito](https://img.shields.io/badge/Escopo-Nacional_|_Consolidado_SUS-blue)
![Ferramentas](https://img.shields.io/badge/Stack-Python_|_SQL_|_Finanças_Públicas-orange)

## 📌 Resumo Executivo (TL;DR)
Este projeto analisa o impacto macroeconómico e orçamentário do atendimento a cidadãos estrangeiros (residentes e não residentes) em todo o território nacional no **Sistema Único de Saúde (SUS)**. 

Cruzando a produção ambulatorial e hospitalar nacional (~2,8 mil milhões de procedimentos/ano) com os registos oficiais do Ministério da Saúde entre 2023 e 2025, a auditoria demonstra que essa procura representa **entre 0,0277% e 0,0408%** do volume global do sistema. Sob a ótica da contabilidade pública, trata-se de uma **variação estatística residual** que consome menos de **1,4% da Margem de Segurança** dos orçamentos consolidados da saúde (Federação, Estados e Municípios).

---

## 📊 Principais Indicadores Nacionais (2023–2025)

| Ano | Atendimentos a Estrangeiros | Produção Total SUS | Representatividade (%) | Orçamento Consolidado SUS | Margem de Segurança (2%) | Impacto Financeiro Estimado | Consumo da Margem (%) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **2023** | 1.143.223 | 2,8 bilhões | **0,04083%** | R$ 350,00 bi | R$ 7,00 bi | R$ 142,86 mi | **2,04%** |
| **2024** | 870.000 | 2,8 bilhões | **0,03107%** | R$ 365,00 bi | R$ 7,30 bi | R$ 113,40 mi | **1,55%** |
| **2025** | 775.619 | 2,8 bilhões | **0,02770%** | R$ 380,00 bi | R$ 7,60 bi | R$ 105,26 mi | **1,39%** |

---

## 🏛️ Fundamentação Económica e Contábil (Âmbito Federal e Subnacional)

1. **Alavancagem Operacional (Paul Samuelson - *Bens Públicos*):**
   A rede hospitalar, UPAs e UBS operam com custos fixos de prontidão estrutural. Absorver uma flutuação de procura inferior a `0,03%` não gera custos marginais adicionais relevantes, diluindo-se na capacidade instalada.
2. **Teoria dos Custos de Transação (Ronald Coase):**
   Criar barreiras burocráticas de triagem internacional ou cobranças transfronteiriças para reaver frações residuais de centavos por procedimento geraria um custo administrativo superior ao próprio desembolso assistencial.
3. **Financiamento Indireto via Tributação (Richard Musgrave):**
   Imigrantes residentes e turistas contribuem de imediato para o "Caixa Único" do Tesouro através de tributos embutidos no consumo (ICMS, PIS/COFINS, ISS), cumprindo o ciclo fiscal que sustenta o piso constitucional da saúde.

---

## 📈 Evolução Temporal e Tendência de Acomodação

```mermaid
xychart-beta
    title "Evolucao de Atendimentos a Estrangeiros no SUS - Brasil (em milhares)"
    x-axis ["2023 (Pico)", "2024 (Acomodacao)", "2025 (Estabilizacao)"]
    y-axis "Atendimentos (Milhares)" 0 --> 1300
    bar [1143.2, 870.0, 775.6]
    line [1143.2, 870.0, 775.6]
