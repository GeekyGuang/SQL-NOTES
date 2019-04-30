1. CASE表达式
```
SELECT CASE pref_name 
       WHEN '爱媛' THEN '四国'  -- 注意WHEN之间没有逗号
	   WHEN '高知' THEN '四国'
	   WHEN '香川' THEN '四国'
	   WHEN '德岛' THEN '四国'
	   WHEN '福冈' THEN '九州'
	   WHEN '佐贺' THEN '九州'
	   WHEN '长崎' THEN '九州'  
	   ELSE '其他' END
       AS district,
	   SUM(population)
FROM dbo.PopTbl
GROUP BY CASE pref_name        -- GROUP BY里用CASE分组
       WHEN '爱媛' THEN '四国'
	   WHEN '高知' THEN '四国'
	   WHEN '香川' THEN '四国'
	   WHEN '德岛' THEN '四国'
	   WHEN '福冈' THEN '九州'
	   WHEN '佐贺' THEN '九州'
	   WHEN '长崎' THEN '九州'
	   ELSE '其他' END;
```

```
-- 行列转换
SELECT pref_name,
       SUM(CASE WHEN sex='1' THEN population ELSE 0 END) AS 男,
	   SUM(CASE WHEN sex='2' THEN population ELSE 0 END) AS 女
FROM dbo.PopTbl2
GROUP BY pref_name;
```

```
-- CHECK约束
CONSTRAINT check_salary CHECK
  ( CASE WHEN sex = '2'
         THEN CASE WHEN salary <= 200000
         THEN 1 ELSE 0 END
    ELSE 1 END = 1 )
```

```
-- 在update中使用case条件
-- 若用多条update..when语句，则后面的update会把前面的覆盖掉
UPDATE Salaries 
SET salary = CASE WHEN salary >= 300000 THEN salary * 0.9
                  WHEN salary >= 250000 AND salary < 280000 THEN salary * 1.2
				  ELSE salary END;
```
```
-- 用于主键或唯一键值的互换
UPDATE SomeTable
SET p_key = CASE WHEN p_key = 'a' THEN 'b'
                 WHEN p_key = 'b' THEN 'a'
				 ELSE p_key END
WHERE p_key IN ('a', 'b'); -- 限定范围，加快速度
```

```
-- 表与表之间数据匹配
SELECT course_name,
       CASE WHEN course_id IN (SELECT course_id FROM OpenCourses 
				      WHERE month = '200706') THEN 'o' 
			ELSE 'x' END AS '6月',
	   CASE WHEN course_id IN (SELECT course_id FROM OpenCourses 
				      WHERE month = '200707') THEN 'o' 
			ELSE 'x' END AS '7月',
	   CASE WHEN course_id IN (SELECT course_id FROM OpenCourses 
				      WHERE month = '200708') THEN 'o' 
			ELSE 'x' END AS '8月'
FROM CourseMaster
-- 用EXISTS比IN更快
SELECT cm.course_name,
       CASE WHEN EXISTS (SELECT course_id FROM OpenCourses oc 
	                     WHERE month = '200706' AND cm.course_id = oc.course_id) 
	        THEN 'o' ELSE 'x' END AS '6月',
       CASE WHEN EXISTS (SELECT course_id FROM OpenCourses oc 
	                     WHERE month = '200707' AND cm.course_id = oc.course_id) 
	        THEN 'o' ELSE 'x' END AS '7月',
       CASE WHEN EXISTS (SELECT course_id FROM OpenCourses oc 
	                     WHERE month = '200708' AND cm.course_id = oc.course_id) 
	        THEN 'o' ELSE 'x' END AS '8月'
FROM CourseMaster AS cm
```

```
-- CASE表达式中使用聚合函数
SELECT std_id, MAX(club_id)
FROM StudentClub
GROUP BY std_id
HAVING COUNT(*) = 1
UNION ALL 
SELECT std_id, club_id
FROM StudentClub
WHERE main_club_flg = 'Y'
ORDER BY std_id

SELECT std_id, 
       CASE WHEN COUNT(*) = 1 THEN MAX(club_id)
	        ELSE MAX(CASE WHEN main_club_flg = 'Y' THEN club_id
	                 ELSE NULL END) 
	   END AS main_club
FROM StudentClub
GROUP BY std_id 
```
```
-- CASE是表达式，其值可以作为条件
-- 比较两个值
SELECT keys,
       CASE WHEN x > y THEN x 
	        ELSE y END AS greatest
FROM Greatests
-- 比较三个值
SELECT keys,
       CASE WHEN (CASE WHEN x > y THEN x ELSE y END) < z THEN z 
	        ELSE (CASE WHEN x > y THEN x ELSE y END) END
			AS greatest
FROM Greatests
```
```
SELECT CASE WHEN sex = '1' THEN '男'
            WHEN sex = '2' THEN '女'
	   ELSE NULL END AS 性别,
	   SUM(population) AS 全国,
	   SUM(CASE WHEN pref_name = '爱媛' THEN population ELSE 0 END) AS 爱媛,
	   SUM(CASE WHEN pref_name = '德岛' THEN population ELSE 0 END) AS 德岛,
	   SUM(CASE WHEN pref_name = '香川' THEN population ELSE 0 END) AS 香川,
	   SUM(CASE WHEN pref_name = '高知' THEN population ELSE 0 END) AS 高知,
	   SUM(CASE WHEN pref_name IN ('爱媛','德岛','香川','高知') THEN population ELSE 0 END) AS 四国
FROM PopTbl2					   
GROUP BY sex
```
```
-- 在ORDER BY中使用case表达式指定排列顺序
SELECT keys 
FROM Greatests
ORDER BY CASE 
           WHEN keys = 'B' THEN 1
           WHEN keys = 'A' THEN 2
			     WHEN keys = 'D' THEN 3
			     WHEN keys = 'C' THEN 4
			     ELSE NULL END;
```






