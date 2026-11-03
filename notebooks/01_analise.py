import pandas as pd
import matplotlib.pyplot as plt

# 1. Base de Dados Consolidada (2023-2025)
dados = {
    'Ano': [2023, 2024, 2025],
    'Atendimentos_Estrangeiros': [1143223, 870000, 775619],
    'Producao_Total_SUS': [2800000000, 2800000000, 2800000000] # ~2.8 bilhões/ano
}

df = pd.DataFrame(dados)

# 2. Cálculo da Variação Residual (%)
df['Percentual_Sobre_Total (%)'] = (df['Atendimentos_Estrangeiros'] / df['Producao_Total_SUS']) * 100

print("--- Tabela de Impacto Proporcional no SUS ---")
print(df[['Ano', 'Atendimentos_Estrangeiros', 'Percentual_Sobre_Total (%)']].to_string(index=False))

# 3. Simulação Orçamentária Municipal (Estudo de Caso: Juiz de Fora - LOA 2025)
orcamento_jf_2025 = 1282684148.00
margem_seguranca_estimada = orcamento_jf_2025 * 0.02 # Supondo 2% de margem operacional
custo_residual_estrangeiros = orcamento_jf_2025 * (df.loc[2, 'Percentual_Sobre_Total (%)'] / 100)

print(f"\nOrçamento Saúde JF (2025): R$ {orcamento_jf_2025:,.2f}")
print(f"Custo Residual Estimado (Proporção Nacional): R$ {custo_residual_estrangeiros:,.2f}")
print(f"Representatividade na Margem de Segurança (2%): {(custo_residual_estrangeiros/margem_seguranca_estimada)*100:.2f}%")
