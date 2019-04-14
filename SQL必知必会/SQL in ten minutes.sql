/*************************
 *      SELCET           *
 *************************/

select * --这是一行注释
from products;

select prod_desc
from products;

select vend_id, prod_name
from products;

SELECT DISTINCT vend_id 
FROM Products;

SELECT DISTINCT vend_id, prod_price
FROM Products;

SELECT TOP 5 vend_id, prod_price
FROM Products;


/*****************************
 *       ORDER BY            *
 *****************************/

SELECT prod_name
FROM Products
ORDER BY prod_name;  -- ORDER BY须在语句最后

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price, prod_name; --按多个列名排序

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY 2, 3;  --按SELECT后列名相对位置排序

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name; --默认ASC升序，DESC降序排序只对前面的列名有效


/**************************
 *         WHERE          *
 **************************/
SELECT prod_name, prod_price
FROM Products
WHERE prod_price < 10;   -- 筛选条件

SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DLL01';  -- 字符串用单引号

SELECT prod_name, prod_price
FROM Products
WHERE vend_id <> 'DLL01'
ORDER BY vend_id DESC;  --  WHERE和ORDER BY都可以用非选择列

SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;

SELECT prod_name 
FROM Products
WHERE prod_price IS NULL;  -- 空值

SELECT cust_name
FROM Customers
WHERE cust_email IS NULL;

/********************************
 *       AND OR NOT IN          *
 ********************************/
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' AND prod_price <= 4; -- AND

SELECT prod_name, prod_price 
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'; -- OR满足任一条件都可

SELECT prod_name, prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
      AND prod_price >= 10;  -- 操作符有优先级 AND > OR

SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN ('DLL01', 'BRS01') -- IN
ORDER BY prod_name;

SELECT prod_name
FROM Products
WHERE NOT vend_id = 'DLL01' -- NOT非
ORDER BY prod_name;


/***********************************
 *            wildcard             *
 ***********************************/

SELECT prod_id, prod_name
FROM  Products
WHERE prod_name LIKE  'Fish%';  -- %通配符

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%'; -- 通配符可在任意位置使用

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear'; -- _通配符只匹配一个字符

SELECT  cust_contact
FROM Customers
WHERE cust_contact LIKE '[JM]%'  -- [匹配字符集中的任一字符]
ORDER BY cust_contact;

SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[^JM]%'  -- 非字符集
ORDER BY cust_contact;


/*******************************
 *       创建计算字段          *
 *******************************/

SELECT vend_name + '(' + vend_country + ')'
FROM Vendors
ORDER BY vend_name;  -- 用+拼接

SELECT RTRIM(vend_name) + '(' + RTRIM(vend_country) + ')'
FROM Vendors
ORDER BY vend_name; -- RTRIM函数去掉右边的空格，LTRIM去左边，TRIM去左右

SELECT RTRIM(vend_name) + '(' + RTRIM(vend_country) + ')'
       AS vend_title  -- 用AS命名别名alias，以便客户端调用
FROM Vendors
ORDER BY vend_name; 

SELECT prod_id, 
       --quantity, 
	   --item_price,
	   quantity*item_price AS expanded_price -- 执行计算
FROM OrderItems
WHERE order_num = 20008;

/*****************************
 *           函数            *
 *****************************/

SELECT RTRIM(vend_name), RTRIM(UPPER(vend_name)) AS vend_name_upcase,
       RTRIM(LOWER(vend_name)) AS vend_name_lowercase
FROM Vendors
ORDER BY vend_name;

SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green'); -- 匹配发音

SELECT order_num
FROM Orders
WHERE DATEPART(yy, order_date) = 2012;

/****************************
 *    aggregate funtion     *
 ****************************/

SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01'; --平均值

SELECT COUNT(*) AS num_cust
FROM Customers;  -- 计算表中所有行数

SELECT COUNT(cust_email) AS num_cust
FROM Customers;  -- 指定列的行数

