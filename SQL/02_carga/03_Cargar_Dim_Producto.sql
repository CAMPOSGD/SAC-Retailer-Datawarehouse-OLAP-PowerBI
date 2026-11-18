-- Carga de productos únicos.
;WITH Productos AS (
    SELECT
        LTRIM(RTRIM([Product ID])) AS Product_ID,
        MAX(LTRIM(RTRIM([Product Name]))) AS Product_Name,
        MAX(LTRIM(RTRIM([Sub-Category]))) AS Sub_Category,
        MAX(LTRIM(RTRIM([Category]))) AS Category
    FROM dbo.Stg_Retailer
    WHERE [Product ID] IS NOT NULL
      AND LTRIM(RTRIM([Product ID])) <> ''
    GROUP BY LTRIM(RTRIM([Product ID]))
)
INSERT INTO dbo.Dim_Producto (
    Product_ID,
    Product_Name,
    Sub_Category,
    Category
)
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Sub_Category,
    p.Category
FROM Productos AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Dim_Producto AS d
    WHERE d.Product_ID = p.Product_ID
);

SELECT
    COUNT(*) AS Total_Productos,
    COUNT(DISTINCT Product_ID) AS Productos_Unicos
FROM dbo.Dim_Producto;

SELECT TOP 10
    Product_Key, Product_ID, Product_Name, Sub_Category, Category
FROM dbo.Dim_Producto
ORDER BY Product_Key;
