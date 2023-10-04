# Joining products table with pre invoice deduction table

SELECT 
    	    s.date, 
            s.product_code, 
            p.product, 
            p.variant, 
            s.sold_quantity, 
            g.gross_price,
            ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total,
            ped.pre_invoice_discount_pct
            
	FROM fact_sales_monthly s
    JOIN dim_date dt
			ON dt.calendar_date = s.date
	JOIN dim_product p
            ON s.product_code=p.product_code
	JOIN fact_gross_price g
            ON g.fiscal_year=dt.fiscal_year
    	AND g.product_code=s.product_code
	JOIN fact_pre_invoice_deductions ped
			ON ped.fiscal_year=dt.fiscal_year
    	AND ped.customer_code=s.customer_code
	WHERE 
           dt.fiscal_year=2021     
	LIMIT 1000000;
    
    
    
    
    # After adding fiscal_year column to fact_sales_monthly table

SELECT 
    	    s.date, 
            s.product_code, 
            p.product, 
            p.variant, 
            s.sold_quantity, 
            g.gross_price,
            ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total,
            ped.pre_invoice_discount_pct
            
	FROM fact_sales_monthly s
	JOIN dim_product p
            ON s.product_code=p.product_code
	JOIN fact_gross_price g
            ON g.fiscal_year=s.fiscal_year
    	AND g.product_code=s.product_code
	JOIN fact_pre_invoice_deductions ped
			ON ped.fiscal_year=s.fiscal_year
    	AND ped.customer_code=s.customer_code
	WHERE 
           s.fiscal_year=2021     
	LIMIT 1000000;
    
    
   # Creating Query with database view sales_preinvoice_discount view for joining post_invoice_discount table
   
   
   SELECT 
		*, (gross_price_total - gross_price_total*pre_invoice_discount_pct) as Net_Invoice_Sales,
        (pod.discounts_pct + pod.other_deductions_pct) as post_invoice_discount_pct
        FROM sales_preinvoice_discount sd
        JOIN fact_post_invoice_deductions pod
			ON  sd.date = pod.date
            AND sd.customer_code = pod.customer_code
            AND sd.product_code = pod.product_code;
        
        
    # Finding Net Sales with sales_postinvoice_discount View created    
    
     SELECT 
		*, (1 - post_invoice_discount_pct)*Net_Invoice_Sales as Net_Sales
        FROM sales_postinvoice_discount;
        
        
# Finding Top Markets  by Net Sales in given Year
     SELECT 
		market,
        ROUND(SUM(Net_Sales/1000000),2) as Net_Sales_million
		FROM net_sales
        WHERE fiscal_year = 2021
        GROUP BY market
        ORDER BY Net_Sales_million desc
        LIMIT 5;
        
# Finding Top Customer by Net Sales

	SELECT 
		customer,
        ROUND(SUM(Net_Sales/1000000),2) as Net_Sales_million
		FROM net_sales
        WHERE fiscal_year = 2021 AND market = "India"
        GROUP BY customer
        ORDER BY Net_Sales_million desc
        LIMIT 5;
    
# Finding Top Product by Net Sales

	SELECT 
		product,
        ROUND(SUM(Net_Sales/1000000),2) as Net_Sales_million
		FROM net_sales
        WHERE fiscal_year = 2021
        GROUP BY product
        ORDER BY Net_Sales_million desc
        LIMIT 5;
     
     
        
# Preparaing Graph For Customer Net Sales with Over Clause

	WITH cte as (SELECT 
		customer,
        ROUND(SUM(Net_Sales/1000000),2) as Net_Sales_million
		FROM net_sales
        WHERE fiscal_year = 2021
        GROUP BY customer)
        
        SELECT 
        *,
        (Net_Sales_million*100)/SUM(Net_Sales_million) OVER() as netsales_pct
        FROM cte
        ORDER BY Net_Sales_million desc;
        
        
# Creating Pie chart for region wise market share of countries
        
        WITH cte as (SELECT 
		c.customer, c.region,
        ROUND(SUM(Net_Sales/1000000),2) as Net_Sales_million
		FROM net_sales ns
        JOIN dim_customer c ON 
        ns.customer_code = c.customer_code
        WHERE fiscal_year = 2021
        GROUP BY c.customer, c.region)
        
        SELECT 
        *,
        (Net_Sales_million*100)/SUM(Net_Sales_million) OVER(partition by region) as region_share_pct
        FROM cte
        ORDER BY region, region_share_pct desc;
        
        
        