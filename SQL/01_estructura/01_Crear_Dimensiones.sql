-- Script 1 del informe. Ejecutar solo en una base nueva, no en la base ya poblada.
CREATE TABLE dbo.Dim_Cliente (
    Customer_Key INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID VARCHAR(50) NOT NULL,
    Customer_Name VARCHAR(150),
    Segment VARCHAR(50)
);

CREATE TABLE dbo.Dim_Producto (
    Product_Key INT IDENTITY(1,1) PRIMARY KEY,
    Product_ID VARCHAR(50) NOT NULL,
    Product_Name VARCHAR(200),
    Sub_Category VARCHAR(100),
    Category VARCHAR(100)
);

CREATE TABLE dbo.Dim_Geografia (
    Geography_Key INT IDENTITY(1,1) PRIMARY KEY,
    City VARCHAR(100),
    State VARCHAR(100),
    Region VARCHAR(100),
    Country VARCHAR(100),
    Market VARCHAR(100),
    Latitude DECIMAL(10,7),
    Longitude DECIMAL(10,7),
    ISO3 VARCHAR(3)
);

CREATE TABLE dbo.Dim_Tiempo (
    Date_ID INT PRIMARY KEY,
    Full_Date DATE NOT NULL,
    [Day] INT,
    [Month] INT,
    [Quarter] INT,
    [Year] INT
);

CREATE TABLE dbo.Dim_Envio (
    Ship_Mode_Key INT IDENTITY(1,1) PRIMARY KEY,
    Ship_Mode VARCHAR(100)
);
