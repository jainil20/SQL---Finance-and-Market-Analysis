CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sales_preinvoice_discount` AS
    SELECT 
        `s`.`date` AS `date`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `s`.`customer_code` AS `customer_code`,
        `c`.`customer` AS `customer`,
        `c`.`market` AS `market`,
        `s`.`product_code` AS `product_code`,
        `p`.`product` AS `product`,
        `p`.`variant` AS `variant`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `g`.`gross_price` AS `gross_price`,
        ROUND((`s`.`sold_quantity` * `g`.`gross_price`),
                2) AS `gross_price_total`,
        `ped`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`
    FROM
        ((((`fact_sales_monthly` `s`
        JOIN `dim_customer` `c` ON ((`s`.`customer_code` = `c`.`customer_code`)))
        JOIN `dim_product` `p` ON ((`s`.`product_code` = `p`.`product_code`)))
        JOIN `fact_gross_price` `g` ON (((`g`.`fiscal_year` = `s`.`fiscal_year`)
            AND (`g`.`product_code` = `s`.`product_code`))))
        JOIN `fact_pre_invoice_deductions` `ped` ON (((`ped`.`fiscal_year` = `s`.`fiscal_year`)
            AND (`ped`.`customer_code` = `s`.`customer_code`))))