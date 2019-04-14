CREATE TABLE T_Person
(
 FIdNumber		VARCHAR(20),
 FName			VARCHAR(20),
 FBirthDay		DATETIME,
 FRegDay		DATETIME,
 FWeight		NUMERIC(10,2)
);

INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789120','Tom','1981-03-22','1998-05-01',56.67);
INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789121','Jim','1987-01-18','1999-08-21',36.17);
INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789122','Lily','1987-11-08','2001-09-18',40.33);
INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789123','Kelly','1982-07-12','2000-03-01',46.23);
INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789124','Sam','1983-02-16','1998-05-01',48.68);
INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789125','Kerry','1984-08-07','1999-03-01',66.67);
INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789126','Smith','1980-01-09','2002-09-23',51.28);
INSERT INTO T_Person(FIdNumber,FName,FBirthDay,FRegDay,FWeight)
VALUES ('123456789127','BillGates','1972-07-18','1995-06-19',60.32);

SELECT *
FROM T_Person;

-- 大小写切换
SELECT FName, 
       UPPER(Fname) AS FName_UPPER,  
	   LOWER(Fname) AS FName_LOWER
FROM T_Person;

SELECT '   123abc　　　',
       LEN('   123abc　　　'),
       RTRIM('   123abc　　　'),
	   LEN(RTRIM('   123abc　　　'));     -- 后面的空格并没有计入字符长度, 全角半角都一样


-- LEN并不会计算字符串后面的空格
SELECT LEN('    SKDK   DKD   ');

-- DATALENGTH才会计算所有的字符
SELECT DATALENGTH('    SKDK   DKD   ');


SELECT SUBSTRING('SKDNDKS23203SDJ', 2, 5);  -- 子字符串


-- 计算字符位置，注意括号内顺序，书中有错误
SELECT FName, CHARINDEX('m', FName), CHARINDEX('ly', FName)
FROM T_Person;

-- 从左侧开始取字符
SELECT LEFT('SLDDKDFJ', 3);

-- 从右侧开始取字符
SELECT RIGHT('SDDHFKDL', 4);

-- 替换字符
SELECT REPLACE('SLDKIWPLZKSOADK', 'A', 'ZZZZ');

-- 用REPLACE删除某个字符
SELECT REPLACE('LSKDSKS', 'K', '');

-- 字符的ASCII码
SELECT ASCII('A'), ASCII('s');

-- 由数字求ASCII码
SELECT CHAR(56), CHAR(97), CHAR(ASCII('A'));

-- 向上取整和向下取整
SELECT CEILING(293.233), FLOOR(232.223);

-- 四舍五入
SELECT ROUND(233.232, 1);

-- 发音匹配
SELECT *
FROM T_Person
WHERE SOUNDEX(FName) = SOUNDEX('Tom');

SELECT DIFFERENCE(FName, 'Merry') FROM T_Person;  -- 比较相似度 

SELECT * 
FROM T_Person 
WHERE DIFFERENCE(FName, 'Tim') >= 3;

-- 当前时间
SELECT GETDATE() AS 当前时间,
       CONVERT(VARCHAR(50), GETDATE(), 101) AS 年月日,
	   CONVERT(VARCHAR(50), GETDATE(), 108) AS 时间;

-- 日期增减
SELECT FBirthDay, 
       DATEADD(YEAR, 3, FBirthDay) AS threeyrs,
	   DATEADD(QUARTER, 20, FBirthDay) AS ttqutrs,
	   DATEADD(MONTH, 68, FBirthDay) AS sxtmonths,
	   DATEADD(WEEK, -1000, FBirthDay) AS thweeik,
	   DATEADD(DAY, -100, FBirthDay) AS tday
FROM T_Person;

-- 日期差额
SELECT FRegDay, FBirthDay, DATEDIFF(YEAR, FBirthDay, FRegDay)
FROM T_Person;

-- 一个日期是星期几
SELECT FBirthDay, DATENAME(WEEKDAY, FBirthDay)
FROM T_Person;

SELECT FBirthDay, 
       DATENAME(year, FBirthDay) AS y,
	   DATENAME(dayofyear, FBirthDay) AS d,
	   DATENAME(week, FBirthDay) AS u
FROM T_Person;

SELECT FBirthDay, 
       DATEPART(year, FBirthDay) AS y,
	   DATEPART(dayofyear, FBirthDay) AS d,
	   DATEPART(week, FBirthDay) AS u
FROM T_Person;

-- 类型转换

SELECT CAST('-30' AS INTEGER) AS i,
       CONVERT(DECIMAL, '3.113323') AS d,
	   CONVERT(DATETIME, '2008-08-08 08:09:10') AS dt;

SELECT FIdNumber,
RIGHT(FIdNumber,3) as 后三位,
CAST(RIGHT(FIdNumber,3) AS INTEGER) as 后三位的整数形式,
CAST(RIGHT(FIdNumber,3) AS INTEGER)+1 as 后三位加1,
CONVERT(INTEGER,RIGHT(FIdNumber,3))/2 as 后三位除以2
FROM T_Person;

UPDATE T_Person SET FBirthDay=NULL WHERE FName ='Kerry';
UPDATE T_Person SET FBirthDay=NULL, FRegDay=NULL WHERE FName='Smith';

-- COALESCE返回第一个不为空的数
SELECT FName,FBirthDay,FRegDay,
       COALESCE(FBirthDay,FRegDay,'2008-08-08') AS ImportDay
FROM T_Person;

-- 简化版，ISNULL只接受两个参数
SELECT FName,FBirthDay,
       ISNULL(FBirthDay,'2008-08-08') AS ImportDay
FROM T_Person;


-- CASE流程控制函数
SELECT FName,
       (CASE FName 
	   WHEN 'Tom' THEN 'GoodBoy'
	   WHEN 'Lily' THEN 'GoodGirl'
	   WHEN 'Sam' THEN 'BadBoy'
	   WHEN 'Kerry' THEN 'BadGirl'
	   ELSE 'Normal'
	   END) AS isgood
FROM T_Person;

SELECT FName,
       FWeight,
	   (CASE 
	    WHEN FWeight < 40 THEN 'thin'
		WHEN FWeight > 50 THEN 'fat'
		ELSE 'OK'
		END) AS isnormal
FROM T_Person;



       






