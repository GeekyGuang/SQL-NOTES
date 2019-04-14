SELECT FNumber, FBillMakerId, FMakeDate
FROM T_SaleBill;

-- ��ʾ�Ƶ�������
SELECT s.FNumber, p.FName, s.FMakeDate
FROM T_SaleBill s INNER JOIN T_Person p
ON s.FBillMakerId = p.FId;

-- ����ֵҲ��ʾ
SELECT s.FNumber, p.FName, s.FMakeDate
FROM T_SaleBill s LEFT OUTER JOIN T_Person p
ON s.FBillMakerId = p.FId;

-- ��ֵ������COALESCE��f1,f2...�����ص�һ��Ϊ���ֵ ISNULL(F1,F2)�Ǽ򻯰�
SELECT s.FNumber, COALESCE(p.FName,'û�п�����') AS ������, s.FMakeDate
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


-- �������᲻����ʾ��ֵ
SELECT salebill.FNumber, person.FName, salebill.FMakeDate,
       merchandise.FName, salebilldetail.FCount
FROM T_SaleBill salebill, T_SaleBillDetail salebilldetail,
     T_Merchandise merchandise, T_Person  person
WHERE salebilldetail.FBillId = salebill.FId
AND salebilldetail.FMerchandiseId = merchandise.FId
AND salebill.FBillMakerId = person.FId;


/***********************************/
-- �����ȷ������Ľ��������*��ʾ���������
SELECT * 
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FmerchandiseId = merchandise.FId

-- �����ܶ�
SELECT merchandise.FName AS MerchandiseName,
       merchandise.FPrice * salebilldetail.FCount AS Amount
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FmerchandiseId = merchandise.FId

-- �����ܶ�
SELECT merchandise.FName AS MerchandiseName,
       merchandise.FPrice * purchasebilldetail.FCount AS Amount
FROM T_PurchaseBillDetail purchasebilldetail
INNER JOIN T_Merchandise merchandise
ON purchasebilldetail.FMerchandiseId = merchandise.FId

-- �����ܶ�ȡ����union all

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

-- �����ϲ�ѯ��Ϊ�Ӳ�ѯ, ��������
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
) AS details -- �Ӳ�ѯ�����б���
GROUP BY details.MerchandiseName;


/**************************/
-- ����ÿ�ֲ�Ʒ�����ܶ�
SELECT merchandise.FName, SUM(salebilldetail.FCount * merchandise.FPrice)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId
GROUP BY  merchandise.FName;


-- ���������۶�
SELECT SUM(salebilldetail.FCount * merchandise.FPrice)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId;

-- ������������ѯ
SELECT merchandise.FName, SUM(salebilldetail.FCount * merchandise.FPrice) AS Amount
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId
GROUP BY  merchandise.FName
UNION 
SELECT '�ܼ�', SUM(salebilldetail.FCount * merchandise.FPrice)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId;

-- ���ۼ�¼�ķݶ�
SELECT merchandise.FName, FCount,
       (FCount * 1.0) / SUM(FCount) OVER(PARTITION BY merchandise.FName)
FROM T_SaleBillDetail salebilldetail
INNER JOIN T_Merchandise merchandise
ON salebilldetail.FMerchandiseId = merchandise.FId

-- Ϊ�ɹ����ּ�
-- ����ÿ�ʽ���ÿ����Ʒ�Ľ��׶�
SELECT pb.FNumber, m.FName, pbd.FCount * m.FPrice
FROM T_PurchaseBillDetail pbd
INNER JOIN T_PurchaseBill pb
ON pbd.FBillId = pb.FId
INNER JOIN T_Merchandise m
ON pbd.FMerchandiseId = m.FId

-- ����ÿ�ʽ����ܶ�
SELECT pb.FNumber, SUM(pbd.FCount * m.FPrice)
FROM T_PurchaseBillDetail pbd
INNER JOIN T_PurchaseBill pb
ON pbd.FBillId = pb.FId
INNER JOIN T_Merchandise m
ON pbd.FMerchandiseId = m.FId
GROUP BY pb.FNumber

-- ��CASE�ּ�
SELECT pb.FNumber, 
       SUM(pbd.FCount * m.FPrice),
	   CASE
	    WHEN SUM(pbd.FCount * m.FPrice)<=500 THEN 'С��'
		WHEN SUM(pbd.FCount * m.FPrice)>=1000 THEN '���'
		ELSE '��ͨ'
	   END 
