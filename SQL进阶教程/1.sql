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














