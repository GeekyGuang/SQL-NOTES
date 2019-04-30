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






