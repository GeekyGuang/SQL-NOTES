SELECT product_name, regist_date
FROM Product
WHERE regist_date > '2009-04-28';

SELECT * 
FROM Product
WHERE purchase_price is NULL;

SELECT product_name, sale_price, purchase_price
FROM Product
WHERE sale_price - purchase_price >= 500;

SELECT product_name, product_type, 
       sale_price * 0.9 - purchase_price AS profit
FROM Product
WHERE sale_price * 0.9 - purchase_price > 100;  -- 别名profit不能用在where子句




