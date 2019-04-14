-- ��������
SELECT * 
FROM T_Person;

SELECT COUNT(*) FROM T_Person;

SELECT FCity, FAge, COUNT(*)
FROM T_Person
WHERE FSalary < 5000
GROUP BY FCity, FAge;

SELECT FCity, FAge,
       (  
	    SELECT COUNT(*) FROM T_Person
		WHERE FSalary < 5000
		)
FROM T_Person
WHERE FSalary < 5000;

-- ʹ�ÿ�������
SELECT FCity, FAge, COUNT(*) OVER()   -- ���������ĸ�ʽ�� ���������У� OVER(ѡ��)
FROM T_Person
WHERE FSalary < 5000;

-- PARTITION BY
SELECT FName, FCity, FAge, FSalary,
       COUNT(*) OVER(PARTITION BY FCity) -- ������GROUP BY,���Ƕ����ڽ����
FROM T_Person;

-- ���������以������
SELECT FName, FCity, FAge, FSalary,
       COUNT(*) OVER(PARTITION BY FCity),
	   COUNT(*) OVER(PARTITION BY FAge)
FROM T_Person;

SELECT FName, FSalary,
SUM(FSalary) OVER(ORDER BY FSalary ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW)
FROM T_Person;

SELECT FName, FSalary,
SUM(FSalary) OVER(ORDER BY FSalary RANGE BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW)
FROM T_Person;

SELECT FName, FSalary,
SUM(FSalary) OVER(ORDER BY FSalary ROWS BETWEEN 2 PRECEDING AND 2
FOLLOWING)
FROM T_Person;

SELECT FName, FSalary,
SUM(FSalary) OVER(ORDER BY FSalary ROWS BETWEEN 1 FOLLOWING AND 3
FOLLOWING)
FROM T_Person;

SELECT FName, FSalary,
SUM(FSalary) OVER(ORDER BY FName)
FROM T_Person;

SELECT FName, FSalary,FAge,
MAX(FSalary) OVER(ORDER BY FAge)
FROM T_Person;

SELECT FName, FSalary,FAge,
MAX(FSalary) OVER(PARTITION BY FAge ORDER BY FSalary)
FROM T_Person;


/*
 *�߼���������
 */

-- ����
SELECT FName, FSalary, FAge,
       RANK() OVER(ORDER BY FAge),  -- ˳������
	   DENSE_RANK() OVER(ORDER BY FAge), -- ��������
	   ROW_NUMBER() OVER(ORDER BY FAge)  -- ��������к�
FROM T_Person;

-- ��ǰ����ռ�ٷֱ�
SELECT FName, FSalary, FAge,
       CAST(FSalary AS numeric) / SUM(FSalary) OVER() -- ��FSalaryת��Ϊ�����͵õ�С��������Ϊ0
FROM T_Person;

SELECT FName, FSalary, FAge,
       NTILE(7) OVER(ORDER BY FSalary)
FROM T_Person;

-- ȡ������к���ĵ�n��
SELECT FName, FSalary,FAge,
LEAD(FName) OVER(ORDER BY FSalary), -- Ĭ��ƫ��1
LEAD(FName,1,'�޺����') OVER(ORDER BY FSalary) -- ƫ��ֵ����Ϊ��
FROM T_Person;

SELECT FName, FSalary,FAge,
LEAD(FName,FAge/5,'���޴���') OVER(ORDER BY FSalary)
FROM T_Person;

-- LAG��ǰN��
SELECT FName, FSalary,FAge,
LAG(FName,FAge/5,'���޴���') OVER(ORDER BY FSalary)
FROM T_Person;


SELECT FName, FSalary,FAge,
       FIRST_VALUE(FName) OVER(PARTITION BY FAge ORDER BY FSalary),
       LAST_VALUE(FName) OVER(ORDER BY FSalary),
       LAST_VALUE(FName) OVER(ORDER BY FSalary RANGE BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING)
FROM T_Person;

DROP TABLE T_Person;


-- with�Ӿ���Ӳ�ѯ�������
-- WITH �������б����� AS ���Ӳ�ѯ��

WITH person_tom AS
(
 SELECT * FROM T_Person
 WHERE FName = 'TOM'
)
SELECT * FROM T_Person
WHERE FAge = person_tom.FAge
OR FSalary=person_tom.FSalary;


WITH person_tom AS
(
 SELECT * FROM T_Person
 WHERE FName = 'TOM'
)
SELECT * FROM T_Person
WHERE FAge = person_tom.FAge
OR FSalary=person_tom.FSalary;

WITH person_tom(F1, F2, F3) AS
(
 SELECT FAge, FName, FSalary FROM T_Person
 WHERE FName = 'TOM'
)
SELECT * FROM T_Person
WHERE FAge = person_tom.F1
OR FSalary=person_tom.F3;


CREATE TABLE T_Person
(
 FName		VARCHAR(20),
 FCity		VARCHAR(20),
 FAge		INT,
 FSalary	INT
);

INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Tom','BeiJing',20,3000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Tim','ChengDu',21,4000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Jim','BeiJing',22,3500);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Lily','London',21,2000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('John','NewYork',22,1000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('YaoMing','BeiJing',20,3000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Swing','London',22,2000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Guo','NewYork',20,2800);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('YuQian','BeiJing',24,8000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Ketty','London',25,8500);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Kitty','ChengDu',25,3000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Merry','BeiJing',23,3500);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Smith','ChengDu',30,3000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Bill','BeiJing',25,2000);
INSERT INTO T_Person(FName,FCity,FAge,FSalary)
VALUES('Jerry','NewYork',24,3300);



