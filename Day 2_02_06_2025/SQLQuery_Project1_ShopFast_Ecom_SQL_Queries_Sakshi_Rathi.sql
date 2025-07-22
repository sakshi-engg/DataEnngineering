CREATE DATABASE ShopFast;
GO
USE ShopFast;

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM PRODUCTS;
SELECT * FROM ORDER_ITEMS;

--1. Customer Sign-up Trend (last 12 months)
SELECT FORMAT(signup_date, 'yyyy-MM') AS month, COUNT(*) AS new_customers
FROM CUSTOMERS
WHERE signup_date >= DATEADD(MONTH, -12, GETDATE())
GROUP BY FORMAT(signup_date, 'yyyy-MM')
ORDER BY month;

--2. Top 5 Customers by Revenue
SELECT TOP 5 c.customer_id, c.name, COUNT(o.order_id) AS total_orders,
       SUM(o.total_amount) AS total_revenue,
       AVG(o.total_amount) AS avg_order_value
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC;

--3. Order Status Distribution
SELECT status, COUNT(*) AS order_count
FROM ORDERS
GROUP BY status;

--4. Revenue by Category
SELECT p.category, SUM(oi.quantity * oi.price_per_unit) AS total_revenue
FROM ORDER_ITEMS oi
JOIN PRODUCTS p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

--5. Best-Selling Products (Top 5 by quantity sold)
SELECT TOP 5 p.product_name, SUM(oi.quantity) AS total_sold
FROM ORDER_ITEMS oi
JOIN PRODUCTS p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

--6. Low-Stock Products (<10% stock using CASE)
SELECT product_id, product_name, stock_quantity,
       CASE 
           WHEN stock_quantity < 10 THEN 'Critical Low'
           WHEN stock_quantity BETWEEN 10 AND 50 THEN 'Low'
           ELSE 'Sufficient'
       END AS stock_status
FROM PRODUCTS;

--7. Avg Delivery Time per Month
SELECT FORMAT(order_date, 'yyyy-MM') AS order_month,
       AVG(DATEDIFF(DAY, order_date, delivery_date)) AS avg_delivery_days
FROM ORDERS
WHERE delivery_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY order_month;

--8. Orders with Delivery >7 days
SELECT * 
FROM ORDERS
WHERE DATEDIFF(DAY, order_date, delivery_date) > 7;

--9. Repeat Customers
SELECT customer_id, COUNT(*) AS order_count
FROM ORDERS
GROUP BY customer_id
HAVING COUNT(*) > 1;

--10. Monthly Revenue Growth with LAG()
WITH MonthlyRevenue AS (
    SELECT FORMAT(order_date, 'yyyy-MM') AS order_month,
           SUM(total_amount) AS revenue
    FROM ORDERS
    GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT order_month, revenue,
       revenue - LAG(revenue) OVER (ORDER BY order_month) AS revenue_growth
FROM MonthlyRevenue;

--11. Cohort Analysis using CTE (signup year)
WITH Cohorts AS (
    SELECT customer_id, YEAR(signup_date) AS signup_year
    FROM CUSTOMERS
)
SELECT c.signup_year, COUNT(o.order_id) AS total_orders
FROM Cohorts c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.signup_year;

--12. Cancelled/Returned Product Revenue Loss
SELECT status, SUM(total_amount) AS revenue_loss
FROM ORDERS
WHERE status IN ('Cancelled', 'Returned')
GROUP BY status;

--13. Customer City Heatmap
SELECT city, COUNT(*) AS customer_count
FROM CUSTOMERS
GROUP BY city
ORDER BY customer_count DESC;

--14. First & Last Order per Customer using ROW_NUMBER()
WITH OrderedData AS (
    SELECT customer_id, order_id, order_date,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS rn_asc,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn_desc
    FROM ORDERS
)
SELECT customer_id, order_id, order_date, 'First Order' AS order_type
FROM OrderedData WHERE rn_asc = 1

UNION ALL

SELECT customer_id, order_id, order_date, 'Last Order' AS order_type
FROM OrderedData WHERE rn_desc = 1
ORDER BY customer_id, order_type;

-- 15. NULL Handling: Orders with missing delivery date or total amount
SELECT order_id, customer_id, order_date, delivery_date, total_amount,
       CASE WHEN delivery_date IS NULL THEN 'Missing Delivery Date' ELSE '' END AS delivery_issue,
       CASE WHEN total_amount IS NULL THEN 'Missing Amount' ELSE '' END AS amount_issue
FROM ORDERS
WHERE delivery_date IS NULL OR total_amount IS NULL;