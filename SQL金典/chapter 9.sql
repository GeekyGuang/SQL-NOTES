-- 自动增长字段 IDENTITY(起始，步长)
CREATE TABLE T_Person
(
 FId	INT		PRIMARY KEY		IDENTITY(100,3),
 FName	varchar(20),
 FAge	INT
);

INSERT INTO T_Person(FName, FAge)
VALUES('Tom',18);
INSERT INTO T_Person(FName, FAge)
VALUES('Jim',17);
INSERT INTO T_Person(FName, FAge)
VALUES('Kerry',22);

SELECT *
FROM T_Person;

DROP TABLE T_Person;

-- NULL
CREATE TABLE T_Employee
(
 FId		VARCHAR(20),
 FName		VARCHAR(20),
 FSalary	INT
)

INSERT INTO T_Employee(FId,FName,FSalary)
VALUES('1','Tom',3000);
INSERT INTO T_Employee(FId,FName,FSalary)
VALUES('2','Jim',NULL);
INSERT INTO T_Employee(FId,FName,FSalary)
VALUES('3',NULL,8000);
INSERT INTO T_Employee(FId,FName,FSalary)
VALUES('4','Lily',9000);
INSERT INTO T_Employee(FId,FName,FSalary)
VALUES('5','Robert',2000);

SELECT * 
FROM T_Employee
WHERE FSalary IS NULL; -- NULL是未知，并不是0


SELECT FId, FName, FSalary, FSalary + 2000  -- NULL + 2000还是null
FROM T_Employee;

-- 用CASE函数将null转换为0
SELECT FId, FName, FSalary,
(CASE 
    WHEN FSalary IS NULL THEN 0
	ELSE FSalary
 END) + 2000
FROM T_Employee;

DROP TABLE T_Employee;




