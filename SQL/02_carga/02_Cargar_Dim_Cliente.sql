-- Carga de clientes únicos.
;WITH Clientes AS (
    SELECT
        LTRIM(RTRIM([Customer ID])) AS Customer_ID,
        MAX(LTRIM(RTRIM([Customer Name]))) AS Customer_Name,
        MAX(LTRIM(RTRIM([Segment]))) AS Segment
    FROM dbo.Stg_Retailer
    WHERE [Customer ID] IS NOT NULL
      AND LTRIM(RTRIM([Customer ID])) <> ''
    GROUP BY LTRIM(RTRIM([Customer ID]))
)
INSERT INTO dbo.Dim_Cliente (
    Customer_ID,
    Customer_Name,
    Segment
)
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Segment
FROM Clientes AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Dim_Cliente AS d
    WHERE d.Customer_ID = c.Customer_ID
);

SELECT
    COUNT(*) AS Total_Clientes,
    COUNT(DISTINCT Customer_ID) AS Clientes_Unicos
FROM dbo.Dim_Cliente;

SELECT TOP 10
    Customer_Key, Customer_ID, Customer_Name, Segment
FROM dbo.Dim_Cliente
ORDER BY Customer_Key;
