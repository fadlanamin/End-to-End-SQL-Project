WITH ord_table AS(
SELECT 
	ot.order_id as order_id,
	ot.item_id as item_id,
	ot.quantity as qty,
	ot.total_price as total_price,
	ord.cust_id as cust_id,
	ord.delivery_id as delivery,
	ord.payment_id as payment
FROM order_items ot
LEFT JOIN orders ord ON ord.order_id = ot.order_id)

SELECT
	ortab.order_id as order_id,
	ortab.cust_id as cust_id,
	ortab.qty as quantity,
	ortab.total_price as total_price,
	us.gender as gender,
	us.location as locations,
	del.delivery_method as delivery,
	pay.payment_method as payment,
	prod.category as category
FROM ord_table ortab
LEFT JOIN users us ON us.user_id = ortab.cust_id
LEFT JOIN delivery del ON del.delivery_id = ortab.delivery
LEFT JOIN payment pay ON pay.payment_id = ortab.payment
LEFT JOIN ( SELECT
		   		pr.sku_id as item_id,
		  		ct.category_id as category_id,
		  		ct.category_name as category
		  	FROM products pr
		  	LEFT JOIN category ct ON pr.category_id = ct.category_id )
			prod ON prod.item_id = ortab.item_id;