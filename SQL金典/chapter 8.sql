-- 子查询：将一个查询语句做为一个结果集供其他SQL语句使用
SELECT * FROM T_Reader;
SELECT * FROM T_Book;
SELECT * FROM T_Category;
SELECT * FROM T_ReaderFavorite;


SELECT 1 AS f1,
       2,
	   (SELECT MIN(FYearPublished) FROM T_Book),  -- 单值（标量）子查询
	   (SELECT MAX(FYearPublished) FROM T_Book) AS f4;


-- 返回多条结果的子查询都不能作为标量子查询
SELECT 1 AS f1,
       2,
	   -- (SELECT FYearPublished FROM T_Book);
	   -- (SELECT MAX(FYearPublished), MIN(FYearPublished) FROM T_Book);
	   (SELECT FYearPublished FROM T_Book WHERE FYearPublished < 1750);


-- 列值子查询
SELECT T_Reader.FName, t2.FYearPublished, t2.FName
FROM T_Reader,
     (SELECT * FROM T_Book WHERE FYearPublished < 1800) AS t2;


-- 子查询里有别名就必须用别名
SELECT T_Reader.FName, t2.FYear, t2.FName, t2.F3
FROM T_Reader,
     (SELECT FYearPublished AS FYear,
	  FName,
	  1 + 2 AS F3
	  FROM T_Book WHERE FYearPublished < 1800) AS t2; 


-- 引用外部查询的相关子查询(难点)
SELECT FId, FName,
       (
	    SELECT MAX(FYearPublished)
		FROM T_Book
		WHERE T_Book.FCategoryId = T_Category.FId  --这个子查询无法单独执行
	   )
FROM T_Category;

SELECT *
FROM T_Book;

SELECT MAX(FYearPublished)
FROM T_Book
GROUP BY FCategoryId;


SELECT FReaderId FROM T_ReaderFavorite
WHERE FCategoryId = 
(
 SELECT FId FROM T_Category
 WHERE FName = 'Story'
);


SELECT T_Category.FId, T_Book. FName,T_Book.FYearPublished
FROM T_Category
INNER JOIN T_Book ON T_Category.FId=T_Book.FCategoryId
WHERE T_Book.FYearPublished=
(
SELECT MIN(T_Book.FYearPublished)
FROM T_Book
WHERE T_Book.FCategoryId=T_Category.FId
)


SELECT * FROM T_Reader
WHERE FYearOfJoin IN
(
 SELECT FYearPublished FROM T_Book
)


-- ANY和SOME是一样的

SELECT * FROM T_Book
WHERE FYearPublished = ANY           -- =ANY与IN等价
(
 SELECT FYearOfBirth FROM T_Reader
)

-- ALL
SELECT * FROM T_Book
WHERE FYearPublished < all           
(
 SELECT FYearOfBirth FROM T_Reader
)




-- EXISTS判断检索结果是否为空

SELECT * FROM T_Book 
WHERE EXISTS
(
 SELECT * FROM T_Reader
 WHERE FProvince = 'YunNan'
)

SELECT * FROM T_Category
WHERE EXISTS
(
 SELECT * FROM T_Book
 WHERE T_Book.FCategoryId = T_Category.FId
 AND T_Book.FYearPublished < 1950
)
-- 将T_Category里的每一条记录拿到T_Book里比对
-- 但是查询到的结果只会显示Category里的字段

-- 用内联结等价实现
SELECT T_Category.FId, T_Category.FName
FROM T_Category INNER JOIN T_Book
ON T_Book.FCategoryId = T_Category.FId
WHERE T_Book.FYearPublished < 1950
GROUP BY T_Category.FId, T_Category.FName;

-- INSERT INTO SELECT将检索出的数据插入另一张表

CREATE TABLE T_ReaderFavorite2 (FCategoryId INT,FReaderId INT)

INSERT INTO T_ReaderFavorite2(FCategoryId, FReaderId)
SELECT FCategoryId, FReaderId FROM T_ReaderFavorite;



SELECT * FROM T_ReaderFavorite2;
DELETE FROM T_ReaderFavorite2;

-- select into 直接复制并新建一张新表
SELECT * 
INTO T_ReaderFavorite3
FROM T_ReaderFavorite;     -- 注意FROM的位置在INTO后面


-- CASE函数
INSERT INTO T_ReaderFavorite2(FCategoryId, FReaderId)
SELECT FCategoryId,
(CASE
     WHEN FReaderId <= 10 THEN FReaderId
	 ELSE FReaderId - FCategoryId
 END)
