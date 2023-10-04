CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_by_net_sales`(
              in_fiscal_year int,
              in_top_n int
	)
BEGIN
	SELECT 
		product,
        ROUND(SUM(Net_Sales/1000000),2) as Net_Sales_million
		FROM net_sales
        WHERE fiscal_year = in_fiscal_year
        GROUP BY product
        ORDER BY Net_Sales_million desc
        LIMIT in_top_n;

END