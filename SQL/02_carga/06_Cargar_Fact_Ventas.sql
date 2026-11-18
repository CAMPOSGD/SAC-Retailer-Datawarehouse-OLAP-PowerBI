-- Script 12 del informe. Carga de la tabla de hechos Fact_Ventas.
-- Las 268 fechas de envío anteriores a pedido se tratan PROVISIONALMENTE
-- con Ship_Date_ID = NULL, sin descartar ventas ni editar Stg_Retailer.
INSERT INTO dbo.Fact_Ventas (
    Primary_ID,
    Order_ID,
    Customer_Key,
    Product_Key,
    Geography_Key,
    Order_Date_ID,
    Ship_Date_ID,
    Ship_Mode_Key,
    Quantity,
    Sales,
    Profit,
    Discount,
    Shipping_Costs,
    Storage_Costs,
    Personnel_Cost,
    Selling_Costs,
    Purchasing_Costs,
    Total_Cost
)
SELECT
    CONVERT(INT, s.[Primary ID]),
    CONVERT(INT, s.[Order ID]),
    c.Customer_Key,
    p.Product_Key,
    g.Geography_Key,
    t.Date_ID,
    CASE
        WHEN s.[Ship Date] < s.[Order Date] THEN NULL
        ELSE te.Date_ID
    END,
    e.Ship_Mode_Key,
    CONVERT(INT, s.[Quantity]),
    CONVERT(DECIMAL(18,2), s.[Sales]),
    CONVERT(DECIMAL(18,2), s.[Profit]),
    CONVERT(DECIMAL(10,4), s.[Discount]),
    CONVERT(DECIMAL(18,2), s.[Shipping Costs]),
    CONVERT(DECIMAL(18,2), s.[Storage Costs]),
    CONVERT(DECIMAL(18,2), s.[Personnel Cost]),
    CONVERT(DECIMAL(18,2), s.[Selling Costs]),
    CONVERT(DECIMAL(18,2), s.[Purchasing Costs]),
    CONVERT(DECIMAL(18,2), s.[Shipping Costs])
    + CONVERT(DECIMAL(18,2), s.[Storage Costs])
    + CONVERT(DECIMAL(18,2), s.[Personnel Cost])
    + CONVERT(DECIMAL(18,2), s.[Selling Costs])
    + CONVERT(DECIMAL(18,2), s.[Purchasing Costs])
FROM dbo.Stg_Retailer AS s
LEFT JOIN dbo.Dim_Cliente AS c
    ON c.Customer_ID = TRIM(s.[Customer ID])
LEFT JOIN dbo.Dim_Producto AS p
    ON p.Product_ID = TRIM(s.[Product ID])
LEFT JOIN dbo.Dim_Geografia AS g
    ON (
        g.City = TRIM(s.[City])
        OR (g.City IS NULL AND s.[City] IS NULL)
    )
    AND (
        g.State = TRIM(s.[State])
        OR (g.State IS NULL AND s.[State] IS NULL)
    )
    AND (
        g.Region = TRIM(s.[Region])
        OR (g.Region IS NULL AND s.[Region] IS NULL)
    )
    AND (
        g.Country = TRIM(s.[Country])
        OR (g.Country IS NULL AND s.[Country] IS NULL)
    )
    AND (
        g.Market = TRIM(s.[Market])
        OR (g.Market IS NULL AND s.[Market] IS NULL)
    )
    AND (
        g.Latitude = CONVERT(DECIMAL(10,7), s.[Latitude])
        OR (g.Latitude IS NULL AND s.[Latitude] IS NULL)
    )
    AND (
        g.Longitude = CONVERT(DECIMAL(10,7), s.[Longitude])
        OR (g.Longitude IS NULL AND s.[Longitude] IS NULL)
    )
    AND (
        g.ISO3 = TRIM(s.[ISO3])
        OR (g.ISO3 IS NULL AND s.[ISO3] IS NULL)
    )
LEFT JOIN dbo.Dim_Tiempo AS t
    ON t.Full_Date = CAST(s.[Order Date] AS DATE)
LEFT JOIN dbo.Dim_Tiempo AS te
    ON te.Full_Date = CAST(s.[Ship Date] AS DATE)
LEFT JOIN dbo.Dim_Envio AS e
    ON e.Ship_Mode = TRIM(s.[Ship Mode])
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Fact_Ventas AS f
    WHERE f.Primary_ID = CONVERT(INT, s.[Primary ID])
);
