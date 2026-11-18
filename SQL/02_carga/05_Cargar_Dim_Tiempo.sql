-- Carga de fechas únicas de pedido y de envío.
;WITH Fechas AS (
    SELECT DISTINCT
        CAST(f.Fecha AS DATE) AS Full_Date
    FROM dbo.Stg_Retailer AS s
    CROSS APPLY (
        VALUES
            (s.[Order Date]),
            (s.[Ship Date])
    ) AS f(Fecha)
    WHERE f.Fecha IS NOT NULL
)
INSERT INTO dbo.Dim_Tiempo (
    Date_ID,
    Full_Date,
    [Day],
    [Month],
    [Quarter],
    [Year]
)
SELECT
    YEAR(Full_Date) * 10000
        + MONTH(Full_Date) * 100
        + DAY(Full_Date),
    Full_Date,
    DAY(Full_Date),
    MONTH(Full_Date),
    DATEPART(QUARTER, Full_Date),
    YEAR(Full_Date)
FROM Fechas AS f
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Dim_Tiempo AS d
    WHERE d.Full_Date = f.Full_Date
);

SELECT
    COUNT(*) AS Total_Fechas,
    MIN(Full_Date) AS Primera_Fecha,
    MAX(Full_Date) AS Ultima_Fecha
FROM dbo.Dim_Tiempo;
