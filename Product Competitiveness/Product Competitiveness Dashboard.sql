-- Dashboard 3 : Price Competititveness
WITH prod as (
SELECT 
	cat.category_name as category,
	prod.sku_id as product_id,
	prod.product_name as product_name,
	prod.product_price as price,
	prod.product_type as product_type,
	prod.cogs as cogs,
	cast(((prod.product_price/prod.cogs) - 1) as decimal(3,2)) as margin 
FROM products prod
LEFT JOIN category cat ON cat.category_id = prod.category_id)

SELECT 
	pd.category as category,
	pd.product_id as product_id,
	pd.product_name as product_name,
	pd.product_type as product_type,
	pd.price as price,
	pd.cogs as cogs,
	pd.margin as margin,
	com.max_comp_price as max_comp_price,
	sl.qty_sold as quantity_sold,
	cast((com.max_comp_price/pd.price - 1) as decimal(3,2)) as competitive_gap,
CASE 
	WHEN price > max_comp_price THEN 'Not Competitive'
	ELSE 'Competitive'
END AS Competitiveness
FROM prod as pd
LEFT JOIN 
(-- For Electronics product, max competitive price is the same as competitors_1
	SELECT 
		com.product_id as pdid,  
		pd.category_id as cat_id,
	CASE
	WHEN pd.category_id = 'ALT-SD03' THEN competitor_1
	ELSE cast(com.competitor_1 * 1.2 as numeric(15,0))
	END AS max_comp_price
	FROM competitors com
	LEFT JOIN products pd ON com.product_id = pd.sku_id
) com ON com.pdid = pd.product_id
LEFT JOIN ( SELECT 
		   		ordt.item_id AS item_id,
		   		SUM(quantity) as qty_sold
		   FROM order_items ordt
		   GROUP BY ordt.item_id
					) sl ON sl.item_id = pd.product_id;