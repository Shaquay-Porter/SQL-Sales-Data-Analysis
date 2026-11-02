
-- Explore all countries our customers come from.
Select Distinct country from gold.dim_customers;

--Explore all categories 
Select distinct category, subcategory, product_name from gold.dim_products
order by 1,2,3;

