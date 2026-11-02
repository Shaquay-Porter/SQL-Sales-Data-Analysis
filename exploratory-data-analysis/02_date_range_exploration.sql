--Find the date of the first and last order
--First order date
Select MIN(order_date) first_order_date,
--Last order date
 Max(order_date) last_order_date, 
-- How many years of data available
DATEDIFF(year, MIN(order_date), MAX(order_date)) as order_range_years
 from gold.fact_sales

 --Find the youngest and oldest customer
 Select
MIN(birthdate) as oldest_customer,
DATEDIFF(year, MIN(birthdate), GETDATE()) as oldest_age,
MAX(birthdate) as youngest_customer,
DATEDIFF(year, MAX(birthdate), GETDATE()) as youngest_age
 from gold.dim_customers
 
