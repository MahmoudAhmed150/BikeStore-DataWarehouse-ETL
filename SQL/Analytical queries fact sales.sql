-- 1. إجمالي المبيعات لكل منتج
SELECT 
    p.product_name,
    p.brand_name,
    p.category_name,
    SUM(f.quantity)     AS total_quantity,
    SUM(f.total_amount) AS total_revenue
FROM Fact_Sales f
JOIN Dim_Product p ON f.product_sk = p.product_sk
GROUP BY p.product_name, p.brand_name, p.category_name
ORDER BY total_revenue DESC;

-- 2. إجمالي المبيعات لكل متجر لكل سنة
SELECT 
    s.store_name,
    d.year,
    SUM(f.total_amount) AS total_revenue
FROM Fact_Sales f
JOIN Dim_Store  s ON f.store_sk  = s.store_sk
JOIN Dim_Date   d ON f.date_sk   = d.date_sk
GROUP BY s.store_name, d.year
ORDER BY d.year, total_revenue DESC;

-- 3. أفضل 10 عملاء من حيث الإنفاق
SELECT TOP 10
    c.full_name,
    c.city,
    c.state,
    SUM(f.total_amount) AS total_spent
FROM Fact_Sales f
JOIN Dim_Customer c ON f.customer_sk = c.customer_sk
WHERE c.is_current = 1
GROUP BY c.full_name, c.city, c.state
ORDER BY total_spent DESC;

-- 4. إجمالي المبيعات لكل موظف
SELECT 
    st.full_name    AS staff_name,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.total_amount)        AS total_revenue
FROM Fact_Sales f
JOIN Dim_Staff st ON f.staff_sk = st.staff_sk
WHERE st.is_current = 1
GROUP BY st.full_name
ORDER BY total_revenue DESC;