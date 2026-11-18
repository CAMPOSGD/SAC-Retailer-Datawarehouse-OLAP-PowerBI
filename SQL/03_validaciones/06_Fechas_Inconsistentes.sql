-- Script 10 del informe: detalle de envíos anteriores al pedido.
SELECT
    [Primary ID],
    [Order ID],
    [Order Date],
    [Ship Date],
    DATEDIFF(DAY, [Ship Date], [Order Date]) AS Dias_Diferencia
FROM dbo.Stg_Retailer
WHERE [Ship Date] < [Order Date]
ORDER BY Dias_Diferencia DESC;
