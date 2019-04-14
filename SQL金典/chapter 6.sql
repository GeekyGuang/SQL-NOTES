CREATE TABLE T_Person
(
 FNumber VARCHAR(20),
 FName   VARCHAR(20),
 FAge    INT
);

-- ��������
CREATE INDEX idx_person_name ON T_Person(FName);
CREATE INDEX idx_person_nameage ON T_Person(FName, FAge);

-- ɾ������
DROP INDEX T_Person.idx_person_name;
DROP INDEX T_Person.idx_person_nameage;

DROP TABLE dbo.T_Person;

/**************************************/

CREATE TABLE T_Person
(
 FNumber VARCHAR(20) NOT NULL,  -- �ǿ�Լ��
 FName   VARCHAR(20),
 FAge    INT
);


INSERT INTO T_Person(FNumber, FName, FAge)
VALUES(NULL, 'kingchou', 20);

INSERT INTO T_Person(FNumber, FName, FAge)
VALUES('1', 'kingchou', 20);

UPDATE dbo.T_Person
SET FNumber = NULL;

/****************************************/

-- ΨһԼ�� UNIQUE
DROP TABLE dbo.T_Person;

CREATE TABLE T_Person
(
 FNumber VARCHAR(20) UNIQUE,  -- ΨһԼ��
 FName   VARCHAR(20),
 FAge    INT
);

INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '1' , 'kingchou', 20);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '2' , 'stef', 22);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '3' , 'long', 26);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '4' , 'yangzk', 27);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '5' , 'beansoft', 26);

INSERT INTO T_Person(FNumber, FName, FAge)
VALUES('2', 'kitty', 20);

DROP TABLE dbo.T_Person;

-- ����ΨһԼ��
CREATE TABLE T_Person
(
 FNumber			VARCHAR(20),
 FDepartmentNumber	VARCHAR(20),
 FName				VARCHAR(20),
 FAge				INT,
 UNIQUE(FNumber, FDepartmentNumber)
 --CONSTRAINT unic_dep_num UNIQUE(FNumber, FDepartmentNumber)  -- ���ø���ΨһԼ��
);

INSERT INTO T_Person (FNumber, FDepartmentNumber,FName, FAge)
VALUES ( '1' , 'dev001','kingchou', 20);
INSERT INTO T_Person (FNumber, FDepartmentNumber,FName, FAge)
VALUES ( '2' , 'dev001', 'stef', 22);
INSERT INTO T_Person (FNumber, FDepartmentNumber,FName, FAge)
VALUES ( '1' , 'sales001', 'long', 26);
INSERT INTO T_Person (FNumber, FDepartmentNumber,FName, FAge)
VALUES ( '2' , 'sales001', 'yangzk', 27);
INSERT INTO T_Person (FNumber, FDepartmentNumber,FName, FAge)
VALUES ( '3' , 'sales001', 'beansoft', 26);

INSERT INTO T_Person (FNumber, FDepartmentNumber,FName, FAge)
VALUES ( '2' , 'sales001', 'daxia', 30);

DROP TABLE dbo.T_Person;

CREATE TABLE T_Person
(
 FNumber			VARCHAR(20),
 FDepartmentNumber	VARCHAR(20),
 FName				VARCHAR(20),
 FAge				INT,

 -- ��Ӷ������Ψһ��Լ��
 CONSTRAINT unic_1 UNIQUE(FNumber, FDepartmentNumber),  
 CONSTRAINT unic_2 UNIQUE(FDepartmentNumber, FName)
);

-- ����µ�Լ��
ALTER TABLE T_Person ADD CONSTRAINT unic_3 UNIQUE(FName, FAge);

-- ɾ��Լ��
ALTER TABLE T_Person DROP CONSTRAINT unic_1;
ALTER TABLE T_Person DROP CONSTRAINT unic_2, unic_3;

DROP TABLE T_Person;


/***************************************/


