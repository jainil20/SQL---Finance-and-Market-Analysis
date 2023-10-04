CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_customers_by_net_sales`(
        	in_market VARCHAR(45),
        	in_fiscal_year INT,
    		in_top_n INT
	)
BEGIN
	SELECT 
		customer,
        ROUND(SUM(Net_Sales/1000000),2) as Net_Sales_million
		FROM net_sales
        WHERE fiscal_year = in_fiscal_year AND market = in_market
        GROUP BY customer
        ORDER BY Net_Sales_million desc
        LIMIT in_top_n;

END