FROM T_ReaderFavorite;

DROP TABLE T_ReaderFavorite2;
DROP TABLE T_ReaderFavorite3;


INSERT INTO T_ReaderFavorite(FCategoryId, FReaderId)
SELECT 1, FId FROM T_Reader;

DELETE FROM T_ReaderFavorite;
SELECT * FROM T_ReaderFavorite;

INSERT INTO T_ReaderFavorite(FCategoryId, FReaderId)
SELECT 1, FId FROM T_Reader 
WHERE NOT EXISTS
(
 SELECT * FROM T_ReaderFavorite 
 WHERE T_ReaderFavorite.FCategoryId = 1
 AND T_ReaderFavorite.FReaderId = T_Reader.FId
)

UPDATE T_Book 
SET FYearPublished = 
    (SELECT MAX(FYearPublished) FROM T_Book);

UPDATE T_Book AS b1
SET b1.FYearPublished = 2005
WHERE 
(
 SELECT COUNT(*) FROM T_Book AS b2
 WHERE b1.FCategoryId = b2.FCategoryId
)>3

DROP TABLE T_Reader;
DROP TABLE T_Book;
DROP TABLE T_Category;
DROP TABLE T_ReaderFavorite;









CREATE TABLE T_Reader
(
 FId		INT			NOT NULL,
 FName		VARCHAR(50),
 FYearOfBirth	INT,
 FCity		VARCHAR(50),
 FProvince	VARCHAR(50),
 FYearOfJoin	INT
);

CREATE TABLE T_Book
(
 FId		INT			NOT NULL,
 FName		VARCHAR(50),
 FYearPublished		INT,
 FCategoryId	INT
);

CREATE TABLE T_Category (FId INT NOT NULL ,FName VARCHAR(50));

CREATE TABLE T_ReaderFavorite
(
 FCategoryId		INT,
 FReaderId			INT
);

INSERT INTO T_Category(FId,FName)
VALUES(1,'Story');
INSERT INTO T_Category(FId,FName)
VALUES(2,'History');
INSERT INTO T_Category(FId,FName)
VALUES(3,'Theory');
INSERT INTO T_Category(FId,FName)
VALUES(4,'Technology');
INSERT INTO T_Category(FId,FName)
VALUES(5,'Art');
INSERT INTO T_Category(FId,FName)
VALUES(6,'Philosophy');

INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(1,'Tom',1979,'TangShan','Hebei',2003);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(2,'Sam',1981,'LangFang','Hebei',2001);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(3,'Jerry',1966,'DongGuan','GuangDong',1995);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(4,'Lily',1972,'JiaXing','ZheJiang',2005);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(5,'Marry',1985,'BeiJing','BeiJing',1999);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(6,'Kelly',1977,'ZhuZhou','HuNan',1995);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(7,'Tim',1982,'YongZhou','HuNan',2001);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(8,'King',1979,'JiNan','ShanDong',1997);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(9,'John',1979,'QingDao','ShanDong',2003);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(10,'Lucy',1978,'LuoYang','HeNan',1996);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(11,'July',1983,'ZhuMaDian','HeNan',1999);
INSERT INTO T_Reader(FId,FName,FYearOfBirth,FCity,FProvince,FYearOfJoin)
VALUES(12,'Fige',1981,'JinCheng','ShanXi',2003);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(1,'About J2EE',2005,4);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(2,'Learning Hibernate',2003,4);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(3,'Two Cites',1999,1);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(4,'Jane Eyre',2001,1);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(5,'Oliver Twist',2002,1);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(6,'History of China',1982,2);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(7,'History of England',1860,2);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(8,'History of America',1700,2);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(9,'History of TheWorld',2008,2);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(10,'Atom',1930,3);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(11,'RELATIVITY',1945,3);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(12,'Computer',1970,3);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(13,'Astronomy',1971,3);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(14,'How To Singing',1771,5);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(15,'DaoDeJing',2001,6);
INSERT INTO T_Book(FId,FName,FYearPublished,FCategoryId)
VALUES(16,'Obedience to Authority',1995,6);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(1,1);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(5,2);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(2,3);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(3,4);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(5,5);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(1,6);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(1,7);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(4,8);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(6,9);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(5,10);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(2,11);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(2,12);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(1,12);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(3,1);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(1,3);
INSERT INTO T_ReaderFavorite(FCategoryId,FReaderId)
VALUES(4,4);

