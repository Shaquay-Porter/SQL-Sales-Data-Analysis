/*Group customers into 3 segments based on spending
VIP: Customers with 12 months of history and spending more than 5k
Regular: Customers with 12 months of history and spending less than 5k
New: Customers with a lifespan less than 12 months
And find the total number of customers by each group*/

WITH customer_spending AS (
SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)

SELECT
customer_segmentation,
COUNT(customer_key) total_customers
FROM (
SELECT
customer_key,
CASE WHEN lifespan >= 12  AND total_spending > 5000 THEN 'VIP'
	 WHEN lifespan >= 12  AND total_spending <= 5000 THEN 'Regular'
	 ELSE 'New'
END customer_segmentation
FROM customer_spending ) t
GROUP BY customer_segmentation
ORDER BY total_customers DESC
