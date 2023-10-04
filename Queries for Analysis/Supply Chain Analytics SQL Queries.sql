#Creating fact_act_est table

create table fact_act_est
	(
        	select 
                    s.date as date,
                    s.fiscal_year as fiscal_year,
                    s.product_code as product_code,
                    s.customer_code as customer_code,
                    s.sold_quantity as sold_quantity,
                    f.forecast_quantity as forecast_quantity
        	from 
                    fact_sales_monthly s
        	left join fact_forecast_monthly f 
        	using (date, customer_code, product_code)
	)
	union
	(
        	select 
                    f.date as date,
                    f.fiscal_year as fiscal_year,
                    f.product_code as product_code,
                    f.customer_code as customer_code,
                    s.sold_quantity as sold_quantity,
                    f.forecast_quantity as forecast_quantity
        	from 
		    fact_forecast_monthly  f
        	left join fact_sales_monthly s 
        	using (date, customer_code, product_code)
	);

#Updating fact_act_est table to 0 values from null

	update fact_act_est
	set sold_quantity = 0
	where sold_quantity is null;

	update fact_act_est
	set forecast_quantity = 0
	where forecast_quantity is null;
    
    
# Creating Forecast error table

WITH forecast_error_table as (SELECT 
    fa.customer_code as customer_code,
	c.customer as customer_name,
	c.market as market,
    sum(fa.sold_quantity) as total_sold_qty,
    sum(fa.forecast_quantity) as total_forecast_qty,
    sum((forecast_quantity - sold_quantity)) as net_error,
    ROUND(sum((forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as net_error_pct,
    sum(abs(forecast_quantity - sold_quantity)) as abs_error,
    ROUND(sum(abs(forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as abs_error_pct
    FROM fact_act_est fa
    JOIN dim_customer c
    ON fa.customer_code = c.customer_code
    WHERE fa.fiscal_year = 2021
    GROUP BY customer_code)
    
    SELECT
    *, 
    if (abs_error_pct > 100, 0, 100.0 - abs_error_pct) as forecast_accuracy
    FROM forecast_error_table
    ORDER BY forecast_accuracy desc;
    
    
    
 # Exercise 2021 vs 2020 forecast accuracy 
 
 create temporary table forecast_accuracy_2020
 WITH forecast_error_table as (SELECT 
    fa.customer_code as customer_code,
	c.customer as customer_name,
	c.market as market,
    sum(fa.sold_quantity) as total_sold_qty,
    sum(fa.forecast_quantity) as total_forecast_qty,
    sum((forecast_quantity - sold_quantity)) as net_error,
    ROUND(sum((forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as net_error_pct,
    sum(abs(forecast_quantity - sold_quantity)) as abs_error,
    ROUND(sum(abs(forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as abs_error_pct
    FROM fact_act_est fa
    JOIN dim_customer c
    ON fa.customer_code = c.customer_code
    WHERE fa.fiscal_year = 2020
    GROUP BY customer_code)
    
    SELECT
    *, 
    if (abs_error_pct > 100, 0, 100.0 - abs_error_pct) as forecast_accuracy
    FROM forecast_error_table
    ORDER BY forecast_accuracy desc;
    
    
    
    
create temporary table forecast_accuracy_2021
 WITH forecast_error_table as (SELECT 
    fa.customer_code as customer_code,
	c.customer as customer_name,
	c.market as market,
    sum(fa.sold_quantity) as total_sold_qty,
    sum(fa.forecast_quantity) as total_forecast_qty,
    sum((forecast_quantity - sold_quantity)) as net_error,
    ROUND(sum((forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as net_error_pct,
    sum(abs(forecast_quantity - sold_quantity)) as abs_error,
    ROUND(sum(abs(forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as abs_error_pct
    FROM fact_act_est fa
    JOIN dim_customer c
    ON fa.customer_code = c.customer_code
    WHERE fa.fiscal_year = 2021
    GROUP BY customer_code)
    
    SELECT
    *, 
    if (abs_error_pct > 100, 0, 100.0 - abs_error_pct) as forecast_accuracy
    FROM forecast_error_table
    ORDER BY forecast_accuracy desc;
    
    
    
    
SELECT 
	f20.customer_code,
	f20.customer_name,
	f20.market,
	f20.forecast_accuracy as forecast_accuracy_2020,
	f21.forecast_accuracy as forecast_accuracy_2021
FROM forecast_accuracy_2020 f20
JOIN forecast_accuracy_2021 f21
ON f20.customer_code = f21.customer_code 
WHERE f21.forecast_accuracy < f20.forecast_accuracy
ORDER BY forecast_accuracy_2020 desc;


 
 
 
 
 
 
 
 
    
    
   
    
    
    
 
    
    
    
    