-- Script 3 del informe. Ejecutar solo en base nueva, después de las dimensiones.
CREATE TABLE dbo.Fact_Ventas (
    Primary_ID INT PRIMARY KEY,
    Order_ID INT,
    Customer_Key INT NOT NULL,
    Product_Key INT NOT NULL,
    Geography_Key INT NOT NULL,
    Order_Date_ID INT NOT NULL,
    Ship_Date_ID INT NULL,
    Ship_Mode_Key INT NULL,
    Quantity INT,
    Sales DECIMAL(18,2),
    Profit DECIMAL(18,2),
    Discount DECIMAL(10,4),
    Shipping_Costs DECIMAL(18,2),
    Storage_Costs DECIMAL(18,2),
    Personnel_Cost DECIMAL(18,2),
    Selling_Costs DECIMAL(18,2),
    Purchasing_Costs DECIMAL(18,2),
    Total_Cost DECIMAL(18,2),
    CONSTRAINT FK_Fact_Ventas_Cliente FOREIGN KEY (Customer_Key)
        REFERENCES dbo.Dim_Cliente(Customer_Key),
    CONSTRAINT FK_Fact_Ventas_Producto FOREIGN KEY (Product_Key)
        REFERENCES dbo.Dim_Producto(Product_Key),
    CONSTRAINT FK_Fact_Ventas_Geografia FOREIGN KEY (Geography_Key)
        REFERENCES dbo.Dim_Geografia(Geography_Key),
    CONSTRAINT FK_Fact_Ventas_OrderDate FOREIGN KEY (Order_Date_ID)
        REFERENCES dbo.Dim_Tiempo(Date_ID),
    CONSTRAINT FK_Fact_Ventas_ShipDate FOREIGN KEY (Ship_Date_ID)
        REFERENCES dbo.Dim_Tiempo(Date_ID),
    CONSTRAINT FK_Fact_Ventas_Envio FOREIGN KEY (Ship_Mode_Key)
        REFERENCES dbo.Dim_Envio(Ship_Mode_Key)
);
