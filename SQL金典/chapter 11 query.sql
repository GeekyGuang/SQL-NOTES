SELECT FNumber, FBillMakerId, FMakeDate
FROM T_SaleBill;

-- 显示制单人姓名
SELECT s.FNumber, p.FName, s.FMakeDate
FROM T_SaleBill s INNER JOIN T_Person p
ON s.FBillMakerId = p.FId;

-- 将空值也显示
SELECT s.FNumber, p.FName, s.FMakeDate
FROM T_SaleBill s LEFT OUTER JOIN T_Person p
ON s.FBillMakerId = p.FId;

-- 空值处理函数COALESCE（f1,f2...）返回第一个为真的值 ISNULL(F1,F2)是简化版
SELECT s.FNumber, COALESCE(p.FName,'没有开单人') AS 开单人, s.FMakeDate
FROM T_SaleBill s LEFT OUTER JOIN T_Person p
ON s.FBillMakerId = p.FId;

/***********************************/

SELECT salebill.FNumber, person.FName, salebill.FMakeDate,
       merchandise.FName, salebilldetail.FCount
FROM T_SaleBill salebill
INNER JOIN T_SaleBillDetail salebilldetail
ON salebilldetail.FBillId = salebill.FId
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId
LEFT OUTER JOIN T_Person person
ON saleBill.FBillMakerId = person.FId;

SELECT *
FROM T_SaleBill salebill
INNER JOIN T_SaleBillDetail salebilldetail
ON salebilldetail.FBillId = salebill.FId
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId
LEFT OUTER JOIN T_Person person
ON saleBill.FBillMakerId = person.FId;


-- 交叉联结不会显示空值
SELECT salebill.FNumber, person.FName, salebill.FMakeDate,
       merchandise.FName, salebilldetail.FCount
FROM T_SaleBill salebill, T_SaleBillDetail salebilldetail,
     T_Merchandise merchandise, T_Person  person
WHERE salebilldetail.FBillId = salebill.FId
AND salebilldetail.FMerchandiseId = merchandise.FId
AND salebill.FBillMakerId = person.FId;


/***********************************/
-- 如果不确定联结的结果，先用*显示联结的样子
SELECT * 
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FmerchandiseId = merchandise.FId

-- 销售总额
SELECT merchandise.FName AS MerchandiseName,
       merchandise.FPrice * salebilldetail.FCount AS Amount
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FmerchandiseId = merchandise.FId

-- 进价总额
SELECT merchandise.FName AS MerchandiseName,
       merchandise.FPrice * purchasebilldetail.FCount AS Amount
FROM T_PurchaseBillDetail purchasebilldetail
INNER JOIN T_Merchandise merchandise
ON purchasebilldetail.FMerchandiseId = merchandise.FId

-- 进价总额取负再union all

SELECT merchandise.FName AS MerchandiseName,
       merchandise.FPrice * salebilldetail.FCount AS Amount
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FmerchandiseId = merchandise.FId
UNION ALL
SELECT merchandise.FName AS MerchandiseName,
       merchandise.FPrice * purchasebilldetail.FCount * (-1) AS Amount
FROM T_PurchaseBillDetail purchasebilldetail
INNER JOIN T_Merchandise merchandise
ON purchasebilldetail.FMerchandiseId = merchandise.FId

-- 将以上查询作为子查询, 计算利润
SELECT details.MerchandiseName, SUM(details.Amount) 
FROM 
(
	SELECT merchandise.FName AS MerchandiseName,
		   merchandise.FPrice * salebilldetail.FCount AS Amount
	FROM T_SaleBillDetail salebilldetail
	INNER JOIN T_Merchandise merchandise
	ON salebilldetail.FmerchandiseId = merchandise.FId
	UNION ALL
	SELECT merchandise.FName AS MerchandiseName,
		   merchandise.FPrice * purchasebilldetail.FCount * (-1) AS Amount
	FROM T_PurchaseBillDetail purchasebilldetail
	INNER JOIN T_Merchandise merchandise
	ON purchasebilldetail.FMerchandiseId = merchandise.FId
) AS details -- 子查询必须有别名
GROUP BY details.MerchandiseName;


/**************************/
-- 计算每种产品销售总额
SELECT merchandise.FName, SUM(salebilldetail.FCount * merchandise.FPrice)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId
GROUP BY  merchandise.FName;


-- 计算总销售额
SELECT SUM(salebilldetail.FCount * merchandise.FPrice)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId;

