CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
        	in_fiscal_year INT
	)
BEGIN

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
    WHERE fa.fiscal_year = in_fiscal_year
    GROUP BY customer_code)
    
SELECT
    *, 
    if (abs_error_pct > 100, 0, 100.0 - abs_error_pct) as forecast_accuracy
    FROM forecast_error_table
    ORDER BY forecast_accuracy desc;



END