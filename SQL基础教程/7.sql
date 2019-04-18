SELECT product_id, product_name
FROM product
EXCEPT 
SELECT product_id, product_name
FROM product2;

SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP INNER JOIN Product AS P
     ON SP.product_id = P.product_id

SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP LEFT OUTER JOIN Product AS P
     ON SP.product_id = P.product_id

SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
     ON SP.product_id = P.product_id


SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, 
       IP.inventory_quantity, IP.inventory_id
FROM ShopProduct AS SP INNER JOIN Product AS P
     ON SP.product_id = P.product_id
	 INNER JOIN InventoryProduct AS IP
	 ON SP.product_id = IP.product_id;

SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP CROSS JOIN Product AS P

SELECT (CASE WHEN SP.shop_id IS NULL THEN '不确定' ELSE SP.shop_id END) AS shop_id, 
       (CASE WHEN SP.shop_name IS NULL THEN '不确定' ELSE SP.shop_name END) AS shop_name, 
	   P.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
     ON SP.product_id = P.product_id
ORDER BY shop_id;

SELECT COALESCE(SP.shop_id,'不确定')AS shop_id, 
       COALESCE(SP.shop_name, '不确定') AS shop_name, 
	   P.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
     ON SP.product_id = P.product_id
ORDER BY shop_id;
