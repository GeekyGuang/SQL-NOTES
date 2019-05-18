/*1. ���������*/
-- �����������������
SELECT c0.name,
       CASE WHEN c1.name IS NOT NULL THEN 'o' ELSE 'x' END AS 'SQL����',
	   CASE WHEN c2.name IS NOT NULL THEN 'o' ELSE 'x' END AS 'UNIX����',
	   CASE WHEN c3.name IS NOT NULL THEN 'o' ELSE 'x' END AS 'Java�м�'
FROM (SELECT DISTINCT name FROM courses) c0 
     LEFT JOIN (SELECT name FROM courses WHERE course='SQL����') c1
	 ON c0.NAME = c1.name
	 LEFT JOIN (SELECT name FROM courses WHERE course='UNIX����') c2 
	 ON c0.NAME = c2.name
	 LEFT JOIN (SELECT name FROM courses WHERE course='Java�м�') c3  
	 ON c0.NAME = c3.name


-- CASE���ʽ+�Ӳ�ѯ
SELECT c0.name,
       CASE WHEN c0.name IN (SELECT name FROM courses WHERE course = 'SQL����') 
	        THEN 'o' ELSE 'x' END AS 'SQL����',
	   CASE WHEN c0.name IN (SELECT name FROM courses WHERE course = 'UNIX����') 
	        THEN 'o' ELSE 'x' END AS 'UNIX����',
	   CASE WHEN c0.name IN (SELECT name FROM courses WHERE course = 'Java�м�') 
	        THEN 'o' ELSE 'x' END AS 'Java�м�'
FROM (SELECT DISTINCT name FROM courses) c0


-- ֻ��CASE���ʽ+�ۺϺ���
SELECT name,
       CASE WHEN SUM(CASE WHEN course='SQL����' THEN 1 ELSE 0 END) = 1
	        THEN 'o' ELSE 'x' END AS 'SQL����',
	   CASE WHEN SUM(CASE WHEN course='UNIX����' THEN 1 ELSE 0 END) = 1
	        THEN 'o' ELSE 'x' END AS 'UNIX����',
	   CASE WHEN SUM(CASE WHEN course='Java�м�' THEN 1 ELSE 0 END) = 1
	        THEN 'o' ELSE 'x' END AS 'Java�м�'
FROM courses 
GROUP BY name

/*2.�����ظ�����һ��*/
CREATE VIEW Children(child)
AS SELECT child_1 FROM Personnel
UNION
SELECT child_2 FROM Personnel
UNION
SELECT child_3 FROM Personnel;

SELECT emp.employee, children.child 
FROM personnel emp
     LEFT JOIN children
	 ON children.child IN (emp.child_1, emp.child_2, emp.child_3)  -- �ֱ������й�����IN


/*�����������Ƕ��ʽ�����*/
/* �ڽ����������Ƕ��ʽ����� */

