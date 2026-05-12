CREATE DATABASE BikeStoreOLTP;
GO

USE BikeStoreOLTP;
GO

-- =============================================
-- CREATE TABLES
-- =============================================

CREATE TABLE brands (
    brand_id   INT PRIMARY KEY,
    brand_name NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE categories (
    category_id   INT PRIMARY KEY,
    category_name NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE stores (
    store_id   INT PRIMARY KEY,
    store_name NVARCHAR(255) NOT NULL,
    phone      NVARCHAR(25),
    email      NVARCHAR(255),
    street     NVARCHAR(255),
    city       NVARCHAR(255),
    state      NVARCHAR(10),
    zip_code   NVARCHAR(5)
);
GO

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name NVARCHAR(255) NOT NULL,
    brand_id     INT REFERENCES brands(brand_id),
    category_id  INT REFERENCES categories(category_id),
    model_year   SMALLINT NOT NULL,
    list_price   DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE staffs (
    staff_id   INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name  NVARCHAR(50),
    email      NVARCHAR(255),
    phone      NVARCHAR(25),
    active     TINYINT,
    store_id   INT REFERENCES stores(store_id),
    manager_id NVARCHAR(10)
);
GO

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name  NVARCHAR(255),
    last_name   NVARCHAR(255),
    phone       NVARCHAR(25),
    email       NVARCHAR(255),
    street      NVARCHAR(255),
    city        NVARCHAR(50),
    state       NVARCHAR(25),
    zip_code    NVARCHAR(5)
);
GO

CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT REFERENCES customers(customer_id),
    order_status  TINYINT,
    order_date    DATE,
    required_date DATE,
    shipped_date  NVARCHAR(20),
    store_id      INT REFERENCES stores(store_id),
    staff_id      INT REFERENCES staffs(staff_id)
);
GO

CREATE TABLE order_items (
    order_id   INT REFERENCES orders(order_id),
    item_id    INT NOT NULL,
    product_id INT REFERENCES products(product_id),
    quantity   INT,
    list_price DECIMAL(10,2),
    discount   DECIMAL(4,2) DEFAULT 0,
    PRIMARY KEY (order_id, item_id)
);
GO

CREATE TABLE stocks (
    store_id   INT REFERENCES stores(store_id),
    product_id INT REFERENCES products(product_id),
    quantity   INT,
    PRIMARY KEY (store_id, product_id)
);
GO

-- =============================================
-- BULK INSERT
-- =============================================

BULK INSERT brands
FROM 'D:\archive (2)\brands.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT categories
FROM 'D:\archive (2)\categories.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT stores
FROM 'D:\archive (2)\stores.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT products
FROM 'D:\archive (2)\products.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT staffs
FROM 'D:\archive (2)\staffs.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT customers
FROM 'D:\archive (2)\customers.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT orders
FROM 'D:\archive (2)\orders.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT order_items
FROM 'D:\archive (2)\order_items.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

BULK INSERT stocks
FROM 'D:\archive (2)\stocks.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

-- =============================================
-- FIX NULL VALUES
-- =============================================

UPDATE staffs SET manager_id = NULL WHERE manager_id = 'NULL';
ALTER TABLE staffs ALTER COLUMN manager_id INT;
GO

UPDATE orders SET shipped_date = NULL WHERE shipped_date = 'NULL';
ALTER TABLE orders ALTER COLUMN shipped_date DATE;
GO


USE BikeStoreSTG;
GO

SELECT 'STG_Brands'      AS tbl, COUNT(*) AS rows FROM STG_Brands
UNION ALL
SELECT 'STG_Categories'  , COUNT(*) FROM STG_Categories
UNION ALL
SELECT 'STG_Products'    , COUNT(*) FROM STG_Products
UNION ALL
SELECT 'STG_Stores'      , COUNT(*) FROM STG_Stores
UNION ALL
SELECT 'STG_Staffs'      , COUNT(*) FROM STG_Staffs
UNION ALL
SELECT 'STG_Customers'   , COUNT(*) FROM STG_Customers
UNION ALL
SELECT 'STG_Orders'      , COUNT(*) FROM STG_Orders
UNION ALL
SELECT 'STG_Order_Items' , COUNT(*) FROM STG_Order_Items
UNION ALL
SELECT 'STG_Stocks'      , COUNT(*) FROM STG_Stocks;