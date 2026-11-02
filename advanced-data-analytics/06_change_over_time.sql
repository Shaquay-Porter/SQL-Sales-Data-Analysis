--Change over time trends 
Select 
YEAR(Order_date) as order_year,
MONTH(Order_date) as order_month,
SUM(Sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(Order_date), MONTH(Order_date)
ORDER BY YEAR(Order_date), MONTH(Order_date)

Select 
DATETRUNC(month, order_date) as order_date,
SUM(Sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)


Select 
FORMAT(order_date, 'yyy-MMM') as order_date,
SUM(Sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyy-MMM')
ORDER BY FORMAT(order_date, 'yyy-MMM')

