-- Carga de ubicaciones únicas.
-- Para reproducir desde cero, aplicamos ANTES de la carga el ajuste Unicode
-- que se realizó durante el trabajo tras encontrar el caso de Hanoi.
-- Así no dependemos de un Geography_Key fijo (954 solo en la instancia original).
ALTER TABLE dbo.Dim_Geografia
ALTER COLUMN City NVARCHAR(100) NULL;

ALTER TABLE dbo.Dim_Geografia
ALTER COLUMN State NVARCHAR(100) NULL;

ALTER TABLE dbo.Dim_Geografia
ALTER COLUMN Region NVARCHAR(100) NULL;

ALTER TABLE dbo.Dim_Geografia
ALTER COLUMN Country NVARCHAR(100) NULL;

ALTER TABLE dbo.Dim_Geografia
ALTER COLUMN Market NVARCHAR(100) NULL;

;WITH Ubicaciones AS (
    SELECT
        TRIM([City]) AS City,
        TRIM([State]) AS State,
        TRIM([Region]) AS Region,
        TRIM([Country]) AS Country,
        TRIM([Market]) AS Market,
        CONVERT(DECIMAL(10,7), [Latitude]) AS Latitude,
        CONVERT(DECIMAL(10,7), [Longitude]) AS Longitude,
        TRIM([ISO3]) AS ISO3
    FROM dbo.Stg_Retailer
)
INSERT INTO dbo.Dim_Geografia (
    City, State, Region, Country, Market,
    Latitude, Longitude, ISO3
)
SELECT
    City, State, Region, Country, Market,
    Latitude, Longitude, ISO3
FROM Ubicaciones

EXCEPT

SELECT
    City, State, Region, Country, Market,
    Latitude, Longitude, ISO3
FROM dbo.Dim_Geografia;

SELECT COUNT(*) AS Total_Ubicaciones
FROM dbo.Dim_Geografia;
