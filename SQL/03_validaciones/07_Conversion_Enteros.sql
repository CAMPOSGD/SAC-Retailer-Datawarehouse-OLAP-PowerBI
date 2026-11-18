-- Script 11 del informe: compatibilidad con INT.
SELECT
    COUNT(*) AS Total_Registros,
    SUM(CASE
        WHEN [Primary ID] IS NULL
          OR TRY_CONVERT(INT, [Primary ID]) IS NULL
          OR [Primary ID] <> FLOOR([Primary ID])
        THEN 1 ELSE 0
    END) AS Primary_ID_Invalidos,
    SUM(CASE
        WHEN [Order ID] IS NOT NULL
         AND (
             TRY_CONVERT(INT, [Order ID]) IS NULL
             OR [Order ID] <> FLOOR([Order ID])
         )
        THEN 1 ELSE 0
    END) AS Order_ID_Invalidos,
    SUM(CASE
        WHEN [Quantity] IS NULL
          OR TRY_CONVERT(INT, [Quantity]) IS NULL
          OR [Quantity] <> FLOOR([Quantity])
        THEN 1 ELSE 0
    END) AS Quantity_Invalidos
FROM dbo.Stg_Retailer;
