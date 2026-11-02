/*
==========================================================
--Building customer report
==========================================================
Purpose:
	-This report consolidates key customer metrics and behaviours
Highlights:
	1. Gathers essential fields like names, ages and transactions
	2. Segements customers into categories (VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics
		-total orders
		-total sales
		-total quantity purchased
		-total products
		-lifespan in months
	4.  -Calculates valuable KPIs:
			-recency (months since last orders)
			-average order value
			-average monthly spend
===========================================================
*/
WITH base_query AS(
/*-----------------------------------------------------------------
1) Base Query: retrieves core columns from tables
-------------------------------------------------------------------*/
Select 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
DATEDIFF(year, c.birthdate, GETDATE()) age
From gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
WHERE order_date IS NOT NULL)

, customer_aggregation AS (
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
*/
SELECT
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) AS total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT product_key) AS total_products,
MAX(order_date) as last_order_date,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query 
GROUP BY customer_key,
customer_number,
customer_name,
age
)
SELECT 
customer_key,
customer_number,
customer_name,
age,
CASE 
	 WHEN age < 20 then 'Under 20'
	 WHEN age between 20 and 29 THEN '20-29'
	 WHEN age between 30 and 39 THEN '30-39'
	 WHEN age between 40 and 49 THEN '40-49'
ELSE '50 and Above'
END AS age_group,
CASE 
	 WHEN lifespan >= 12  AND total_sales > 5000 THEN 'VIP'
	 WHEN lifespan >= 12  AND total_sales <= 5000 THEN 'Regular'
	 ELSE 'New'
END AS customer_segment,
last_order_date,
DATEDIFF(month, last_order_date, GETDATE()) AS recency,
total_orders,
total_sales,
total_quantity,
total_products,
lifespan,
--Compute average order value
CASE WHEN total_orders = 0 then 0
	 ELSE total_sales / total_orders 
END AS avg_order_value,
--Compute average monthly spent
CASE WHEN lifespan = 0 then total_sales
	 ELSE total_sales / lifespan
END AS avg_monthly_spend
FROM customer_aggregation;

