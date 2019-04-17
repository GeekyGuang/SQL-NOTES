CREATE VIEW ProductSum(product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

CREATE VIEW ProductJim
AS
SELECT *
FROM Product
WHERE product_type = '�칫��Ʒ'

INSERT INTO ProductJim
VALUES('0009', 'ӡ��', '�칫��Ʒ', 95, 10, '2009-11-30');

SELECT *
FROM productJim;

DROP VIEW productJim;

DELETE FROM product WHERE product_id = '0009';

SELECT product_type, cnt_product
FROM (SELECT product_type, COUNT(*) AS cnt_product
      FROM Product
	  GROUP BY product_type) AS ProdcutSum;

SELECT *
FROM Product
WHERE sale_price > (SELECT AVG(sale_price) FROM Product);

SELECT product_type, product_name, sale_price
FROM Product p1
WHERE sale_price > (SELECT AVG(sale_price)
                    FROM product p2
					WHERE p1.product_type = p2.product_type  -- ָ���ȽϷ���
					GROUP BY product_type)

/**********************************
 *          ������ ��ϰ��           *
 **********************************/

CREATE VIEW ViewPractice5_1(product_name, sale_price, regist_date)
AS
SELECT product_name, sale_price, regist_date
FROM product 
WHERE sale_price >= 1000 AND regist_date = '2009-09-20';

SELECT * FROM ViewPractice5_1;

INSERT INTO ViewPractice5_1 VALUES('����', 200, '2009-11-02')

SELECT product_id, product_name, product_type, sale_price,
       (SELECT AVG(sale_price) FROM product) AS sale_price_all
FROM product;


-- ϰ��5.4
CREATE VIEW AvgPriceByType(product_id, product_name, product_type, sale_price, avg_sale_price)
AS
SELECT product_id, product_name, product_type, sale_price,
		(SELECT AVG(sale_price)
		 FROM product AS p2
		 WHERE p1.product_type = p2.product_type
		 GROUP BY product_type) AS avg_sale_price
FROM product AS p1;


DROP VIEW AvgPriceByType

CREATE VIEW AvgPriceByType
AS
SELECT product_id, product_name, product_type, sale_price,
		(SELECT AVG(sale_price)
		 FROM product AS p2
		 WHERE p1.product_type = p2.product_type
		 GROUP BY product_type) AS avg_sale_price
FROM product AS p1;

SELECT * FROM AvgPriceByType
       

