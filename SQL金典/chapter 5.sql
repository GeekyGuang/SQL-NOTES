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

-- ��Сд�л�
SELECT FName, 
       UPPER(Fname) AS FName_UPPER,  
	   LOWER(Fname) AS FName_LOWER
FROM T_Person;

SELECT '   123abc������',
       LEN('   123abc������'),
       RTRIM('   123abc������'),
	   LEN(RTRIM('   123abc������'));     -- ����Ŀո�û�м����ַ�����, ȫ�ǰ�Ƕ�һ��


-- LEN����������ַ�������Ŀո�
SELECT LEN('    SKDK   DKD   ');

-- DATALENGTH�Ż�������е��ַ�
SELECT DATALENGTH('    SKDK   DKD   ');


SELECT SUBSTRING('SKDNDKS23203SDJ', 2, 5);  -- ���ַ���


-- �����ַ�λ�ã�ע��������˳�������д���
SELECT FName, CHARINDEX('m', FName), CHARINDEX('ly', FName)
FROM T_Person;

-- ����࿪ʼȡ�ַ�
SELECT LEFT('SLDDKDFJ', 3);

-- ���Ҳ࿪ʼȡ�ַ�
SELECT RIGHT('SDDHFKDL', 4);

-- �滻�ַ�
SELECT REPLACE('SLDKIWPLZKSOADK', 'A', 'ZZZZ');

-- ��REPLACEɾ��ĳ���ַ�
SELECT REPLACE('LSKDSKS', 'K', '');

-- �ַ���ASCII��
SELECT ASCII('A'), ASCII('s');

-- ��������ASCII��
SELECT CHAR(56), CHAR(97), CHAR(ASCII('A'));

-- ����ȡ��������ȡ��
SELECT CEILING(293.233), FLOOR(232.223);

-- ��������
SELECT ROUND(233.232, 1);

-- ����ƥ��
SELECT *
FROM T_Person
WHERE SOUNDEX(FName) = SOUNDEX('Tom');

SELECT DIFFERENCE(FName, 'Merry') FROM T_Person;  -- �Ƚ����ƶ� 

SELECT * 
FROM T_Person 
WHERE DIFFERENCE(FName, 'Tim') >= 3;

-- ��ǰʱ��
SELECT GETDATE() AS ��ǰʱ��,
       CONVERT(VARCHAR(50), GETDATE(), 101) AS ������,
	   CONVERT(VARCHAR(50), GETDATE(), 108) AS ʱ��;

-- ��������
SELECT FBirthDay, 
       DATEADD(YEAR, 3, FBirthDay) AS threeyrs,
	   DATEADD(QUARTER, 20, FBirthDay) AS ttqutrs,
	   DATEADD(MONTH, 68, FBirthDay) AS sxtmonths,
	   DATEADD(WEEK, -1000, FBirthDay) AS thweeik,
	   DATEADD(DAY, -100, FBirthDay) AS tday
FROM T_Person;

-- ���ڲ��
SELECT FRegDay, FBirthDay, DATEDIFF(YEAR, FBirthDay, FRegDay)
FROM T_Person;

-- һ�����������ڼ�
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

-- ����ת��

SELECT CAST('-30' AS INTEGER) AS i,
       CONVERT(DECIMAL, '3.113323') AS d,
	   CONVERT(DATETIME, '2008-08-08 08:09:10') AS dt;

SELECT FIdNumber,
RIGHT(FIdNumber,3) as ����λ,
CAST(RIGHT(FIdNumber,3) AS INTEGER) as ����λ��������ʽ,
CAST(RIGHT(FIdNumber,3) AS INTEGER)+1 as ����λ��1,
CONVERT(INTEGER,RIGHT(FIdNumber,3))/2 as ����λ����2
FROM T_Person;

UPDATE T_Person SET FBirthDay=NULL WHERE FName ='Kerry';
UPDATE T_Person SET FBirthDay=NULL, FRegDay=NULL WHERE FName='Smith';

-- COALESCE���ص�һ����Ϊ�յ���
SELECT FName,FBirthDay,FRegDay,
       COALESCE(FBirthDay,FRegDay,'2008-08-08') AS ImportDay
FROM T_Person;

-- �򻯰棬ISNULLֻ������������
SELECT FName,FBirthDay,
       ISNULL(FBirthDay,'2008-08-08') AS ImportDay
FROM T_Person;


-- CASE���̿��ƺ���
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



       






