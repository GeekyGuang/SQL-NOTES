-- 商品利润表
CREATE TABLE ProductMargin
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
sale_price INTEGER,
purchase_price INTEGER,
margin INTEGER,
PRIMARY KEY(product_id));

INSERT INTO ProductMargin(product_id, product_name, sale_price, purchase_price, margin)
SELECT product_id, product_name, sale_price, purchase_price, sale_price - purchase_price
FROM Product;

SELECT *
FROM dbo.ProductMargin;

UPDATE ProductMargin 
SET sale_price = 3000,
    margin = sale_price - purchase_price  -- 这里的sale_price不会被改成3000，必须分开UPDATE
WHERE product_name = '菜刀';