SELECT product_type,SUM(sale_price) AS sale_sum, SUM(purchase_price) AS purchase_sum
FROM product
GROUP BY product_type
HAVING SUM(sale_price) > 1.5 * SUM(purchase_price);





