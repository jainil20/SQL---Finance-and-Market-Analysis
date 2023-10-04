CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `net_sales` AS
    SELECT 
        `sales_postinvoice_discount`.`date` AS `date`,
        `sales_postinvoice_discount`.`fiscal_year` AS `fiscal_year`,
        `sales_postinvoice_discount`.`customer_code` AS `customer_code`,
        `sales_postinvoice_discount`.`customer` AS `customer`,
        `sales_postinvoice_discount`.`market` AS `market`,
        `sales_postinvoice_discount`.`product_code` AS `product_code`,
        `sales_postinvoice_discount`.`product` AS `product`,
        `sales_postinvoice_discount`.`variant` AS `variant`,
        `sales_postinvoice_discount`.`sold_quantity` AS `sold_quantity`,
        `sales_postinvoice_discount`.`gross_price_total` AS `gross_price_total`,
        `sales_postinvoice_discount`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        `sales_postinvoice_discount`.`Net_Invoice_Sales` AS `Net_Invoice_Sales`,
        `sales_postinvoice_discount`.`post_invoice_discount_pct` AS `post_invoice_discount_pct`,
        ((1 - `sales_postinvoice_discount`.`post_invoice_discount_pct`) * `sales_postinvoice_discount`.`Net_Invoice_Sales`) AS `Net_Sales`
    FROM
        `sales_postinvoice_discount`