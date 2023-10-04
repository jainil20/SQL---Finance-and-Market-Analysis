# Finance and Market Analytics Project

Welcome to the Finance and Market Analytics project repository. This project leverages SQL to perform various analyses and generate insights related to finance and market data. Below, you'll find an overview of the project's contents and key aspects.

## Project Contents

1. **Database**: In the "database" folder, you'll discover the SQL script for creating and populating the database. This database encompasses tables, views, stored procedures, and functions necessary for conducting financial and market analyses.


2. **SQL Queries For Analysis**:
   - [Finance Analytics report](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Queries%20for%20Analysis/Finance%20Analytics%20SQL%20Queries.sql) : This file contains SQL queries that calculate monthly and annual sales for a specific customer named "Croma."

   - [Top Products, Customers and Markets report](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Queries%20for%20Analysis/Top%20Products%2C%20Customers%2C%20Markets%20SQL%20Queries.sql) : This file includes SQL queries that perform various operations to calculate net sales, and then identify the top customers, top products, and top markets based on the results.

   - [Supply Chain Analytics report](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Queries%20for%20Analysis/Supply%20Chain%20Analytics%20SQL%20Queries.sql) : The SQL queries in this file assess forecast accuracy for the years 2020 and 2021, and provide a comparison between the two years.

3. **Views**: We've created a view named [net_sales](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Views%20and%20Functions/net_sales.sql) to simplify the process of finding net sales. You can use this view instead of writing the same query repeatedly.

4. **Stored Procedures**:
   - [get_forecast_accuracy.sql](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Stored%20Procedures/get_forecast_accuracy.sql) : This stored procedure calculates forecast accuracy for a given period.
   - [get_top_n_customers_by_net_sales.sql](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Stored%20Procedures/get_top_n_customers_by_net_sales.sql) : This stored procedure identifies the top customers based on sales.
   - [get_top_n_products_by_net_sales.sql](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Stored%20Procedures/get_top_n_products_by_net_sales.sql) : This stored procedure identifies the top products based on sales.
   - [get_top_n_markets_by_net_sales.sql](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Stored%20Procedures/get_top_n_markets_by_net_sales.sql) : This stored procedure identifies the top markets based on sales.
   - [get_market_badge.sql](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Stored%20Procedures/get_market_badge.sql) : This stored procedure assigns a market badge value (e.g., "GOLD" or "SILVER") based on sales performance.

5. **Functions**:
   - [get_fiscal_year.sql](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Views%20and%20Functions/get_fiscal_year.sql) : This function is designed to find the fiscal year for a given date.
   - [get_fiscal_quarter.sql](https://github.com/jainil20/SQL---Finance-and-Market-Analysis/blob/main/Views%20and%20Functions/get_fiscal_quarter.sql) : This function calculates the fiscal quarter for a given date.

## Getting Started

To use this project, follow these steps:

1. Execute the SQL script in the "database" folder to create and populate the database with sample data.

2. Utilize the provided SQL queries, views, stored procedures, and functions to perform various financial and market analyses.

Feel free to explore, analyze, and modify the code to suit your specific analytical needs.


## Acknowledgments

We extend our gratitude to Codebasics team for providing the data used in this project. The rights to the data remain with Codebasics and we are thankful for their data contributions.
