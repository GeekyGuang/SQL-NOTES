CREATE TABLE Product
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id));

-- DML ����������
BEGIN TRANSACTION;
INSERT INTO Product VALUES ('0001', 'T����', '�·�',
1000, 500, '2009-09-20');
INSERT INTO Product VALUES ('0002', '�����', '�칫��Ʒ',
500, 320, '2009-09-11');
INSERT INTO Product VALUES ('0003', '�˶�T��', '�·�',
4000, 2800, NULL);
INSERT INTO Product VALUES ('0004', '�˵�', '�����þ�',
3000, 2800, '2009-09-20');
INSERT INTO Product VALUES ('0005', '��ѹ��', '�����þ�',
6800, 5000, '2009-01-15');
INSERT INTO Product VALUES ('0006', '����', '�����þ�',
500, NULL, '2009-09-20');
INSERT INTO Product VALUES ('0007', '���˰�', '�����þ�',
880, 790, '2008-04-28');
INSERT INTO Product VALUES ('0008', 'Բ���', '�칫��Ʒ',
100, NULL,'2009-11-11');
COMMIT;


/* ��һ�� ��ϰ */

-- ������
CREATE TABLE AddressBook
(regist_no		INT		NOT NULL,
 name			VARCHAR(128)		NOT NULL,
 address		VARCHAR(256)		NOT NULL,
 tel_no		CHAR(10),
 mail_address  CHAR(20),
 PRIMARY KEY(regist_no));

 -- ����һ��, ע�ⲻ�� ADD COLUMN
 ALTER TABLE AddressBook ADD postal_code CHAR(8) NOT NULL;

 -- ɾ��һ��
 ALTER TABLE AddressBook DROP COLUMN postal_code;

 -- ɾ����
 DROP TABLE dbo.AddressBook;

-- ��λָ�ɾ���ı�?
-- ɾ����ı��޷�ʹ��������лָ�
