CREATE TABLE T_Customer
(
 FId		INT		NOT NULL,
 FName		VARCHAR(20)		NOT NULL,
 FAge		INT,
 PRIMARY KEY(FId)
);

CREATE TABLE T_OrderType
(
 FId		INT		NOT NULL,
 FName		VARCHAR(20)		NOT NULL,
 PRIMARY KEY(FId)
);

CREATE TABLE T_Order
(
 FId		INT		NOT NULL,
 FNumber	VARCHAR(20)		NOT NULL,
 FPrice		NUMERIC(10, 2),
 FCustomerId	INT,
 FTypeId	INT,
 PRIMARY KEY(FId)
);


INSERT INTO T_Customer(FId,FName,FAge)
VALUES(1,'TOM',21);
INSERT INTO T_Customer(FId,FName,FAge)
VALUES(2,'MIKE',24);
INSERT INTO T_Customer(FId,FName,FAge)
VALUES(3,'JACK',30);
INSERT INTO T_Customer(FId,FName,FAge)
VALUES(4,'TOM',25);
INSERT INTO T_Customer(FId,FName,FAge)
VALUES(5,'LINDA',NULL);

INSERT INTO T_OrderType(FId,FName)
VALUES(1,'MarketOrder');
INSERT INTO T_OrderType(FId,FName)
VALUES(2,'LimitOrder');
INSERT INTO T_OrderType(FId,FName)
VALUES(3,'Stop Order');
INSERT INTO T_OrderType(FId,FName)
VALUES(4,'StopLimit Order');

INSERT INTO T_Order(FId,FNumber,FPrice,FCustomerId, FTypeId)
VALUES(1,'K001',100,1,1);
INSERT INTO T_Order(FId,FNumber,FPrice,FCustomerId, FTypeId)
VALUES(2,'K002',200,1,1);
INSERT INTO T_Order(FId,FNumber,FPrice,FCustomerId, FTypeId)
VALUES(3,'T003',300,1,2);
INSERT INTO T_Order(FId,FNumber,FPrice,FCustomerId, FTypeId)
VALUES(4,'N002',100,2,2);
INSERT INTO T_Order(FId,FNumber,FPrice,FCustomerId, FTypeId)
VALUES(5,'N003',500,3,4);
INSERT INTO T_Order(FId,FNumber,FPrice,FCustomerId, FTypeId)
VALUES(6,'T001',300,4,3);
INSERT INTO T_Order(FId,FNumber,FPrice,FCustomerId, FTypeId)
VALUES(7,'T002',100,NULL,1);

SELECT * FROM T_Customer;
SELECT * FROM T_Order;
SELECT * FROM T_OrderType;

SELECT FId
FROM dbo.T_Customer
WHERE FName = 'Mike';

SELECT FNumber, FPrice
FROM dbo.T_Order
WHERE FCustomerId = 2;

-- 内联结
SELECT T_Order.FId, FName, FNumber, FPrice
FROM T_Order INNER JOIN T_Customer 
ON FCustomerId = T_Customer.FId      -- 如果两张表有相同名称的字段，则要指明是哪张表的
WHERE T_Customer.FName = 'Tom';

-- 显式指明所有表
SELECT T_Order.FId, T_Customer.FName, T_Order.FNumber, T_Order.FPrice
FROM T_Order INNER JOIN T_Customer 
ON T_Order.FCustomerId = T_Customer.FId     
WHERE T_Customer.FName = 'Tom';


SELECT * 
FROM T_Order INNER JOIN T_Customer
ON T_Order.FCustomerId = T_Customer.FId
WHERE T_Customer.Fname = 'Tom';

/***************************************
 *            内联结的两种写法          *
 ***************************************/
      
-- 表别名
SELECT o.FId, c.FName, o.FNumber, o.FPrice
FROM T_Order AS o INNER JOIN T_Customer AS c  -- AS可省略
ON o.FCustomerId = c.FId     
WHERE c.FName = 'Tom';

