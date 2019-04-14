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

-- 检索某一列
SELECT FNumber 
FROM T_Employee;

-- 检索多个列
SELECT FName, FAge
FROM T_Employee;

-- 按指定的列顺序显示
SELECT FAge, FName, FSalary, FNumber
FROM T_Employee;

-- 列别名
SELECT FNumber AS Number1,  
       FName AS Name,
	   FAge AS Age,
	   FSalary Salary  -- AS可以省略
FROM T_Employee;


-- 显示中文列名
SELECT FNumber 工号,
       FName 姓名,
	   FAge  年龄,
	   FSalary 工资
FROM T_Employee;


-- 检索工资小于5000或年龄大于25的记录
SELECT *
FROM dbo.T_Employee
WHERE FSalary < 5000 OR FAge > 25;



-- 聚合函数用于数据汇总

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

SELECT COUNT(*) AS 所有行, 
       COUNT(FName) AS 非空行
FROM T_Employee;

-- 排序

SELECT *
FROM T_Employee 
ORDER BY FAge ASC;  -- 默认升序

SELECT *
FROM T_Employee 
ORDER BY FAge DESC;  -- 降序

SELECT *
FROM T_Employee 
ORDER BY FAge DESC, FSalary DESC;  -- 按多列排序有优先级

SELECT *
FROM T_Employee 
WHERE FAge > 25
ORDER BY FAge DESC, FSalary DESC;  -- ORDER BY必须放在最后面

-- 通配符

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE '_erry';  -- 单个字符匹配

SELECT *
FROM T_Employee 
WHERE FName LIKE '__n_';  -- _根据需要出现多次

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE 'T%';  -- %多字符匹配

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE '%n%';  -- %同样可出现在任意位置

SELECT *
FROM dbo.T_Employee
WHERE FName LIKE '%n_';  -- %和_配合使用

SELECT *
FROM T_Employee
WHERE FName LIKE '[SJ]%'; -- 这里匹配不区分大小写

INSERT INTO T_Employee(FNumber, FName, FAge)
VALUES('SALES004', 'jack', 22);

SELECT *
FROM T_Employee
WHERE FName LIKE '[^SJ]%'; -- 字符集取反

SELECT *
FROM T_Employee
WHERE NOT FName LIKE '[^SJ]%';   -- NOT非

SELECT * 
FROM dbo.T_Employee
WHERE FName IS NULL;  -- 空值判断
-- WHERE FName = NULL; 错误

SELECT * 
FROM dbo.T_Employee
WHERE FName IS NOT NULL;  -- 非空判断

SELECT * 
FROM T_Employee
WHERE FNAME IS NOT NULL AND FSalary < 5000;

-- 反义运算
SELECT *
FROM T_Employee 
--WHERE FAge != 22 AND FSalary !< 2000;
WHERE NOT (FAge = 22 AND FSalary < 2000);  -- 反义用其他方式替代,注意优先级

SELECT *
FROM T_Employee 
WHERE FAge <> 22;  -- 另一种不等于

-- 多值检测
SELECT *
FROM dbo.T_Employee
WHERE FAge IN (23, 25, 28);  -- 等价于OR语句

-- 范围检测
SELECT *
FROM dbo.T_Employee
WHERE FAge BETWEEN 23 AND 27; 

SELECT *
FROM T_Employee 
WHERE (FSalary BETWEEN 2000 AND 3000) 
      OR (FSalary BETWEEN 5000 AND 8000);
-- 2000 <= FSalary <= 3000, 闭区间

-- 更改表
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

SELECT FAge, AVG(FSalary)  -- SELECT后出现过的列必须在GROUP后出现过
FROM T_Employee 
GROUP BY FAge;

SELECT FSubCompany, FDepartment
FROM dbo.T_Employee
GROUP BY FSubCompany, FDepartment; --组中组

SELECT FsubCompany, FAge, COUNT(*) AS CountOfThisAge
FROM T_Employee 
GROUP BY FsubCompany, FAge  -- 结果以最后一级分组进行输出
ORDER BY FSubCompany;

DELETE FROM dbo.T_Employee -- FROM可以省略
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

SELECT DISTINCT FDepartment, FSubCompany  -- DISTINCT对整个结果去重
FROM T_Employee;

-- 常量字段
SELECT 'CowNew集团' AS CompanyName,
        918000000 AS RegAmount, 
		FName, FAge, FSubCompany 
FROM T_Employee;

SELECT FNumber, FName, FAge * FSalary AS FSalaryIndex
FROM T_Employee;

SELECT 125 + 521,
       FNumber, FName, 
	   FSalary / (FAge - 21) AS FHappyIndex
FROM T_Employee;

SELECT 1 + 1;  -- SELECT可以直接显示计算结果

SELECT * 
FROM T_Employee 
WHERE FSalary / (FAge - 21) > 1000; -- 字段作为过滤条件


-- 数值处理函数
SELECT Fname, LEN(FName) AS FName_LEN, 
       SUBSTRING(Fname, 2, 3) AS Fname_SUB
FROM T_Employee 
WHERE FAge > 22;

DELETE FROM T_Employee 
WHERE Fname IS NULL;

-- 字段拼接

SELECT '工号为' + FNumber + '的员工姓名为' + Fname
FROM T_Employee;

SELECT *
FROM T_Employee 
WHERE FSalary BETWEEN Fage*1.5 + 2000 AND Fage * 1.8 + 5000;

SELECT MAX(FSalary/FAge) AS MAXVALUE,
       MIN(FSalary/FAge) AS MINVALUE
FROM dbo.T_Employee;

-- 年龄全部+1
UPDATE T_Employee 
SET FAge = FAge + 1;

SELECT FAge
FROM T_Employee;

-- 不带FROM

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

SELECT *                       -- 结果显示这里的列名
FROM dbo.T_TempEmployee
UNION
SELECT FNumber, FName, FAge    -- 不会显示这些列名
FROM T_Employee;

-- UNION ALL显示重复项
SELECT FName, FAge FROM dbo.T_Employee
UNION ALL
SELECT FName, FAge FROM dbo.T_TempEmployee; 

SELECT '正式员工最高年龄', MAX(FAge) FROM T_Employee 
UNION
SELECT '正式员工最低年龄', MIN(FAge) FROM T_Employee 
UNION 
SELECT '临时工最高年龄', MAX(FAge) FROM T_TempEmployee
UNION
SELECT '临时工最低年龄', MIN(FAge) FROM T_TempEmployee;

SELECT FNumber, FSalary FROM T_Employee 
UNION
SELECT '工资合计', SUM(FSalary) FROM T_Employee;

SELECT 1,1 * 1
UNION
SELECT 2,2 * 2
UNION
SELECT 3,3 * 3
UNION
SELECT 4,4 * 4
UNION
SELECT 5,5 * 5;

SELECT '以下是正式员工姓名'
UNION ALL
SELECT FName FROM T_Employee 
UNION ALL
SELECT '以下是临时工姓名'
UNION ALL
SELECT Fname FROM dbo.T_TempEmployee;

DROP TABLE T_Employee;
DROP TABLE T_TempEmployee;