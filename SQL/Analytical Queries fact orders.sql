-- 1. توزيع الأوردرات على حالات الشحن
SELECT 
    os.status_label,
    COUNT(f.order_id)   AS total_orders,
    SUM(f.total_amount) AS total_revenue
FROM Fact_Orders f
JOIN Dim_Order_Status os ON f.order_status_sk = os.order_status_sk
GROUP BY os.status_label
ORDER BY total_orders DESC;

-- 2. متوسط قيمة الأوردر لكل متجر
SELECT 
    s.store_name,
    COUNT(f.order_id)        AS total_orders,
    AVG(f.total_amount)      AS avg_order_value,
    SUM(f.total_amount)      AS total_revenue
FROM Fact_Orders f
JOIN Dim_Store s ON f.store_sk = s.store_sk
GROUP BY s.store_name
ORDER BY total_revenue DESC;

-- 3. عدد الأوردرات لكل شهر
SELECT 
    d.year,
    d.month_name,
    COUNT(f.order_id)   AS total_orders,
    SUM(f.total_amount) AS total_revenue
FROM Fact_Orders f
JOIN Dim_Date d ON f.date_sk = d.date_sk
GROUP BY d.year, d.month_name, d.month
ORDER BY d.year, d.month;

-- 4. أكثر العملاء طلباً
SELECT TOP 10
    c.full_name,
    c.city,
    COUNT(f.order_id)   AS total_orders,
    SUM(f.total_amount) AS total_spent
FROM Fact_Orders f
JOIN Dim_Customer c ON f.customer_sk = c.customer_sk
WHERE c.is_current = 1
GROUP BY c.full_name, c.city
ORDER BY total_orders DESC;