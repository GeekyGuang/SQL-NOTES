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

-- 表的匹配用 EXISTS: 当这个字段在另一张表里有对应的值的时候,则...
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

-- Case表达式内使用聚合函数
SELECT std_id,
       CASE WHEN COUNT(*) = 1 THEN MAX(club_id)  -- 因为使用了GROUP BY,所以要用MAX
	   ELSE MAX(CASE WHEN main_club_flg = 'Y' THEN club_id
	        ELSE NULL END)
	   END AS main_club
FROM StudentClub 
GROUP BY std_id


/*********************************************************
 *                        练习题                         *
 *********************************************************/
-- 1. 
SELECT keys,
       CASE WHEN x >= y THEN x ELSE y END AS greatest
FROM greatests

SELECT keys,
       CASE WHEN x >= y AND x >= z THEN x  -- 同一行中的不同列对比
	        WHEN y >= x AND y >= z THEN y 
			ELSE z END AS greatest 
FROM greatests

SELECT keys,
       CASE WHEN CASE WHEN x > y THEN x ELSE y END < z THEN z  -- 将CASE表达式的值对比
	        ELSE CASE WHEN x > y THEN x ELSE y END 
			END AS greatest
FROM greatests

-- 如果列数大于3个，先将每一列查询到同一列后用MAX()函数
SELECT keys, MAX(col) AS greatest
FROM (SELECT keys, x AS col FROM greatests 
      UNION ALL 
	  SELECT keys, y AS col FROM greatests
	  UNION ALL 
	  SELECT keys, z AS col FROM greatests) TMP
GROUP BY keys

-- 2.
SELECT CASE WHEN sex = 1 THEN '男' 
            WHEN sex = 2 THEN '女'
			ELSE NULL END AS '性别',
	   SUM(population) AS '全国',
	   SUM(CASE WHEN pref_name = '德岛' THEN population ELSE 0 END) AS '德岛',
	   SUM(CASE WHEN pref_name = '香川' THEN population ELSE 0 END) AS '香川',
	   SUM(CASE WHEN pref_name = '爱媛' THEN population ELSE 0 END) AS '爱媛',
	   SUM(CASE WHEN pref_name = '高知' THEN population ELSE 0 END) AS '高知',
	   SUM(CASE WHEN pref_name IN ('德岛','香川','爱媛','高知') THEN population ELSE 0 END) AS '四国'
FROM poptbl2
GROUP BY sex  -- 先分组，再在分组内按条件求值


-- 3.
SELECT *
FROM greatests 
ORDER BY CASE WHEN keys = 'B' THEN 1    -- 在ORDER BY内用CASE改变排序顺序
              WHEN keys = 'A' THEN 2
			  WHEN keys = 'D' THEN 3
			  WHEN keys = 'C' THEN 4
		 ELSE NULL END