-- 内联结另一种写法
SELECT o.FId, c.FName, o.FNumber, o.FPrice
FROM T_Order AS o, T_Customer AS c  -- AS可省略
WHERE o.FCustomerId = c.FId     
AND c.FName = 'Tom';


-- 联结多张表
SELECT o.FId, c.FName, o.FNumber, o.FPrice, k.FName
FROM T_Order AS o INNER JOIN T_Customer AS c  -- AS可省略
ON o.FCustomerId = c.FId 
INNER JOIN T_OrderType AS k
ON o.FTypeId = k.FId     
WHERE c.FName = 'Tom';

-- 另一种写法
SELECT o.FId, c.FName, o.FNumber, o.FPrice, k.FName
FROM T_Order AS o, T_Customer AS c, T_OrderType AS k
WHERE o.FCustomerId = c.FId 
AND o.FTypeId = k.FId 
AND c.FName = 'Tom';

/*************************************/
-- 不等值联结 

SELECT T_Order.FNumber,T_Order.FPrice,
T_Customer.FName,T_Customer.FAge
FROM T_Order
INNER JOIN T_Customer
ON T_Order.FPrice < T_Customer.FAge*5
AND T_Order.FCustomerId=T_Customer.FId;

-- 转换为等值联结，思路更清晰

SELECT T_Order.FNumber,T_Order.FPrice,
T_Customer.FName,T_Customer.FAge
FROM T_Order
INNER JOIN T_Customer
ON T_Order.FCustomerId=T_Customer.FId
WHERE T_Order.FPrice < T_Customer.FAge*5;

/************************/

-- 交叉联结, 得到的是笛卡尔积

SELECT T_Customer.FId, T_Customer.FName, T_Customer.FAge,
T_Order.FId, T_Order.FNumber, T_Order.FPrice
FROM T_Customer, T_Order;

SELECT c.FId, c.FName, c.FAge,
o.FId, o.FNumber, o.FPrice
FROM T_Customer c, T_Order o;

SELECT c.FId, c.FName, c.FAge,
o.FId, o.FNumber, o.FPrice
FROM T_Customer c CROSS JOIN T_Order o;

-- 自联结

SELECT FNumber,FPrice,FTypeId
FROM T_Order
INNER JOIN T_Order           -- 相同表名会报错
ON T_Order.FTypeId=T_Order.FTypeId

SELECT o1.FNumber, o1.FPrice, o1.FTypeId,
       o2.FNumber, o2.FPrice, o2.FTypeId
FROM T_Order o1
INNER JOIN T_Order  o2         -- 给同一张表两个名
ON o1.FTypeId = o2.FTypeId 
AND o1.FId < o2.FId;           -- FTypeId相同的不同订单

-- 外部联结（空值匹配）

-- 左外部联结
SELECT o.FNumber,o.FPrice,o.FCustomerId,
c.FName,c.FAge, c.FId
FROM T_Order o
LEFT OUTER JOIN T_Customer c
ON o.FCustomerId=c.FId
WHERE o.FPrice >= 150;

-- 右外部联结
SELECT o.FNumber,o.FPrice,o.FCustomerId,
c.FName,c.FAge, c.FId
FROM T_Order o
RIGHT OUTER JOIN T_Customer c
ON o.FCustomerId=c.FId;

-- 全外部联结（左、右外部联结的并集）
SELECT o.FNumber,o.FPrice,o.FCustomerId,
c.FName,c.FAge, c.FId
FROM T_Order o
FULL OUTER JOIN T_Customer c
ON o.FCustomerId=c.FId;

-- 用左UNION右实现全外部联结
SELECT o.FNumber,o.FPrice,o.FCustomerId,
c.FName,c.FAge, c.FId
FROM T_Order o
LEFT OUTER JOIN T_Customer c
ON o.FCustomerId=c.FId

UNION 

SELECT o.FNumber,o.FPrice,o.FCustomerId,
c.FName,c.FAge, c.FId
FROM T_Order o
RIGHT OUTER JOIN T_Customer c
ON o.FCustomerId=c.FId;


DROP TABLE T_Order;
DROP TABLE T_OrderType;
DROP TABLE T_Customer;