-- CHECKԼ��
CREATE TABLE T_Person
(
 FNumber	VARCHAR(20),
 FName		VARCHAR(20)		CHECK(LEN(FName) > 12),  -- ��check��ʹ�ú���
 FAge		INT		CHECK(FAge > 0),  -- ���checkԼ��
 FWorkYear	INT		CHECK(FWorkYear > 0)		
);

INSERT INTO T_Person(FNumber, FName, FAge, FWorkYear)
VALUES('001', 'John', 25, -3);

DROP TABLE T_Person;

CREATE TABLE T_Person
(
 FNumber	VARCHAR(20),
 FName		VARCHAR(20),
 FAge		INT,	
 FWorkYear	INT		CHECK(FWorkYear < FAge)	--���ַ�ʽ�������������У�����	
);

CREATE TABLE T_Person1
(
 FNumber	VARCHAR(20),
 FName		VARCHAR(20),
 FAge		INT,	
 FWorkYear	INT,
 CHECK(FWorkYear < FAge)

 -- CONSTRAINT ck_1 CHECK(FWorkYear < FAge)  -- ��constraint�����������һ��
);

-- ��ALTER TABLE���checkԼ��
ALTER TABLE T_Person ADD CONSTRAINT ck_2 CHECK(FAge > 18);

ALTER TABLE T_Person DROP CONSTRAINT ck_1;
ALTER TABLE T_Person DROP CONSTRAINT ck_2;

DROP TABLE T_Person;

/***********************************/

-- ����Լ��

CREATE TABLE T_Person
(
 FNumber	VARCHAR(20)		PRIMARY KEY,  -- �������
 FName		VARCHAR(20),
 FAge		INT
);

INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '1' , 'kingchou', 20);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '2' , 'stef', 22);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '3' , 'long', 26);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '4' , 'yangzk', 27);
INSERT INTO T_Person (FNumber, FName, FAge)
VALUES ( '5' , 'beansoft', 26);

INSERT INTO T_Person(FNumber, FName, FAge)
VALUES('2', 'sunny', 22);

DROP TABLE T_Person;

CREATE TABLE T_Person
(
 FNumber	VARCHAR(20),
 FName		VARCHAR(20),
 FAge		INT,
 CONSTRAINT pk_1 PRIMARY KEY(FName, FNumber) -- ��������
);

ALTER TABLE T_Person DROP CONSTRAINT pk_1;   -- ɾ������

ALTER TABLE T_Person ADD CONSTRAINT pk_1 PRIMARY KEY(FNumber, FName);

DROP TABLE T_AUTHOR;

/******************************/

-- ���Լ��

CREATE TABLE T_AUTHOR
(
 FId	VARCHAR(20)		PRIMARY KEY,
 FName	VARCHAR(100),
 FAge	INT,
 FEmail VARCHAR(20)
);

CREATE TABLE T_Book
(
 FId		VARCHAR(20)		PRIMARY KEY,
 FName		VARCHAR(100),
 FPageCount	INT,
 FAuthorId  VARCHAR(20)	
);

INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('1','lily',20,'lily@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('2','kingchou',23,'kingchou@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('3','stef',28,'stef@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('4','long',26,'long@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('5','badboy',31,'badboy@cownew.com');

INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('1','About Java',300,'1');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('2','Inside Ruby',330,'2');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('3','Inside Curses',200,'5');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('4','Python InAction',450,'4');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('5','WPF Anywhere',250,'1');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('6','C# KickStart',280,'3');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('7','Compling',800,'1');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('8','Faster VB.Net',300,'5');

SELECT *
FROM dbo.T_AUTHOR;
SELECT *
FROM dbo.T_Book;

INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('9', 'About WinCE', 320, '9');

DELETE FROM dbo.T_AUTHOR
WHERE FAge > 30;

DROP TABLE T_AUTHOR;
DROP TABLE T_Book;

CREATE TABLE T_AUTHOR
(
 FId	VARCHAR(20)		PRIMARY KEY,
 FName  VARCHAR(100),
 FAge	INT,
 FEmail	VARCHAR(20)
);

CREATE TABLE T_Book
(
 FId	VARCHAR(20)		PRIMARY KEY,
 FName  VARCHAR(100),
 FPageCount		INT,
 FAuthorId		VARCHAR(20),
 FOREIGN KEY(FAuthorId) REFERENCES T_AUTHOR(FId)	-- ������Լ��
);

INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('1','lily',20,'lily@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('2','kingchou',23,'kingchou@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('3','stef',28,'stef@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('4','long',26,'long@cownew.com');
INSERT INTO T_AUTHOR(FId,FName,FAge,FEmail)
VALUES('5','badboy',31,'badboy@cownew.com');

INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('1','About Java',300,'1');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('2','Inside Ruby',330,'2');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('3','Inside Curses',200,'5');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('4','Python InAction',450,'4');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('5','WPF Anywhere',250,'1');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('6','C# KickStart',280,'3');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('7','Compling',800,'1');
INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('8','Faster VB.Net',300,'5');

SELECT *
FROM T_AUTHOR;
SELECT *
FROM T_Book;

INSERT INTO T_Book(FId,FName,FPageCount,FAuthorId)
VALUES('9','AboutWinCE',320,'9');         -- �����ڵ�������ܱ�����

DELETE FROM T_AUTHOR 
WHERE FName = 'badboy';  -- �����������ܱ�ɾ��

DELETE FROM T_Book 
WHERE FAuthorId = 5;

DELETE FROM T_Book 
WHERE FAuthorId = '1';

DELETE FROM T_AUTHOR 
WHERE FName = 'badboy';

ALTER TABLE T_Book DROP CONSTRAINT FK__T_Book__FAuthorI__37A5467C;

ALTER TABLE T_Book ADD CONSTRAINT FK_book_author
FOREIGN KEY(FAuthorId) REFERENCES T_AUTHOR(FId);


DROP TABLE T_AUTHOR;  -- ��ɾ��������ı�ǰ�޷�ɾ��

DROP TABLE T_Book;
DROP TABLE T_AUTHOR;

/****************************
 *    ���Լ�������ַ�ʽ      *
 ****************************/

-- 1. �ڶ�Ӧ��������ֱ�����
      FNumber VARCHAR(20) UNIQUE,  -- ΨһԼ��
	  FNumber VARCHAR(20) NOT NULL,  -- �ǿ�Լ��
	  FNumber VARCHAR(20) CHECK(FNumber > 2),  -- checkԼ��
	  FNumber VARCHAR(20) PRIMARY KEY,  -- ����Լ��
	  FAuthorId VARCHAR(20) REFERENCES T_AUTHOR(FId),  -- ���Լ��

-- 2. ��ȫ�����������ͳһ��ӣ�������Լ����
      UNIQUE(FNumber, FDepartmentNumber),
	  CHECK(FWorkYear < FAge),
	  PRIMARY KEY(FName, FNumber),
	  FOREIGN KEY(FAuthorId) REFERENCES T_AUTHOR(FId),

-- 3. ��ȫ�����������ͳһ��ӣ�ָ��Լ������
      CONSTRAINT uq_1 UNIQUE(FNumber, FDepartmentNumber),
	  CONSTRAINT ck_1 CHECK(FWorkYear < FAge),
	  CONSTRAINT pk_1 PRIMARY KEY(FName, FNumber),
	  CONSTRAINT fk_1 FOREIGN KEY(FAuthorId) REFERENCES T_AUTHOR(FId),

-- 4. ALTER TABLE���
      ALTER TABLE tablename ADD 
	  CONSTRAINT uq_1 UNIQUE(FNumber, FDepartmentNumber),
	  CONSTRAINT ck_1 CHECK(FWorkYear < FAge),
	  CONSTRAINT pk_1 PRIMARY KEY(FName, FNumber),
	  CONSTRAINT fk_1 FOREIGN KEY(FAuthorId) REFERENCES T_AUTHOR(FId),

-- 5. ɾ��Լ��
      ALTER TABLE ���� DROP CONSTRAINT Լ����