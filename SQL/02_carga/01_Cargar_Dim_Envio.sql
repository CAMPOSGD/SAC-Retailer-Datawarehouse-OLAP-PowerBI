-- Carga de los métodos de envío únicos.
INSERT INTO dbo.Dim_Envio (Ship_Mode)
SELECT DISTINCT
    LTRIM(RTRIM(s.[Ship Mode]))
FROM dbo.Stg_Retailer AS s
WHERE s.[Ship Mode] IS NOT NULL
  AND LTRIM(RTRIM(s.[Ship Mode])) <> ''
  AND LEN(LTRIM(RTRIM(s.[Ship Mode]))) <= 100
  AND NOT EXISTS (
      SELECT 1
      FROM dbo.Dim_Envio AS d
      WHERE d.Ship_Mode = LTRIM(RTRIM(s.[Ship Mode]))
  );

SELECT Ship_Mode_Key, Ship_Mode
FROM dbo.Dim_Envio
ORDER BY Ship_Mode_Key;
