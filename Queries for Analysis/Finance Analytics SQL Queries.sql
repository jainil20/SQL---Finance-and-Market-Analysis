# Finding Gross Sales of CROMA for the Fiscal Year 2021

SELECT 
    	    s.date, 
            s.product_code, 
            p.product, 
            p.variant, 
            s.sold_quantity, 
            g.gross_price,
            ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total
	FROM fact_sales_monthly s
	JOIN dim_product p
            ON s.product_code=p.product_code
	JOIN fact_gross_price g
            ON g.fiscal_year=get_fiscal_year(s.date)
    	AND g.product_code=s.product_code
	WHERE 
    	    customer_code=90002002 AND 
            get_fiscal_year(s.date)=2021     
	LIMIT 1000000;
    
    
 
 # Croma Monthly Sales Report For All Years
 
 SELECT 
            s.date, 
    	    SUM(ROUND(s.sold_quantity*g.gross_price,2)) as monthly_sales
	FROM fact_sales_monthly s
	JOIN fact_gross_price g
        ON g.fiscal_year=get_fiscal_year(s.date) AND g.product_code=s.product_code
	WHERE 
             customer_code=90002002
	GROUP BY s.dateget_monthly_gross_sales_for_customer
    ORDER BY s.date;
    
    
# Croma Fiscal Year wise Sales Report

 SELECT 
            get_fiscal_year(s.date) as Fiscal_Year, 
    	    SUM(ROUND(s.sold_quantity*g.gross_price,2)) as Total_Gross_Sales
	FROM fact_sales_monthly s
	JOIN fact_gross_price g
        ON g.fiscal_year=get_fiscal_year(s.date) AND g.product_code=s.product_code
	WHERE 
             customer_code=90002002
	GROUP BY get_fiscal_year(s.date)
    ORDER BY Fiscal_Year;
    

# Market Badge based on Performance

SELECT 
	SUM(sold_quantity) as Total_qty_sold
	FROM fact_sales_monthly s
    JOIN dim_customer c 
    ON s.customer_code = c.customer_code
    WHERE get_fiscal_year(s.date) = 2021 AND c.market = "India"
    GROUP BY c.market;





