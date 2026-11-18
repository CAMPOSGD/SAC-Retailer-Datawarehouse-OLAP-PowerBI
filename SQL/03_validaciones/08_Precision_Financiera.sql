-- Comprobación técnica interna: 7 campos financieros.
SELECT
    v.Campo,
    COUNT(*) AS Total_Registros,
    SUM(CASE WHEN v.Valor IS NULL THEN 1 ELSE 0 END) AS Valores_Nulos,
    SUM(CASE
        WHEN v.Valor IS NOT NULL
         AND TRY_CONVERT(DECIMAL(18,2), v.Valor) IS NULL
        THEN 1 ELSE 0
    END) AS Conversiones_Invalidas,
    SUM(CASE
        WHEN v.Valor IS NOT NULL
         AND ABS(v.Valor - ROUND(v.Valor, 2)) > 0.000001
        THEN 1 ELSE 0
    END) AS Valores_Mas_Dos_Decimales
FROM dbo.Stg_Retailer AS s
CROSS APPLY (VALUES
    ('Sales', s.[Sales]),
    ('Profit', s.[Profit]),
    ('Shipping Costs', s.[Shipping Costs]),
    ('Storage Costs', s.[Storage Costs]),
    ('Personnel Cost', s.[Personnel Cost]),
    ('Selling Costs', s.[Selling Costs]),
    ('Purchasing Costs', s.[Purchasing Costs])
) AS v(Campo, Valor)
GROUP BY v.Campo
ORDER BY v.Campo;
