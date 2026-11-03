-- ============================================================================
-- PROJETO: Impacto Orçamentário e Estatístico de Estrangeiros no SUS (2023-2025)
-- ARQUIVO: 03_extracao_agregacao_datasus.sql
-- OBJETIVO: Simular a extração e agregação de registros do SIA/SUS e SIH/SUS
--           cruzando com parâmetros da Lei Orçamentária Anual (LOA) para 
--           cálculo de Variação Residual e consumo da Margem de Segurança.
-- ============================================================================

-- 1. Criação das Tabelas de Apoio (Ambiente de Simulação / Data Warehouse SUS)
CREATE TABLE IF NOT EXISTS tb_producao_sus_consolidada (
    ano INT PRIMARY KEY,
    atendimentos_estrangeiros BIGINT NOT NULL,
    producao_total_sus BIGINT NOT NULL,
    status_consolidacao VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS tb_orcamento_municipal_loa (
    cod_ibge INT,
    municipio VARCHAR(100),
    uf CHAR(2),
    ano_exercicio INT,
    dotacao_total_saude DECIMAL(18, 2),
    populacao_usuaria_sus INT,
    est_estrangeiros_residentes_min INT,
    est_estrangeiros_residentes_max INT,
    taxa_margem_seguranca DECIMAL(5, 4),
    PRIMARY KEY (cod_ibge, ano_exercicio)
);

-- 2. Carga dos Dados Consolidados (2023 - 2025)
INSERT INTO tb_producao_sus_consolidada (ano, atendimentos_estrangeiros, producao_total_sus, status_consolidacao)
VALUES
    (2023, 1143223, 2800000000, 'Oficial (Pico)'),
    (2024, 870000,  2800000000, 'Estimado (Acomodacao)'),
    (2025, 775619,  2800000000, 'Oficial (Estabilizacao)');

INSERT INTO tb_orcamento_municipal_loa (
    cod_ibge, municipio, uf, ano_exercicio, dotacao_total_saude, 
    populacao_usuaria_sus, est_estrangeiros_residentes_min, est_estrangeiros_residentes_max, taxa_margem_seguranca
)
VALUES
    (3136702, 'Juiz de Fora', 'MG', 2025, 1282684148.00, 340000, 1000, 2000, 0.0200);

-- ============================================================================
-- 3. QUERY 1: Série Histórica Nacional, Representatividade (%) e Variação YoY
-- ============================================================================
WITH serie_historica AS (
    SELECT 
        ano,
        atendimentos_estrangeiros,
        producao_total_sus,
        status_consolidacao,
        ROUND((CAST(atendimentos_estrangeiros AS DECIMAL(18,4)) / producao_total_sus) * 100, 5) AS representatividade_pct,
        LAG(atendimentos_estrangeiros) OVER (ORDER BY ano) AS atendimentos_ano_anterior
    FROM tb_producao_sus_consolidada
)
SELECT 
    ano,
    atendimentos_estrangeiros,
    producao_total_sus,
    representatividade_pct AS variacao_residual_nacional_pct,
    ROUND(
        ((CAST(atendimentos_estrangeiros - atendimentos_ano_anterior AS DECIMAL(18,2)) / NULLIF(atendimentos_ano_anterior, 0)) * 100), 
        2
    ) AS variacao_anual_yoy_pct,
    status_consolidacao
FROM serie_historica
ORDER BY ano;

-- ============================================================================
-- 4. QUERY 2: Caso Real no Data Lake do DATASUS (Extração Bruta SIA/SIH)
--    Demonstra como filtrar estrangeiros pela tabela de procedimentos (PA / AIH)
-- ============================================================================
/*
SELECT 
    SUBSTRING(pa_cmp, 1, 4) AS ano_competencia,
    CASE 
        WHEN pa_nac <> '010' THEN 'Estrangeiro' -- 010 = Código IBGE/DATASUS para Brasileiro
        ELSE 'Brasileiro'
    END AS origem_paciente,
    CASE 
        WHEN pa_catend IN ('01', '03', '04', '05', '06') THEN 'Atencao Eletiva / Primaria / Especializada'
        WHEN pa_catend = '02' THEN 'Urgencia / Emergencia'
        ELSE 'Outros'
    END AS carater_atendimento,
    COUNT(*) AS qtd_procedimentos,
    SUM(pa_valapr) AS valor_aprovado_total
FROM datasus_sia.tb_producao_ambulatorial_pa
WHERE SUBSTRING(pa_cmp, 1, 4) IN ('2023', '2024', '2025')
GROUP BY 1, 2, 3
ORDER BY 1, 2;
*/

-- ============================================================================
-- 5. QUERY 3: Auditoria Contábil Municipal (Margem de Segurança vs. Residual)
-- ============================================================================
SELECT 
    m.municipio,
    m.uf,
    m.ano_exercicio,
    m.dotacao_total_saude AS orcamento_loa_reais,
    ROUND(m.dotacao_total_saude / m.populacao_usuaria_sus, 2) AS custo_medio_per_capita_sus,
    ROUND(m.dotacao_total_saude * m.taxa_margem_seguranca, 2) AS provisao_margem_seguranca_2pct,
    ROUND(m.dotacao_total_saude * 0.0001, 2) AS impacto_residual_nao_residentes_max,
    ROUND(
        ((m.dotacao_total_saude * 0.0001) / (m.dotacao_total_saude * m.taxa_margem_seguranca)) * 100, 
        2
    ) AS consumo_da_margem_seguranca_pct
FROM tb_orcamento_municipal_loa m
WHERE m.cod_ibge = 3136702 AND m.ano_exercicio = 2025;
