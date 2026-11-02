/*
==========================================================
 Product report
==========================================================
Purpose:
	-This report consolidates key product metrics and behaviours
Highlights:
	1. Gathers essential fields like product name, category, subcategory and cost
	2. Segements products by revenue to identify High-performer, mid-range or low-performers
	3. Aggregates customer-level metrics
		-total orders
		-total sales
		-total quantity sold
		-total customers (unique)
		-lifespan in months
	4.  -Calculates valuable KPIs:
			-recency (months since last orders)
			-average order value
			-average monthly revenue
===========================================================
*/

/*-----------------------------------------------------------------
1) Base Query: retrieves core columns from tables
-------------------------------------------------------------------*/
WITH base_query_products AS
( 

	Select 
		p.product_name,
		p.product_key,
		p.category,
		p.subcategory,
		p.cost,
		f.quantity,
		f.sales_amount,
		f.order_date,
		f.order_number,
		f.customer_key
		From gold.fact_sales f
		LEFT JOIN gold.dim_products p
		ON f.product_key = p.product_key
		WHERE order_date IS NOT NULL 

)

, segmentation AS (
/*---------------------------------------------------------------------------
2) 	2. Segements products by revenue to identify High-performer, mid-range or low-performers

*/
SELECT 
product_key,
product_name,
category,
subcategory,
cost,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
MAX(order_date) AS last_sale_date,
COUNT(DISTINCT order_number) AS total_orders,
COUNT(DISTINCT customer_key) AS total_unique_customers,
SUM(sales_amount) AS total_revenue,
SUM(quantity) AS total_quantity,
ROUND(AVG(CAST(sales_amount AS FLOAT)/ NULLIF(quantity, 0)),1) AS avg_selling_price

FROM base_query_products

GROUP BY product_key,
product_name,
category,
subcategory,
cost
)

/*------------------------------------------------------------------
	3) Final Query: combine all product results into one output
-------------------------------------------------------------------- */
SELECT 
product_key,
product_name,
category,
subcategory,
cost,
last_sale_date,
DATEDIFF(month, last_sale_date, GETDATE()) AS recency,
CASE
		WHEN total_revenue >= 50000 THEN 'High performer'
		WHEN total_revenue >= 10000 THEN 'Mid-range performer'
		ELSE 'Low-Performer'
END AS performance_segmentation,
lifespan,
total_orders,
total_revenue,
total_quantity,
total_unique_customers,
avg_selling_price,
--Compute average order value
CASE WHEN total_orders = 0 then 0
	 ELSE total_revenue / total_orders 
END AS avg_order_revenue,
--Compute average monthly rev
CASE WHEN lifespan = 0 then total_revenue
	 ELSE total_revenue / lifespan
END AS avg_monthly_rev

FROM segmentation
ORDER BY total_revenue DESC