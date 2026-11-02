--Cumulative analysis
--Calculate the running total of sales over time
Select 
order_date,
total_sales,
SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS running_total_sales
FROM
(
--Calculate the total sales per month
Select 
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales
from gold.fact_sales
Where order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t

--Easier way if you dont care about month by month
Select 
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales
FROM
(
Select 
DATETRUNC(year, order_date) as order_date,
SUM(sales_amount) as total_sales
from gold.fact_sales
Where order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)
)t

