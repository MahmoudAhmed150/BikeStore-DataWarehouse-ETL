-- 1. إجمالي المخزون لكل متجر
SELECT 
    s.store_name,
    SUM(f.quantity) AS total_stock
FROM Fact_Inventory f
JOIN Dim_Store s ON f.store_sk = s.store_sk
GROUP BY s.store_name
ORDER BY total_stock DESC;

-- 2. المنتجات الأقل مخزوناً
SELECT TOP 10
    p.product_name,
    p.brand_name,
    p.category_name,
    SUM(f.quantity) AS total_stock
FROM Fact_Inventory f
JOIN Dim_Product p ON f.product_sk = p.product_sk
GROUP BY p.product_name, p.brand_name, p.category_name
ORDER BY total_stock ASC;

-- 3. المخزون لكل category
SELECT 
    p.category_name,
    COUNT(DISTINCT p.product_sk) AS total_products,
    SUM(f.quantity)              AS total_stock
FROM Fact_Inventory f
JOIN Dim_Product p ON f.product_sk = p.product_sk
GROUP BY p.category_name
ORDER BY total_stock DESC;

-- 4. المنتجات اللي مخزونها صفر
SELECT 
    p.product_name,
    p.brand_name,
    s.store_name,
    f.quantity
FROM Fact_Inventory f
JOIN Dim_Product p ON f.product_sk = p.product_sk
JOIN Dim_Store   s ON f.store_sk   = s.store_sk
WHERE f.quantity = 0
ORDER BY p.product_name;