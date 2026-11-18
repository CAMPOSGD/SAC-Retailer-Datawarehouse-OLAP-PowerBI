-- Script 6 del informe: búsqueda de identificadores repetidos.
SELECT [Primary ID], COUNT(*) AS Repeticiones
FROM dbo.Stg_Retailer
GROUP BY [Primary ID]
HAVING COUNT(*) > 1
ORDER BY Repeticiones DESC;
