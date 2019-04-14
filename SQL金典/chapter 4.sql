CREATE TABLE T_Employee
(
  FNumber  VARCHAR(20),
  FName    VARCHAR(20),
  FAge     INT,
  FSalary  NUMERIC(10,2),
  PRIMARY KEY(FNumber)
)

INSERT INTO T_Employee(FNumber,FName,FAge,FSalary)
VALUES('DEV001','Tom',25,8300);
INSERT INTO T_Employee(FNumber,FName,FAge,FSalary)
VALUES('DEV002','Jerry',28,2300.80);
INSERT INTO T_Employee(FNumber,FName,FAge,FSalary)
VALUES('SALES001','John',23,5000);
INSERT INTO T_Employee(FNumber,FName,FAge,FSalary)
VALUES('SALES002','Kerry',28,6200);
INSERT INTO T_Employee(FNumber,FName,FAge,FSalary)
VALUES('SALES003','Stone',22,1200);
INSERT INTO T_Employee(FNumber,FName,FAge,FSalary)
VALUES('HR001','Jane',23,2200.88);
INSERT INTO T_Employee(FNumber,FName,FAge,FSalary)
VALUES('HR002','Tina',25,5200.36);
INSERT INTO T_Employee(FNumber,FName,FAge,FSalary) 
VALUES('IT001','Smith',28,3900);

-- ����ĳһ��
SELECT FNumber 
FROM T_Employee;

-- ���������
SELECT FName, FAge
FROM T_Employee;

-- ��ָ������˳����ʾ
SELECT FAge, FName, FSalary, FNumber
FROM T_Employee;

-- �б���
SELECT FNumber AS Number1,  
       FName AS Name,
	   FAge AS Age,
	   FSalary Salary  -- AS����ʡ��
FROM T_Employee;


-- ��ʾ��������
SELECT FNumber ����,
       FName ����,
	   FAge  ����,
	   FSalary ����
FROM T_Employee;


-- ��������С��5000���������25�ļ�¼
SELECT *
FROM dbo.T_Employee
WHERE FSalary < 5000 OR FAge > 25;



-- �ۺϺ����������ݻ���

SELECT MAX(FSalary) AS MAX_SALARY
FROM T_Employee
WHERE FAge > 25;

SELECT AVG(FAge) AS AVG_AGE
FROM T_Employee 
WHERE Fsalary > 3800;

SELECT SUM(Fsalary) AS SUM_SALARY
FROM dbo.T_Employee;

SELECT MIN(Fsalary) AS MIN_SALARY,
       MAX(Fsalary) AS MAX_SALARY
FROM dbo.T_Employee;

SELECT COUNT(*),
       COUNT(FNumber)
FROM T_Employee;

INSERT INTO T_Employee(FNumber, FAge, FSalary)
VALUES ('IT002', 27, 2800);

SELECT * 
FROM T_Employee;

SELECT COUNT(*) AS ������, 
       COUNT(FName) AS �ǿ���
FROM T_Employee;

-- ����

SELECT *
FROM T_Employee 
ORDER BY FAge ASC;  -- Ĭ������

SELECT *
FROM T_Employee 
ORDER BY FAge DESC;  -- ����

SELECT *
FROM T_Employee 
ORDER BY FAge DESC, FSalary DESC;  -- ���������������ȼ�

SELECT *
FROM T_Employee 
WHERE FAge > 25
ORDER BY FAge DESC, FSalary DESC;  -- ORDER BY������������

-- ͨ���

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE '_erry';  -- �����ַ�ƥ��

SELECT *
FROM T_Employee 
WHERE FName LIKE '__n_';  -- _������Ҫ���ֶ��

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE 'T%';  -- %���ַ�ƥ��

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE '%n%';  -- %ͬ���ɳ���������λ��

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE '%n_';  -- %��_���ʹ��

SELECT *
FROM T_Employee
WHERE FName LIKE '[SJ]%'; -- ����ƥ�䲻���ִ�Сд

INSERT INTO T_Employee(FNumber, FName, FAge)
VALUES('SALES004', 'jack', 22);

SELECT *
FROM T_Employee
WHERE FName LIKE '[^SJ]%'; -- �ַ���ȡ��

