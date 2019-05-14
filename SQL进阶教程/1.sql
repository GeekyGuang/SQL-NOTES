SELECT CASE pref_name
            WHEN '����' THEN '�Ĺ�'
			WHEN '����' THEN '�Ĺ�'
			WHEN '�µ�' THEN '�Ĺ�'
			WHEN '����' THEN '����'
			WHEN '����' THEN '����'
			ELSE '����' END  AS district,
       SUM(population)
FROM PopTbl
GROUP BY CASE pref_name
            WHEN '����' THEN '�Ĺ�'
			WHEN '����' THEN '�Ĺ�'
			WHEN '�µ�' THEN '�Ĺ�'
			WHEN '����' THEN '����'
			WHEN '����' THEN '����'
			ELSE '����' END;  -- ���ﲻ��Ҫ����
			
-- WHEN������������
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


-- ��ת��,��case����ɸѡ
SELECT pref_name,
       SUM(CASE WHEN sex = '1' THEN population ELSE 0 END) AS '��',
	   SUM(CASE WHEN sex = '2' THEN population ELSE 0 END) AS 'Ů'
FROM PopTbl2
GROUP BY pref_name



-- UPDATE��ʹ��CASE
UPDATE salaries 
SET salary = CASE WHEN salary >= 300000 THEN salary * 0.9
                  WHEN salary >= 250000 AND salary < 280000 THEN salary * 1.2 
				  ELSE salary END;


-- ����CASE�滻�����е�����ֵ, �����Ҫ�õ��м���
UPDATE sometable 
SET p_key = CASE WHEN p_key = 'a' THEN 'b'
                 WHEN p_key = 'b' THEN 'a'
				 ELSE p_key END
WHERE p_key IN ('a','b')


-- ���ƥ��
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

-- ���ƥ���� EXISTS: ������ֶ�����һ�ű����ж�Ӧ��ֵ��ʱ��,��...
SELECT course_name,
       CASE WHEN EXISTS (SELECT course_id FROM OpenCourses oc
	                     WHERE month = '200706' 
						 AND cm.course_id = oc.course_id) THEN 'o'   -- ��Ҫ�������Ӳ�ѯ�������ŵ�,��ʵ�������ȷ
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

-- Case���ʽ��ʹ�þۺϺ���
SELECT std_id,
       CASE WHEN COUNT(*) = 1 THEN MAX(club_id)  -- ��Ϊʹ����GROUP BY,����Ҫ��MAX
	   ELSE MAX(CASE WHEN main_club_flg = 'Y' THEN club_id
	        ELSE NULL END)
	   END AS main_club
FROM StudentClub 
GROUP BY std_id


/*********************************************************
 *                        ��ϰ��                         *
 *********************************************************/
-- 1. 
SELECT keys,
       CASE WHEN x >= y THEN x ELSE y END AS greatest
FROM greatests

SELECT keys,
       CASE WHEN x >= y AND x >= z THEN x  -- ͬһ���еĲ�ͬ�жԱ�
	        WHEN y >= x AND y >= z THEN y 
			ELSE z END AS greatest 
FROM greatests

SELECT keys,
       CASE WHEN CASE WHEN x > y THEN x ELSE y END < z THEN z  -- ��CASE���ʽ��ֵ�Ա�
	        ELSE CASE WHEN x > y THEN x ELSE y END 
			END AS greatest
FROM greatests

-- �����������3�����Ƚ�ÿһ�в�ѯ��ͬһ�к���MAX()����
SELECT keys, MAX(col) AS greatest
FROM (SELECT keys, x AS col FROM greatests 
      UNION ALL 
	  SELECT keys, y AS col FROM greatests
	  UNION ALL 
	  SELECT keys, z AS col FROM greatests) TMP
GROUP BY keys

-- 2.
SELECT CASE WHEN sex = 1 THEN '��' 
            WHEN sex = 2 THEN 'Ů'
			ELSE NULL END AS '�Ա�',
	   SUM(population) AS 'ȫ��',
	   SUM(CASE WHEN pref_name = '�µ�' THEN population ELSE 0 END) AS '�µ�',
	   SUM(CASE WHEN pref_name = '�㴨' THEN population ELSE 0 END) AS '�㴨',
	   SUM(CASE WHEN pref_name = '����' THEN population ELSE 0 END) AS '����',
	   SUM(CASE WHEN pref_name = '��֪' THEN population ELSE 0 END) AS '��֪',
	   SUM(CASE WHEN pref_name IN ('�µ�','�㴨','����','��֪') THEN population ELSE 0 END) AS '�Ĺ�'
FROM poptbl2
GROUP BY sex  -- �ȷ��飬���ڷ����ڰ�������ֵ


-- 3.
SELECT *
FROM greatests 
ORDER BY CASE WHEN keys = 'B' THEN 1    -- ��ORDER BY����CASE�ı�����˳��
              WHEN keys = 'A' THEN 2
			  WHEN keys = 'D' THEN 3
			  WHEN keys = 'C' THEN 4
		 ELSE NULL END






