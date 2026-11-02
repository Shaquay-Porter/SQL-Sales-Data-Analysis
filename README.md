# SQL Sales Analytics — SQL Server / SSMS

My SQL Exploratory Data Analysis and Advanced Analytics course project, separated into topic-based Microsoft SQL Server scripts for easier use in **SQL Server Management Studio (SSMS)** and review on GitHub.

## Exploratory Data Analysis

1. `01_dimensions_exploration.sql` — distinct countries, product categories and products
2. `02_date_range_exploration.sql` — first and last orders, age ranges
3. `03_business_measures.sql` — total sales, counts, quantities and summary KPIs
4. `04_magnitude_analysis.sql` — grouped sales, customer and product comparisons
5. `05_ranking_analysis.sql` — top and bottom products and customers

## Advanced Data Analytics

6. `06_change_over_time.sql` — annual and monthly sales trends
7. `07_cumulative_analysis.sql` — running sales totals
8. `08_performance_analysis.sql` — sales versus averages and previous years
9. `09_part_to_whole.sql` — category contribution to total sales
10. `10_product_cost_segmentation.sql` — product cost bands
11. `11_customer_spending_segmentation.sql` — VIP, Regular and New customers
12. `12_customer_report.sql` — customer metrics and KPIs
13. `13_product_report.sql` — product metrics and KPIs

## How to use in SSMS

1. Connect SQL Server Management Studio to your server and select the database containing the `gold` schema.
2. Open a `.sql` file in SSMS and execute the statement(s) you wish to run.
3. Required tables: `gold.fact_sales`, `gold.dim_customers`, and `gold.dim_products`.
4. Some scripts use `DATETRUNC`, requiring **SQL Server 2022 or later**.

## Course credit

Project completed while following Data With Baraa's SQL data analytics lessons.
- [SQL full course](https://www.youtube.com/watch?v=SSKVgrwhzus)
- [Data With Baraa's course project repository](https://github.com/DataWithBaraa/sql-data-analytics-project)
