-- ============================================================================
-- PROJETO: Impacto Orçamentário e Estatístico de Estrangeiros no SUS (2023-2025)
-- ÂMBITO: Macro-auditoria Tripartite (Federal, Estadual, Municipal / SIOPS)
-- ARQUIVO: 03_extracao_agregacao_datasus_tripartite.sql
-- ============================================================================

CREATE TABLE IF NOT EXISTS tb_orcamento_tripartite_sus (
    ano INT PRIMARY KEY,
    orcamento_federal_ms DECIMAL(18, 2) NOT NULL,
    orcamento_estadual_ses DECIMAL(18, 2) NOT NULL,
    orcamento_municipal_sms DECIMAL(18, 2) NOT NULL,
    atendimentos_estrangeiros BIGINT NOT NULL,
    producao_total_sus BIGINT NOT NULL
);

INSERT INTO tb_orcamento_tripartite_sus (
    ano, orcamento_federal_ms, orcamento_estadual_ses, orcamento_municipal_sms, 
    atendimentos_estrangeiros, producao_total_sus
)
VALUES
    (2023, 155000000000.00, 95000000000.00, 100000000000.00, 1143223, 2800000000),
    (2024, 162000000000.00, 100000000000.00, 103000000000.00, 870000, 2800000000),
    (2025, 170000000000.00, 105000000000.00, 105000000000.00, 775619, 2800000000);

-- Query de Auditoria Consolidada e Consumo da Margem de Segurança
SELECT 
    ano,
    (orcamento_federal_ms + orcamento_estadual_ses + orcamento_municipal_sms) AS orcamento_total_sus,
    ROUND((orcamento_federal_ms + orcamento_estadual_ses + orcamento_municipal_sms) * 0.02, 2) AS margem_seguranca_2pct,
    ROUND((orcamento_federal_ms + orcamento_estadual_ses + orcamento_municipal_sms) * (CAST(atendimentos_estrangeiros AS DECIMAL(18,6)) / producao_total_sus), 2) AS gasto_estrangeiros_reais,
    ROUND(
        (
            ((orcamento_federal_ms + orcamento_estadual_ses + orcamento_municipal_sms) * (CAST(atendimentos_estrangeiros AS DECIMAL(18,6)) / producao_total_sus))
            /
            ((orcamento_federal_ms + orcamento_estadual_ses + orcamento_municipal_sms) * 0.02)
        ) * 100, 
        2
    ) AS consumo_margem_seguranca_pct
FROM tb_orcamento_tripartite_sus
ORDER BY ano;
