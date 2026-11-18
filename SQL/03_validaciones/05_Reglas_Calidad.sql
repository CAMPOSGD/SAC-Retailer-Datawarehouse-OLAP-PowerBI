-- Script 9 del informe: fechas, cantidades, ventas y descuentos.
SELECT
    SUM(CASE
        WHEN TRY_CONVERT(DATE, [Order Date]) IS NULL
        THEN 1 ELSE 0 END) AS Fechas_Pedido_Invalidas,
    SUM(CASE
        WHEN [Ship Date] IS NOT NULL
         AND TRY_CONVERT(DATE, [Ship Date]) IS NULL
        THEN 1 ELSE 0 END) AS Fechas_Envio_Invalidas,
    SUM(CASE
        WHEN TRY_CONVERT(DATE, [Ship Date])
           < TRY_CONVERT(DATE, [Order Date])
        THEN 1 ELSE 0 END) AS Envios_Anteriores_Pedido,
    SUM(CASE
        WHEN TRY_CONVERT(DECIMAL(18,4), [Quantity]) <= 0
        THEN 1 ELSE 0 END) AS Cantidades_No_Positivas,
    SUM(CASE
        WHEN TRY_CONVERT(DECIMAL(18,4), [Sales]) < 0
        THEN 1 ELSE 0 END) AS Ventas_Negativas,
    SUM(CASE
        WHEN TRY_CONVERT(DECIMAL(18,4), [Discount]) < 0
          OR TRY_CONVERT(DECIMAL(18,4), [Discount]) > 1
        THEN 1 ELSE 0 END) AS Descuentos_Fuera_Rango
FROM dbo.Stg_Retailer;
