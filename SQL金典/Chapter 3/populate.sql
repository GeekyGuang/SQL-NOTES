-- ����T_Person
INSERT INTO T_Person(FName, FAge, FRemark)
VALUES('Tom', 18, 'USA');
INSERT INTO T_Person(FName,FAge,FRemark)
VALUES('Jim', 20, 'USA');
INSERT INTO T_Person(FName,FAge,FRemark)
VALUES('Lili', 22, 'China');
INSERT INTO T_Person(FName,FAge,FRemark)
VALUES('XiaoWang', 17, 'China');
INSERT INTO T_Person(FAge, FName, FRemark)
VALUES(21, 'Kimisushi', 'Korea');

INSERT INTO T_Person(FAge, FName) 
VALUES(22, 'LXF');

-- ���Ƽ��Ĳ��뷽ʽ
INSERT INTO T_Person
VALUES('luren1', 23, 'China');


-- ����T_Debt
INSERT INTO T_Debt(FNumber, FPerson)
VALUES('1', 'Jim'); -- �ǿձ���

INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('1', 200, 'Jim'); 

INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('2', 300, 'Jim');  

-- ���Լ��
INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('3', 100, 'Jerry'); -- Jerry������в�����

INSERT INTO T_Debt(FNumber, FAmount, FPerson)
VALUES('3', 100, 'Tom'); 

-- �������ݿ�
UPDATE T_Person
SET FRemark = 'SuperMan'; -- �����ж�������

UPDATE T_Person
SET FRemark = 'Sonic',
    FAge = 25;         -- ����һ�ű��еĶ����

UPDATE T_Person
SET FAge = 12
WHERE FName = 'Tom';  -- ��where����

UPDATE T_Person
SET FRemark = 'BlaBla'
WHERE FAge = 25;

UPDATE T_Person
SET FAge = 22
WHERE FName = 'jim' OR FName = 'LXF'; -- ʹ���߼������
-- ע�⣺Jimδ������

UPDATE T_Debt 
SET FAmount = NULL   -- �ǿ�Լ��
WHERE FPerson = 'TOM';

UPDATE T_Debt 
SET FAmount = 123
WHERE FPerson = 'Tom';

UPDATE T_Debt
SET FNumber = '2'
WHERE FPerson = 'Tom'; -- ������ͻ

UPDATE T_Debt
SET FNumber = '8'
WHERE FPerson = 'Tom'; 

UPDATE T_Debt 
SET FPerson = 'Merry'
WHERE FNumber = '1';     -- ��������ڣ�����

UPDATE T_Debt 
SET FPerson = 'Lili'
WHERE FNumber = '1';  



-- ����ɾ��, ������ɾ�����ݣ�����ɾ����

DELETE FROM T_Debt;  -- ��ɾ���
DELETE FROM T_Person;

/*
  UPDATE �Ǹ����У�DELETE��ɾ����
*/

INSERT INTO T_Person(FName,FAge,FRemark) VALUES('Jim',20,'USA');
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('Lili',22,'China') ;
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('XiaoWang',17,' China ') ;
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('Sam',16,'China') ;
INSERT INTO T_Person(FName,FAge,FRemark) VALUES('BlueFin',12,'Mars') ;

DELETE FROM T_Person
WHERE FAge > 20 OR FRemark = 'Mars';

-- ɾ�����ű�
DROP TABLE T_Debt, T_Person;  -- ���Էֿ�д

SELECT *
FROM T_Person;
