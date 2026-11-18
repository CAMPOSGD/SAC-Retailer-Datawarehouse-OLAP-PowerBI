-- Script 7 del informe: revisión de campos críticos.
SELECT
    COUNT(*) AS Total_Registros,
    SUM(CASE WHEN [Primary ID] IS NULL THEN 1 ELSE 0 END) AS Nulos_Primary_ID,
    SUM(CASE WHEN [Customer ID] IS NULL THEN 1 ELSE 0 END) AS Nulos_Clientes,
    SUM(CASE WHEN [Product ID] IS NULL THEN 1 ELSE 0 END) AS Nulos_Productos,
    SUM(CASE WHEN [Order Date] IS NULL THEN 1 ELSE 0 END) AS Nulos_Fecha_Pedido,
    SUM(CASE WHEN [Ship Date] IS NULL THEN 1 ELSE 0 END) AS Nulos_Fecha_Envio,
    SUM(CASE WHEN [Sales] IS NULL THEN 1 ELSE 0 END) AS Nulos_Ventas,
    SUM(CASE WHEN [Profit] IS NULL THEN 1 ELSE 0 END) AS Nulos_Ganancias
FROM dbo.Stg_Retailer;
