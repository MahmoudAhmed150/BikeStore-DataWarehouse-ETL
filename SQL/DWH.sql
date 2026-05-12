CREATE DATABASE BikeStoreDWH
USE BikeStoreDWH;

-- =============================================
-- DIMENSIONS
-- =============================================

-- 1. Dim_Date (Conformed)
CREATE TABLE Dim_Date (
    date_sk     INT PRIMARY KEY IDENTITY(1,1),
    full_date   DATE,
    year        INT,
    quarter     INT,
    month       INT,
    month_name  NVARCHAR(20),
    day         INT,
    day_of_week NVARCHAR(15),
    is_weekend  BIT
);
GO

-- 2. Dim_Product (Conformed - SCD1)
CREATE TABLE Dim_Product (
    product_sk    INT PRIMARY KEY IDENTITY(1,1),
    product_id    INT,
    product_name  NVARCHAR(255),
    brand_name    NVARCHAR(255),
    category_name NVARCHAR(255),
    model_year    SMALLINT,
    list_price    DECIMAL(10,2)
);
GO

-- 3. Dim_Store (Conformed - SCD1)
CREATE TABLE Dim_Store (
    store_sk   INT PRIMARY KEY IDENTITY(1,1),
    store_id   INT,
    store_name NVARCHAR(255),
    street     NVARCHAR(255),
    city       NVARCHAR(255),
    state      NVARCHAR(10),
    zip_code   NVARCHAR(5)
);
GO

-- 4. Dim_Staff (SCD Type 2 على full_name و store_id)
CREATE TABLE Dim_Staff (
    staff_sk   INT PRIMARY KEY IDENTITY(1,1),
    staff_id   INT,
    full_name  NVARCHAR(100),
    active     TINYINT,
    store_id   INT,
    manager_id INT,
    valid_from DATE,
    valid_to   DATE,
    is_current BIT
);
GO

-- 5. Dim_Customer (SCD Type 2 على full_name و city)
CREATE TABLE Dim_Customer (
    customer_sk INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    full_name   NVARCHAR(255),
    street      NVARCHAR(255),
    city        NVARCHAR(50),
    state       NVARCHAR(25),
    zip_code    NVARCHAR(5),
    valid_from  DATE,
    valid_to    DATE,
    is_current  BIT
);
GO

-- 6. Dim_Order_Status (Junk - SCD1)
CREATE TABLE Dim_Order_Status (
    order_status_sk INT PRIMARY KEY IDENTITY(1,1),
    order_status    TINYINT,
    status_label    NVARCHAR(20),
    is_shipped      BIT,
    is_cancelled    BIT,
    is_pending      BIT
);
GO

-- =============================================
-- FACT TABLES
-- =============================================

-- 1. Fact_Sales
CREATE TABLE Fact_Sales (
    sales_sk        INT PRIMARY KEY IDENTITY(1,1),
    date_sk         INT REFERENCES Dim_Date(date_sk),
    customer_sk     INT REFERENCES Dim_Customer(customer_sk),
    product_sk      INT REFERENCES Dim_Product(product_sk),
    store_sk        INT REFERENCES Dim_Store(store_sk),
    staff_sk        INT REFERENCES Dim_Staff(staff_sk),
    order_status_sk INT REFERENCES Dim_Order_Status(order_status_sk),
    order_id        INT,        -- Degenerate Dimension
    item_id         INT,        -- Degenerate Dimension
    quantity        INT,
    list_price      DECIMAL(10,2),
    discount        DECIMAL(4,2),
    total_amount    DECIMAL(10,2)
);
GO

-- 2. Fact_Orders
CREATE TABLE Fact_Orders (
    order_sk        INT PRIMARY KEY IDENTITY(1,1),
    date_sk         INT REFERENCES Dim_Date(date_sk),
    customer_sk     INT REFERENCES Dim_Customer(customer_sk),
    store_sk        INT REFERENCES Dim_Store(store_sk),
    staff_sk        INT REFERENCES Dim_Staff(staff_sk),
    order_status_sk INT REFERENCES Dim_Order_Status(order_status_sk),
    order_id        INT,        -- Degenerate Dimension
    total_items     INT,
    total_amount    DECIMAL(10,2)
);
GO

-- 3. Fact_Inventory
CREATE TABLE Fact_Inventory (
    inventory_sk INT PRIMARY KEY IDENTITY(1,1),
    date_sk      INT REFERENCES Dim_Date(date_sk),
    product_sk   INT REFERENCES Dim_Product(product_sk),
    store_sk     INT REFERENCES Dim_Store(store_sk),
    quantity     INT
);
GO

-- =============================================
-- POPULATE Dim_Order_Status
-- =============================================
INSERT INTO Dim_Order_Status
    (order_status, status_label, is_shipped, is_cancelled, is_pending)
VALUES
    (1, 'Pending',    0, 0, 1),
    (2, 'Processing', 0, 0, 1),
    (3, 'Rejected',   0, 1, 0),
    (4, 'Completed',  1, 0, 0);
GO

-- =============================================
-- POPULATE Dim_Date
-- =============================================
DECLARE @date DATE = '2016-01-01';
WHILE @date <= '2019-12-31'
BEGIN
    INSERT INTO Dim_Date
        (full_date, year, quarter, month, month_name, day, day_of_week, is_weekend)
    VALUES (
        @date,
        YEAR(@date),
        DATEPART(QUARTER, @date),
        MONTH(@date),
        DATENAME(MONTH, @date),
        DAY(@date),
        DATENAME(WEEKDAY, @date),
        CASE WHEN DATEPART(WEEKDAY, @date) IN (1,7) THEN 1 ELSE 0 END
    );
    SET @date = DATEADD(DAY, 1, @date);
END
GO