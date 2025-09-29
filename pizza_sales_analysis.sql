CREATE TABLE pizza_sales (
    order_id INT,
    pizza_id INT PRIMARY KEY,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size VARCHAR(5),
    pizza_category VARCHAR(50),
    pizza_ingredients VARCHAR(100),
    pizza_name VARCHAR(100)
);
use pizza_db;
describe pizza_sales;

select * from pizza_sales;

-- A. KPI's
-- 1. Total Revenue 
SELECT 
	SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- 2. Total Orders
SELECT 
	COUNT(DISTINCT order_id) as Total_Orders 
FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;

-- 4. Average Order Value
SELECT 
	ROUND((SUM(total_price) / COUNT(DISTINCT order_id)), 2) AS Avg_Order_Value 
FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT 
	ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS Avg_Pizzas_Per_Order
FROM pizza_sales;

SELECT * FROM pizza_sales;
-- B. HOUR TREND FOR TOTAL ORDERS
SELECT 
	HOUR(order_time) AS Order_Hour, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY HOUR(order_time);

-- C. DAILY TREND FOR TOTAL ORDERS
SELECT 
	DAYNAME(order_date) AS Order_Day, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- D. MONTHLY TREND FOR TOTAL ORDERS
SELECT 
	MONTHNAME(order_date) AS Order_Month, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date);

-- E. REVENUE PERCENTAGE(%) BY PIZZA CATEGORY
SELECT 
	pizza_category, SUM(total_price) AS Total_Revenue, 
    ROUND((SUM(total_price)*100 / (SELECT SUM(total_price) FROM pizza_sales)), 2) AS Revenue_Percentage
FROM pizza_sales
GROUP BY pizza_category;

-- F. REVENUE PERCENTAGE(%) BY PIZZA SIZE
SELECT 
	pizza_size, SUM(total_price) AS Total_Revenue, 
    ROUND((SUM(total_price)*100 / (SELECT SUM(total_price) FROM pizza_sales)), 2) AS Revenue_Percentage
FROM pizza_sales
GROUP BY pizza_size;

-- G. TOTAL PIZZAS SOLD BY PIZZA CATEGORY
SELECT 
	pizza_category, 
	SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category;

-- H. TOP 5 PIZZAS BY REVENUE
SELECT 
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC 
LIMIT 5;

-- I. BOTTOM 5 PIZZA BY REVENUE
SELECT 
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) 
LIMIT 5;

-- J. TOP 5 PIZZAS BY QUANTITY
SELECT 
	pizza_name, 
	SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 5;

-- K. BOTTOM 5 PIZZAS BY QUANTITY
SELECT 
	pizza_name, 
	SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) 
LIMIT 5;


