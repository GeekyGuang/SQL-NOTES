-- 用外连接制作交叉表
SELECT c0.name,
       CASE WHEN c1.name IS NOT NULL THEN 'o' ELSE 'x' END AS 'SQL入门',
	   CASE WHEN c2.name IS NOT NULL THEN 'o' ELSE 'x' END AS 'UNIX基础',
	   CASE WHEN c3.name IS NOT NULL THEN 'o' ELSE 'x' END AS 'Java中级'
FROM (SELECT DISTINCT name FROM courses) c0 
     LEFT JOIN (SELECT name FROM courses WHERE course='SQL入门') c1
	 ON c0.NAME = c1.name
	 LEFT JOIN (SELECT name FROM courses WHERE course='UNIX基础') c2 
	 ON c0.NAME = c2.name
	 LEFT JOIN (SELECT name FROM courses WHERE course='Java中级') c3  
	 ON c0.NAME = c3.name


-- CASE表达式+子查询
SELECT c0.name,
       CASE WHEN c0.name IN (SELECT name FROM courses WHERE course = 'SQL入门') THEN 'o' ELSE 'x' END AS 'SQL入门',
	   CASE WHEN c0.name IN (SELECT name FROM courses WHERE course = 'UNIX基础') THEN 'o' ELSE 'x' END AS 'UNIX基础',
	   CASE WHEN c0.name IN (SELECT name FROM courses WHERE course = 'Java中级') THEN 'o' ELSE 'x' END AS 'Java中级'
FROM (SELECT DISTINCT name FROM courses) c0


-- 只用CASE表达式+聚合函数
SELECT name,
       CASE WHEN SUM(CASE WHEN course='SQL入门' THEN 1 ELSE 0 END) = 1
	        THEN 'o' ELSE 'x' END AS 'SQL入门',
	   CASE WHEN SUM(CASE WHEN course='UNIX基础' THEN 1 ELSE 0 END) = 1
	        THEN 'o' ELSE 'x' END AS 'UNIX基础',
	   CASE WHEN SUM(CASE WHEN course='Java中级' THEN 1 ELSE 0 END) = 1
	        THEN 'o' ELSE 'x' END AS 'Java中级'
FROM courses 
GROUP BY name