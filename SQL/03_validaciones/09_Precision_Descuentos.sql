-- Comprobación técnica interna: descuentos y precisión DECIMAL(10,4).
SELECT
    COUNT(*) AS Total_Registros,
    SUM(CASE
        WHEN [Discount] IS NULL
        THEN 1 ELSE 0
    END) AS Descuentos_Nulos,
    SUM(CASE
        WHEN [Discount] IS NOT NULL
         AND TRY_CONVERT(DECIMAL(10,4), [Discount]) IS NULL
        THEN 1 ELSE 0
    END) AS Conversiones_Invalidas,
    SUM(CASE
        WHEN [Discount] IS NOT NULL
         AND ABS([Discount] - ROUND([Discount], 4)) > 0.0000001
        THEN 1 ELSE 0
    END) AS Valores_Mas_Cuatro_Decimales,
    MIN([Discount]) AS Descuento_Minimo,
    MAX([Discount]) AS Descuento_Maximo
FROM dbo.Stg_Retailer;
