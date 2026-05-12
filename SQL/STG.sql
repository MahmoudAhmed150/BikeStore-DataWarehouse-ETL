CREATE DATABASE BikeStoreSTG;

USE BikeStoreSTG;

CREATE TABLE STG_Brands (
    brand_id   INT,
    brand_name VARCHAR(255)
);

CREATE TABLE STG_Categories (
    category_id   INT,
    category_name VARCHAR(255)
);

CREATE TABLE STG_Products (
    product_id   INT,
    product_name VARCHAR(255),
    brand_id     INT,
    category_id  INT,
    model_year   SMALLINT,
    list_price   DECIMAL(10,2)
);

CREATE TABLE STG_Stores (
    store_id   INT,
    store_name VARCHAR(255),
    phone      VARCHAR(25),
    email      VARCHAR(255),
    street     VARCHAR(255),
    city       VARCHAR(255),
    state      VARCHAR(10),
    zip_code   VARCHAR(5)
);

CREATE TABLE STG_Staffs (
    staff_id   INT,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    email      VARCHAR(255),
    phone      VARCHAR(25),
    active     TINYINT,
    store_id   INT,
    manager_id INT
);

CREATE TABLE STG_Customers (
    customer_id INT,
    first_name  VARCHAR(255),
    last_name   VARCHAR(255),
    phone       VARCHAR(25),
    email       VARCHAR(255),
    street      VARCHAR(255),
    city        VARCHAR(50),
    state       VARCHAR(25),
    zip_code    VARCHAR(5)
);

CREATE TABLE STG_Orders (
    order_id      INT,
    customer_id   INT,
    order_status  TINYINT,
    order_date    DATE,
    required_date DATE,
    shipped_date  DATE,
    store_id      INT,
    staff_id      INT
);

CREATE TABLE STG_Order_Items (
    order_id   INT,
    item_id    INT,
    product_id INT,
    quantity   INT,
    list_price DECIMAL(10,2),
    discount   DECIMAL(4,2)
);

CREATE TABLE STG_Stocks (
    store_id   INT,
    product_id INT,
    quantity   INT
);