SELECT CASE pref_name
            WHEN '爱媛' THEN '四国'
			WHEN '长崎' THEN '四国'
			WHEN '德岛' THEN '四国'
			WHEN '东京' THEN '九州'
			WHEN '福冈' THEN '九州'
			ELSE '其他' END  AS district,
       SUM(population)
FROM PopTbl
GROUP BY CASE pref_name
            WHEN '爱媛' THEN '四国'
			WHEN '长崎' THEN '四国'
			WHEN '德岛' THEN '四国'
			WHEN '东京' THEN '九州'
			WHEN '福冈' THEN '九州'
			ELSE '其他' END;  -- 这里不需要别名
			
-- WHEN条件的排他性
SELECT CASE WHEN population < 100 THEN '01'
            WHEN population < 200 THEN '02'
			WHEN population < 300 THEN '03'
			ELSE '04' END AS pop_class,
	   COUNT(*)
FROM PopTbl
GROUP BY CASE WHEN population < 100 THEN '01'
            WHEN population < 200 THEN '02'
			WHEN population < 300 THEN '03'
			ELSE '04' END


-- 行转列,用case条件筛选
SELECT pref_name,
       SUM(CASE WHEN sex = '1' THEN population ELSE 0 END) AS '男',
	   SUM(CASE WHEN sex = '2' THEN population ELSE 0 END) AS '女'
FROM PopTbl2
GROUP BY pref_name



-- UPDATE中使用CASE
UPDATE salaries 
SET salary = CASE WHEN salary >= 300000 THEN salary * 0.9
                  WHEN salary >= 250000 AND salary < 280000 THEN salary * 1.2 
				  ELSE salary END;


-- 利用CASE替换主键中的两个值, 否则就要用到中间量
UPDATE sometable 
SET p_key = CASE WHEN p_key = 'a' THEN 'b'
                 WHEN p_key = 'b' THEN 'a'
				 ELSE p_key END
WHERE p_key IN ('a','b')





-- 表的匹配
SELECT course_name,
       CASE WHEN course_id IN (SELECT course_id FROM opencourses
	                           WHERE month = '200706') THEN 'o'
							   ELSE 'x' END AS June,
	   CASE WHEN course_id IN (SELECT course_id FROM opencourses
	                           WHERE month = '200707') THEN 'o'
							   ELSE 'x' END AS July,
	   CASE WHEN course_id IN (SELECT course_id FROM opencourses
	                           WHERE month = '200708') THEN 'o'
							   ELSE 'x' END AS Auguest
FROM coursemaster;

-- 表的匹配用 EXISTS
SELECT course_name,
       CASE WHEN EXISTS (SELECT course_id FROM OpenCourses oc
	                     WHERE month = '200706' 
						 AND cm.course_id = oc.course_id) THEN 'o'   -- 不要被关联子查询的名字吓到,其实含义很明确
			ELSE 'x' END AS June,
       CASE WHEN EXISTS (SELECT course_id FROM OpenCourses oc
	                     WHERE month = '200707' 
						 AND cm.course_id = oc.course_id) THEN 'o'
			ELSE 'x' END AS July,
       CASE WHEN EXISTS (SELECT course_id FROM OpenCourses oc
	                     WHERE month = '200708' 
						 AND cm.course_id = oc.course_id) THEN 'o'
			ELSE 'x' END AS Auguest
FROM coursemaster cm







