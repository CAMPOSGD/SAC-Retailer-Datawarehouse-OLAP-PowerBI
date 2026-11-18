-- Resumen consolidado de registros cargados en las dimensiones.
SELECT 'Dim_Cliente' AS Tabla, COUNT(*) AS Registros FROM dbo.Dim_Cliente
UNION ALL
SELECT 'Dim_Producto', COUNT(*) FROM dbo.Dim_Producto
UNION ALL
SELECT 'Dim_Geografia', COUNT(*) FROM dbo.Dim_Geografia
UNION ALL
SELECT 'Dim_Tiempo', COUNT(*) FROM dbo.Dim_Tiempo
UNION ALL
SELECT 'Dim_Envio', COUNT(*) FROM dbo.Dim_Envio;