-- 联合这两个查询
SELECT merchandise.FName, SUM(salebilldetail.FCount * merchandise.FPrice) AS Amount
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId
GROUP BY  merchandise.FName
UNION 
SELECT '总计', SUM(salebilldetail.FCount * merchandise.FPrice)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId;

-- 销售记录的份额
SELECT merchandise.FName, FCount,
       (FCount * 1.0) / SUM(FCount) OVER(PARTITION BY merchandise.FName)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId

-- 为采购单分级
-- 计算每笔交易每个商品的交易额
SELECT pb.FNumber, m.FName, pbd.FCount * m.FPrice
FROM T_PurchaseBillDetail pbd
INNER JOIN T_PurchaseBill pb
ON pbd.FBillId = pb.FId
INNER JOIN T_Merchandise m
ON pbd.FMerchandiseId = m.FId

-- 计算每笔交易总额
SELECT pb.FNumber, SUM(pbd.FCount * m.FPrice)
FROM T_PurchaseBillDetail pbd
INNER JOIN T_PurchaseBill pb
ON pbd.FBillId = pb.FId
INNER JOIN T_Merchandise m
ON pbd.FMerchandiseId = m.FId
GROUP BY pb.FNumber

-- 用CASE分级
SELECT pb.FNumber, 
       SUM(pbd.FCount * m.FPrice),
	   CASE
	    WHEN SUM(pbd.FCount * m.FPrice)<=500 THEN '小额'
		WHEN SUM(pbd.FCount * m.FPrice)>=1000 THEN '大额'
		ELSE '普通'
	   END 
FROM T_PurchaseBillDetail pbd
INNER JOIN T_PurchaseBill pb
ON pbd.FBillId = pb.FId
INNER JOIN T_Merchandise m
ON pbd.FMerchandiseId = m.FId
GROUP BY pb.FNumber


-- 违反DRY原则，优化
SELECT t.BillNumber, t.TotalAmount,
       CASE
			WHEN t.TotalAmount <= 500 THEN '小额'
			WHEN t.TotalAmount >= 1000 THEN '大额'
			ELSE '普通'
	   END
FROM
(
	SELECT pb.FNumber AS BillNumber, SUM(pbd.FCount * m.FPrice) AS TotalAmount
	FROM T_PurchaseBillDetail pbd
	INNER JOIN T_PurchaseBill pb
	ON pbd.FBillId = pb.FId
	INNER JOIN T_Merchandise m
	ON pbd.FMerchandiseId = m.FId
	GROUP BY pb.FNumber
) t


-- 学会把查询结果当做子查询的思路
SELECT *
FROM
(
	SELECT * 
	FROM
		(SELECT *
		FROM
		(
			SELECT pb.FNumber AS BillNumber, SUM(pbd.FCount * m.FPrice) AS TotalAmount
			FROM T_PurchaseBillDetail pbd
			INNER JOIN T_PurchaseBill pb
			ON pbd.FBillId = pb.FId
			INNER JOIN T_Merchandise m
			ON pbd.FMerchandiseId = m.FId
			GROUP BY pb.FNumber
		) a
	) b
) c    -- 子查询可以无限嵌套,但是必须有别名

-- 检索重叠日期销售单, 自联结
SELECT t1.FNumber,t1.FMakeDate,t1.FConfirmDate,
       t2.FNumber,t2.FMakeDate,t2.FConfirmDate
FROM T_SaleBill t1, T_SaleBill t2
WHERE t2.FMakeDate >= t1.FMakeDate
AND t2.FMakeDate <= t1.FConfirmDate
AND t2.FId <> t1.FId

-- 为查询排序, 使用ROW_NUMBER()函数
SELECT ROW_NUMBER() OVER(ORDER BY FId) AS rn,
       FNumber, FMakeDate
FROM T_SaleBill
WHERE FBillMakerId IS NOT NULL;

-- 标记最大销售单
SELECT FId, FBillId, FMerchandiseId, FCount,
       CASE
           WHEN FCount=MAX(FCount) OVER(PARTITION BY FBillId)
		   THEN '单内最大值'
		   ELSE ''
	   END
FROM T_SaleBillDetail;



-- 按第二个字母排序
SELECT * 
FROM T_Person
ORDER BY SUBSTRING(FName, 2, 1)

-- 随机排序
SELECT * FROM T_Person
ORDER BY NEWID();       -- SQL SERVER的RAND()函数每次产生的随机数都是一样的

-- 取前三个随机数
SELECT TOP 3 * FROM T_Person
ORDER BY NEWID(); 

-- 表间比较

SELECT * FROM T_SaleBill
WHERE FBillMakerId IN
(
 SELECT FBillMakerId FROM T_PurchaseBill
);

