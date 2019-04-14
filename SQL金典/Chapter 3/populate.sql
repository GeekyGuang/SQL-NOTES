-- 插入T_Person
INSERT INTO T_Person(FName, FAge, FRemark)
VALUES('Tom', 18, 'USA');
INSERT INTO T_Person(FName,FAge,FRemark)
VALUES('Jim', 20, 'USA');
INSERT INTO T_Person(FName,FAge,FRemark)
VALUES('Lili', 22, 'China');
INSERT INTO T_Person(FName,FAge,FRemark)
VALUES('XiaoWang', 17, 'China');
INSERT INTO T_Person(FAge, FName, FRemark)
VALUES(21, 'Kimisushi', 'Korea');

INSERT INTO T_Person(FAge, FName) 
VALUES(22, 'LXF');

-- 不推荐的插入方式
INSERT INTO T_Person
VALUES('luren1', 23, 'China');


-- 插入T_Debt
INSERT INTO T_Debt(FNumber, FPerson)
VALUES('1', 'Jim'); -- 非空报错

INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('1', 200, 'Jim'); 

INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('2', 300, 'Jim');  

-- 外键约束
INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('3', 100, 'Jerry'); -- Jerry在外键中不存在

INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('3', 100, 'Tom'); 

-- 更新数据库
UPDATE T_Person
SET FRemark = 'SuperMan'; -- 整个列都被更改

UPDATE T_Person
SET FRemark = 'Sonic',
    FAge = 25;         -- 更改一张表中的多个列

UPDATE T_Person
SET FAge = 12
WHERE FName = 'Tom';  -- 用where过滤

UPDATE T_Person
SET FRemark = 'BlaBla'
WHERE FAge = 25;

UPDATE T_Person
SET FAge = 22
WHERE FName = 'jim' OR FName = 'LXF'; -- 使用逻辑运算符
-- 注意：Jim未被更改

UPDATE T_Debt 
SET FAmount = NULL   -- 非空约束
WHERE FPerson = 'TOM';

UPDATE T_Debt 
SET FAmount = 123
WHERE FPerson = 'Tom';

UPDATE T_Debt
SET FNumber = '2'
WHERE FPerson = 'Tom'; -- 主键冲突

UPDATE T_Debt
SET FNumber = '8'
WHERE FPerson = 'Tom'; 

UPDATE T_Debt 
SET FPerson = 'Merry'
WHERE FNumber = '1';     -- 外键不存在，报错

UPDATE T_Debt 
SET FPerson = 'Lili'
WHERE FNumber = '1';  



-- 数据删除, 仅仅是删除数据，不是删除表

DELETE FROM T_Debt;  -- 先删外键
DELETE FROM T_Person;

/*
  UPDATE 是更改列，DELETE是删除行
*/

INSERT INTO T_Person(FName,FAge,FRemark) VALUES('Jim',20,'USA');
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('Lili',22,'China') ;
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('XiaoWang',17,' China ') ;
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('Sam',16,'China') ;
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('BlueFin',12,'Mars') ;

DELETE FROM T_Person
WHERE FAge > 20 OR FRemark = 'Mars';

-- 删除整张表
DROP TABLE T_Debt, T_Person;  -- 可以分开写

SELECT *
FROM T_Person;
