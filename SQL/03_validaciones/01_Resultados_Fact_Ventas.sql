-- Script 13 del informe: resultados de carga de la tabla de hechos.
SELECT
    COUNT(*) AS Total_Transacciones,
    SUM(Sales) AS Total_Ventas,
    SUM(Profit) AS Total_Ganancias,
    SUM(Total_Cost) AS Total_Costos,
    SUM(CASE
        WHEN Ship_Date_ID IS NULL THEN 1
        ELSE 0
    END) AS Envios_Sin_Fecha_Valida
FROM dbo.Fact_Ventas;
