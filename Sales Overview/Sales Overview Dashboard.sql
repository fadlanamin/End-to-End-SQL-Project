-- Dashboard 1 : Sales Overview
-- convert result to excel file

WITH overview_table AS 
(SELECT 
 	ord.order_date as order_date,
	ot.order_id as order_id,
	ot.item_id as item_id,
	ot.quantity as quantity,
	ot.total_price as total_price,
	ur.location as locations
FROM orders ord
RIGHT OUTER JOIN order_items ot ON ot.order_id = ord.order_id
LEFT JOIN users ur ON ur.user_id = ord.cust_id)
SELECT 
	cte.order_date as order_date,
	cte.order_id as order_id,
	cte.item_id as item_id,
	prod.category_name as category,
	prod.product_price as product_price,
	prod.cogs as cogs,
	cte.quantity as quantity,
	cte.total_price as total_price,
	cte.locations as locations
FROM overview_table as cte
LEFT JOIN (
	SELECT c.category_name as category, p.sku_id as sku_id, p.product_name as product_name, c.category_name as category_name, p.product_price as product_price, p.cogs as cogs
	FROM products p 
	LEFT JOIN category c ON c.category_id = p.category_id) prod ON prod.sku_id = cte.item_id;
	