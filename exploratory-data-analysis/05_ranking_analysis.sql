-- Which 5 products generate the highest revenue 

SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY P.product_name 
ORDER BY total_revenue DESC


--What are the 5 worst-performing products in terms of sales.
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY P.product_name 
ORDER BY total_revenue ASC

-- TOP 10 customers who generated highest revenue 
SELECT TOP 10
c.first_name,
c.last_name,
c.customer_key,
SUM(f.sales_amount) total_rev
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_rev DESC

--The 3 customers with the lowest orders placed
Select top 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) AS Total_Orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY Total_Orders ASC