FROM T_PurchaseBillDetail pbd
INNER JOIN T_PurchaseBill pb
ON pbd.FBillId = pb.FId
INNER JOIN T_Merchandise m
ON pbd.FMerchandiseId = m.FId
GROUP BY pb.FNumber


-- Υ��DRYԭ���Ż�
SELECT t.BillNumber, t.TotalAmount,
       CASE
			WHEN t.TotalAmount <= 500 THEN 'С��'
			WHEN t.TotalAmount >= 1000 THEN '���'
			ELSE '��ͨ'
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


-- ѧ��Ѳ�ѯ��������Ӳ�ѯ��˼·
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
) c    -- �Ӳ�ѯ��������Ƕ��,���Ǳ����б���

-- �����ص��������۵�, ������
SELECT t1.FNumber,t1.FMakeDate,t1.FConfirmDate,
       t2.FNumber,t2.FMakeDate,t2.FConfirmDate
FROM T_SaleBill t1, T_SaleBill t2
WHERE t2.FMakeDate >= t1.FMakeDate
AND t2.FMakeDate <= t1.FConfirmDate
AND t2.FId <> t1.FId

-- Ϊ��ѯ����, ʹ��ROW_NUMBER()����
SELECT ROW_NUMBER() OVER(ORDER BY FId) AS rn,
       FNumber, FMakeDate
FROM T_SaleBill
WHERE FBillMakerId IS NOT NULL;

-- ���������۵�
SELECT FId, FBillId, FMerchandiseId, FCount,
       CASE
           WHEN FCount=MAX(FCount) OVER(PARTITION BY FBillId)
		   THEN '�������ֵ'
		   ELSE ''
	   END
FROM T_SaleBillDetail;



-- ���ڶ�����ĸ����
SELECT * 
FROM T_Person
ORDER BY SUBSTRING(FName, 2, 1)

-- �������
SELECT * FROM T_Person
ORDER BY NEWID();       -- SQL SERVER��RAND()����ÿ�β��������������һ����

-- ȡǰ���������
SELECT TOP 3 * FROM T_Person
ORDER BY NEWID(); 

-- ���Ƚ�

SELECT * FROM T_SaleBill
WHERE FBillMakerId IN
(
 SELECT FBillMakerId FROM T_PurchaseBill
);

SELECT * FROM T_SaleBill
WHERE FBillMakerId NOT IN      -- �п�ֵ false or null�Ľ����null
(
 SELECT FBillMakerId FROM T_PurchaseBill
 WHERE FBillMakerId IS NOT NULL
);


-- ����

-- ����һ�ű��±�
SELECT * 
INTO T_Person2
FROM T_Person

DROP TABLE T_Person2

-- ֻ���Ʊ�Ľṹ
   ��where 1<>1 �ý����Ϊ��
SELECT * 
INTO T_Person2
FROM T_Person
WHERE 1 <> 1

DROP TABLE T_Person2


-- �����ַ����ַ����г��ֵĴ���
SELECT FName, LEN(FName) - LEN(REPLACE(FName, 'r', ''))
FROM T_Person

-- ȥ��������ߺ���ͷ֣���ƽ��ֵ
SELECT AVG(FCount) FROM T_SaleBillDetail
WHERE FCount NOT IN
(
	(SELECT MIN(FCount) FROM T_SaleBillDetail),
	(SELECT MAX(FCount) FROM T_SaleBillDetail)
)

-- ֻȥ��һ����߷ֺ�һ����ͷ�
SELECT (SUM(FCount) - MIN(FCount) - MAX(FCount))/(COUNT(FCount) - 2)
FROM T_SaleBillDetail;

SELECT 
	CASE COUNT(FCount)  -- ��ֻ��������¼�򲻼���
	WHEN 2 THEN NULL
	ELSE (SUM(FCount) - MIN(FCount) - MAX(FCount))/(COUNT(FCount) - 2)
	END
FROM T_SaleBillDetail;


-- �������������������
SELECT FNumber, FMakeDate, FConfirmDate,
       DATEDIFF(DAY, FMakeDate, FConfirmDate) AS DaysBetween
FROM T_SaleBill;


SELECT t.FNumber AS FNumber, t.date1 AS FDate,
DATEDIFF(DAY, t.date1, t.date2) AS FDateDiff
FROM
(   -- ȡ�ñȵ�ǰ�Ƶ����ڴ����С����
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

-- �����ת��
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