SELECT *
FROM T_Employee
WHERE NOT FName LIKE '[^SJ]%';   -- NOT��

SELECT * 
FROM dbo.T_Employee
WHERE FName IS NULL;  -- ��ֵ�ж�
-- WHERE FName = NULL; ����

SELECT * 
FROM dbo.T_Employee
WHERE FName IS NOT NULL;  -- �ǿ��ж�

SELECT * 
FROM T_Employee
WHERE FNAME IS NOT NULL AND FSalary < 5000;

-- ��������
SELECT *
FROM T_Employee 
--WHERE FAge != 22 AND FSalary !< 2000;
WHERE NOT (FAge = 22 AND FSalary < 2000);  -- ������������ʽ���,ע�����ȼ�

SELECT *
FROM T_Employee 
WHERE FAge <> 22;  -- ��һ�ֲ�����

-- ��ֵ���
SELECT *
FROM dbo.T_Employee
WHERE FAge IN (23, 25, 28);  -- �ȼ���OR���

-- ��Χ���
SELECT *
FROM dbo.T_Employee
WHERE FAge BETWEEN 23 AND 27; 

SELECT *
FROM T_Employee 
WHERE (FSalary BETWEEN 2000 AND 3000) 
      OR (FSalary BETWEEN 5000 AND 8000);
-- 2000 <= FSalary <= 3000, ������

-- ���ı�
ALTER TABLE T_Employee 
ADD FSubCompany VARCHAR(20);
ALTER TABLE T_Employee 
ADD FDepartment VARCHAR(20);

UPDATE T_Employee 
SET FSubCompany = 'Beijing',
    FDepartment = 'Development'
WHERE FNumber = 'DEV001';

UPDATE T_Employee 
SET FSubCompany='ShenZhen',FDepartment='Development'
WHERE FNumber='DEV002';
UPDATE T_Employee 
SET FSubCompany='Beijing',FDepartment='HumanResource'
WHERE FNumber='HR001';
UPDATE T_Employee 
SET FSubCompany='Beijing',FDepartment='HumanResource'
WHERE FNumber='HR002';
UPDATE T_Employee 
SET FSubCompany='Beijing',FDepartment='InfoTech'
WHERE FNumber='IT001';
UPDATE T_Employee 
SET FSubCompany='ShenZhen',FDepartment='InfoTech'
WHERE FNumber='IT002';
UPDATE T_Employee 
SET FSubCompany='Beijing',FDepartment='Sales'
WHERE FNumber='SALES001';
UPDATE T_Employee 
SET FSubCompany='Beijing',FDepartment='Sales'
WHERE FNumber='SALES002';
UPDATE T_Employee SET FSubCompany='ShenZhen',FDepartment='Sales'
WHERE FNumber='SALES003';

SELECT FAge
FROM dbo.T_Employee
WHERE FSubCompany = 'Beijing'
GROUP BY FAge;

SELECT FAge, AVG(FSalary)  -- SELECT����ֹ����б�����GROUP����ֹ�
FROM T_Employee 
GROUP BY FAge;

SELECT FSubCompany, FDepartment
FROM dbo.T_Employee
GROUP BY FSubCompany, FDepartment; --������

SELECT FsubCompany, FAge, COUNT(*) AS CountOfThisAge
FROM T_Employee 
GROUP BY FsubCompany, FAge  -- ��������һ������������
ORDER BY FSubCompany;

DELETE FROM dbo.T_Employee -- FROM����ʡ��
WHERE FsubCompany IS NULL;

SELECT FSubCompany, SUM(FSalary) AS FSalarySUM
FROM T_Employee 
GROUP BY FSubCompany;

SELECT FDepartment,
       SUM(FSalary) AS FSalarySUM,
	   MIN(FAge) AS FAgeMIN,
	   MAX(FAge) AS FAgeMAX
FROM T_Employee 
GROUP BY FDepartment;

SELECT FAge,COUNT(*) AS CountOfThisAge FROM T_Employee
GROUP BY FAge
HAVING COUNT(*) = 1 OR COUNT(*) = 3;

SELECT FAge,COUNT(*) AS CountOfThisAge FROM T_Employee
WHERE FAge > 22
GROUP BY FAge
HAVING COUNT(*) = 1 OR COUNT(*) = 3;

