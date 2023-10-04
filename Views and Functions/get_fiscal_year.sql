CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_year`(calendar_date DATE) RETURNS int
    DETERMINISTIC
BEGIN
        	DECLARE fiscal_year INT;
        	SET fiscal_year = YEAR(DATE_ADD(calendar_date, INTERVAL 4 MONTH));
        	RETURN fiscal_year;
	END