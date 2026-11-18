-- Script 8 del informe: inspección de tipos de datos de Stg_Retailer.
SELECT
    COLUMN_NAME AS Nombre_Columna,
    DATA_TYPE AS Tipo_Dato,
    CHARACTER_MAXIMUM_LENGTH AS Longitud,
    NUMERIC_PRECISION AS Precision_Numerica,
    NUMERIC_SCALE AS Escala_Decimal
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'Stg_Retailer'
ORDER BY ORDINAL_POSITION;