SELECT DISTINCT FDepartment, FSubCompany  -- DISTINCT���������ȥ��
FROM T_Employee;

-- �����ֶ�
SELECT 'CowNew����' AS CompanyName,
        918000000 AS RegAmount, 
		FName, FAge, FSubCompany 
FROM T_Employee;

SELECT FNumber, FName, FAge * FSalary AS FSalaryIndex
FROM T_Employee;

SELECT 125 + 521,
       FNumber, FName, 
	   FSalary / (FAge - 21) AS FHappyIndex
FROM T_Employee;

SELECT 1 + 1;  -- SELECT����ֱ����ʾ������

SELECT * 
FROM T_Employee 
WHERE FSalary / (FAge - 21) > 1000; -- �ֶ���Ϊ��������


-- ��ֵ������
SELECT Fname, LEN(FName) AS FName_LEN, 
       SUBSTRING(Fname, 2, 3) AS Fname_SUB
FROM T_Employee 
WHERE FAge > 22;

DELETE FROM T_Employee 
WHERE Fname IS NULL;

-- �ֶ�ƴ��

SELECT '����Ϊ' + FNumber + '��Ա������Ϊ' + Fname
FROM T_Employee;

SELECT *
FROM T_Employee 
WHERE FSalary BETWEEN Fage*1.5 + 2000 AND Fage * 1.8 + 5000;

SELECT MAX(FSalary/FAge) AS MAXVALUE,
       MIN(FSalary/FAge) AS MINVALUE
FROM dbo.T_Employee;

-- ����ȫ��+1
UPDATE T_Employee 
SET FAge = FAge + 1;

SELECT FAge
FROM T_Employee;

-- ����FROM

SELECT 1;

SELECT LEN('ABC');

SELECT 1, 2, 3, 'a', 'b', 'c';


CREATE TABLE T_TempEmployee
(
 FIdCardNumber VARCHAR(20)    PRIMARY KEY,
 FName         VARCHAR(20),
 FAge          INT
);

INSERT INTO T_TempEmployee(FIdCardNumber, FName, FAge)
VALUES('1234567890121', 'Sarani', 33);
INSERT INTO T_TempEmployee(FIdCardNumber,FName,FAge)
VALUES('1234567890122','Tom',26);
INSERT INTO T_TempEmployee(FIdCardNumber,FName,FAge)
VALUES('1234567890123','Yalaha',38);
INSERT INTO T_TempEmployee(FIdCardNumber,FName,FAge)
VALUES('1234567890124','Tina',26);
INSERT INTO T_TempEmployee(FIdCardNumber,FName,FAge)
VALUES('1234567890125','Konkaya',29);
INSERT INTO T_TempEmployee(FIdCardNumber,FName,FAge)
VALUES('1234567890126','Fotifa',46);

UPDATE T_TempEmployee 
SET FAge = FAge + 1;

SELECT *                       -- �����ʾ���������
FROM dbo.T_TempEmployee
UNION
SELECT FNumber, FName, FAge    -- ������ʾ��Щ����
FROM T_Employee;

-- UNION ALL��ʾ�ظ���
SELECT FName, FAge FROM dbo.T_Employee
UNION ALL
SELECT FName, FAge FROM dbo.T_TempEmployee; 

SELECT '��ʽԱ���������', MAX(FAge) FROM T_Employee 
UNION
SELECT '��ʽԱ���������', MIN(FAge) FROM T_Employee 
UNION 
SELECT '��ʱ���������', MAX(FAge) FROM T_TempEmployee
UNION
SELECT '��ʱ���������', MIN(FAge) FROM T_TempEmployee;

SELECT FNumber, FSalary FROM T_Employee 
UNION
SELECT '���ʺϼ�', SUM(FSalary) FROM T_Employee;

SELECT 1,1 * 1
UNION
SELECT 2,2 * 2
UNION
SELECT 3,3 * 3
UNION
SELECT 4,4 * 4
UNION
SELECT 5,5 * 5;

SELECT '��������ʽԱ������'
UNION ALL
SELECT FName FROM T_Employee 
UNION ALL
SELECT '��������ʱ������'
UNION ALL
SELECT Fname FROM dbo.T_TempEmployee;

DROP TABLE T_Employee;
DROP TABLE T_TempEmployee;