SELECT * FROM T_SaleBill
WHERE FBillMakerId NOT IN      -- 有空值 false or null的结果是null
(
 SELECT FBillMakerId FROM T_PurchaseBill
 WHERE FBillMakerId IS NOT NULL
);


-- 表复制

-- 复制一张表到新表
SELECT * 
INTO T_Person2
FROM T_Person

DROP TABLE T_Person2

-- 只复制表的结构
   用where 1<>1 让结果集为空
SELECT * 
INTO T_Person2
FROM T_Person
WHERE 1 <> 1

DROP TABLE T_Person2


-- 计算字符在字符串中出现的次数
SELECT FName, LEN(FName) - LEN(REPLACE(FName, 'r', ''))
FROM T_Person

-- 去掉所有最高和最低分，求平均值
SELECT AVG(FCount) FROM T_SaleBillDetail
WHERE FCount NOT IN
(
	(SELECT MIN(FCount) FROM T_SaleBillDetail),
	(SELECT MAX(FCount) FROM T_SaleBillDetail)
)

-- 只去掉一个最高分和一个最低分
SELECT (SUM(FCount) - MIN(FCount) - MAX(FCount))/(COUNT(FCount) - 2)
FROM T_SaleBillDetail;

SELECT 
	CASE COUNT(FCount)  -- 若只有两条记录则不计算
	WHEN 2 THEN NULL
	ELSE (SUM(FCount) - MIN(FCount) - MAX(FCount))/(COUNT(FCount) - 2)
	END
FROM T_SaleBillDetail;


-- 计算两个日期相差天数
SELECT FNumber, FMakeDate, FConfirmDate,
       DATEDIFF(DAY, FMakeDate, FConfirmDate) AS DaysBetween
FROM T_SaleBill;


SELECT t.FNumber AS FNumber, t.date1 AS FDate,
DATEDIFF(DAY, t.date1, t.date2) AS FDateDiff
FROM
(   -- 取得比当前制单日期大的最小日期
	SELECT t2.FNumber, t2.FMakeDate date1,
	(
	 SELECT MIN(T1.FMakeDate) FROM T_SaleBill t1 
	 WHERE t1.FMakeDate > t2.FMakeDate
	) date2
	FROM T_SaleBill t2
) t
ORDER BY t.date1

SELECT FNumber,FMakeDate,
LEAD(FMakeDate) OVER(ORDER BY FMakeDate)-FMakeDate
FROM T_SaleBill
ORDER BY FMakeDate

SELECT DATEDIFF(DAY, FCurrentYear, DATEADD(YEAR,1,FCurrentYear))
FROM 
(
 SELECT DATEADD(DAY, -DATEPART(DY,FMakeDate) + 1,
        FMakeDate) FCurrentYear
 FROM T_SaleBill
) t

-- 结果集转置
SELECT merchandise.FName,SUM(salebilldetail.FCount)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId
GROUP BY merchandise.FName

SELECT
SUM(CASE WHEN FMerchandiseId='00003' THEN FCount ELSE 0 END) AS Apple,
SUM(CASE WHEN FMerchandiseId='00001' THEN FCount ELSE 0 END) AS Bacon,
SUM(CASE WHEN FMerchandiseId='00002' THEN FCount ELSE 0 END) AS Cake
FROM T_SaleBillDetail

SELECT FBillId, FMerchandiseId,
       ROW_NUMBER() OVER(PARTITION BY FBillId ORDER BY FMerchandiseId) rn 
FROM T_SaleBillDetail

SELECT
MAX(CASE WHEN FBillId='00001' THEN FMerchandiseId ELSE '' END) AS
Bill_00001,
MAX(CASE WHEN FBillId='00002' THEN FMerchandiseId ELSE '' END) AS
Bill_00002,
MAX(CASE WHEN FBillId='00003' THEN FMerchandiseId ELSE '' END) AS
Bill_00003,
MAX(CASE WHEN FBillId='00004' THEN FMerchandiseId ELSE '' END) AS
Bill_00004,
MAX(CASE WHEN FBillId='00005' THEN FMerchandiseId ELSE '' END) AS
Bill_00005,
MAX(CASE WHEN FBillId='00006' THEN FMerchandiseId ELSE '' END) AS
Bill_00006
FROM
(
SELECT FBillId,FMerchandiseId,
ROW_NUMBER() OVER(PARTITION BY FBillId ORDER BY FMerchandiseId) rn
FROM T_SaleBillDetail
) t
GROUP BY rn;