SELECT MAX(prod_price) AS max_price
FROM Products;

SELECT MIN(prod_price) AS min_price
FROM Products;

SELECT SUM(quantity) AS items_ordered
FROM OrderItems
WHERE order_num = 20005;

SELECT SUM(item_price*quantity) AS total_price
FROM OrderItems
WHERE order_num = 20005; -- 在函数中进行计算

SELECT AVG(DISTINCT prod_price) AS avg_price -- 聚集不同值
FROM Products
WHERE vend_id = 'DLL01';  

SELECT COUNT(*) AS num_itemsm,
       MIN(prod_price) AS price_min,
	   MAX(prod_price) AS price_max,
	   AVG(prod_price) AS price_avg
FROM Products;  -- 组合


/*******************************
 *           分组数据          *
 *******************************/

SELECT COUNT(*) AS num_prods
FROM Products
WHERE vend_id = 'DLL01';

SELECT vend_id, 
       COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id; --GROUP BY分组

SELECT vend_id, 
       COUNT(vend_id) AS num_prods -- *包含null
FROM Products
GROUP BY vend_id;

SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2;

SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;  -- ORDER BY与GROUP BY配合使用

SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';

SELECT cust_id
FROM Orders
WHERE order_num IN (20007, 20008);

SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
                     FROM OrderItems
					 WHERE prod_id = 'RGAN01'); --子查询

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
				  WHERE order_num IN (SELECT order_num
				                      FROM OrderItems
									  WHERE prod_id = 'RGAN01'));

SELECT cust_id,
       cust_name,
       cust_state,
	   (SELECT COUNT(*)
	    FROM Orders
		WHERE Orders.cust_id = Customers.cust_id) AS orders
FROM Customers
ORDER BY cust_name;

/**********************************
 *           join联结             *
 **********************************/

 SELECT vend_name, prod_name, prod_price
 FROM Vendors, Products
 WHERE Vendors.vend_id = Products.vend_id;  -- 两个表通过where联结
 -- 如果没有where子句，结果将是笛卡儿积

SELECT vend_name, prod_name, prod_price
FROM Vendors INNER JOIN Products
 ON Vendors.vend_id = Products.vend_id; -- 内联结标准写法

SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id = Vendors.vend_id
AND OrderItems.prod_id = Products.prod_id
AND order_num = 20007;

SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND OrderItems.order_num = Orders.order_num
AND prod_id = 'RGAN01';


/**********************************
 *            高级联结            *
 **********************************/

SELECT cust_name, cust_contact
FROM Customers AS C, Orders AS O, OrderItems AS OI  -- 表别名
WHERE C.cust_id = O.cust_id
AND OI.order_num = O.order_num
AND prod_id = 'RGAN01';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       


SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name = c2.cust_name
AND c2.cust_contact = 'Jim Jones';

SELECT C.*, O.order_num, O.order_date,
       OI.prod_id, OI.quantity, OI.item_price
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
AND OI.order_num = O.order_num
AND prod_id = 'RGAN01';

/************************
 *       外联结         *
 ************************/

SELECT Customers.cust_id, Orders.order_num
FROM Customers INNER JOIN Orders
ON Customers.cust_id = Orders.cust_id; --内联结只显示有关联的行

SELECT Customers.cust_id, Orders.order_num
FROM Customers LEFT OUTER JOIN Orders
ON Customers.cust_id = Orders.cust_id; --外联结会显示无关联的行

SELECT Customers.cust_id, Orders.order_num
FROM Customers FULL OUTER JOIN Orders
ON Customers.cust_id = Orders.cust_id;

SELECT Customers.cust_id,
       COUNT(Orders.order_num) AS num_ord
FROM Customers INNER JOIN Orders
ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

SELECT Customers.cust_id,
       COUNT(Orders.order_num) AS num_ord
FROM Customers LEFT OUTER JOIN Orders
ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;


SELECT * FROM Customers;
SELECT * FROM Orders;















       