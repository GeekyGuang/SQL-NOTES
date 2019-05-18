/******************************************
 *           HAVING�Ӿ������             *
 ******************************************/
-- ���򼯺����Եĵڶ������ԡ����Լ���Ϊ��λ���в���
/*
SQL ͨ�����������Ӽ������Ŀ�꼯�ϡ�SQL �������������
������ͨ��������ͼ��˼�����⣬����ͨ�������ϵĹ�ϵͼ��˼
����
WHERE �Ӿ��������鼯��Ԫ�ص����ʣ��� HAVING �Ӿ���������
���ϱ�������ʡ�
*/

SELECT '����ȱʧ�ı��' AS gap
  FROM SeqTbl 
HAVING COUNT(*) <> MAX(seq)
-- HAVING����Ҫ��GROUP BYһ��ʹ��

SELECT MIN(seq + 1) AS gap
  FROM seqtbl
 WHERE (seq + 1) NOT IN (SELECT seq FROM seqtbl)

SELECT income, COUNT(*) AS cnt
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= ALL (SELECT COUNT(*)   -- �õ�ALL�ǲ��е�
                          FROM Graduates
                         GROUP BY income)

-- ��ALL����NULLʱ, ������⣬���ü�ֵ����
SELECT income, COUNT(*) AS cnt
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= (SELECT MAX(cnt) 
                      FROM(SELECT COUNT(*) AS cnt 
                             FROM Graduates
                            GROUP BY income) tmp)

-- ��ѯ������NULL�ļ���
SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = COUNT(sbmt_date)  -- ǰ�߰���NULL,���߲�����

SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date IS NULL THEN 0 ELSE 1 END) -- ��SUM()������CASE���ʽʵ��COUNT()

-- ����������
-- ��һ��items 
-- �����shopitems

-- �����а�����һ��Ʒ�ĵ���
SELECT SI.shop
FROM shopitems SI, items I
WHERE SI.item = I.item
GROUP BY SI.shop 
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM items)

-- ����һ��Ļ�����ȥ���ж�����Ʒ�ĵ���
SELECT SI.shop
  FROM shopitems SI LEFT JOIN items I 
    ON SI.item = I.item 
 GROUP BY SI.shop 
HAVING COUNT(SI.item) = COUNT(I.item) 
   AND COUNT(I.item) = (SELECT COUNT(item) FROM items)

-- ����
SELECT SI.shop
  FROM shopitems SI LEFT JOIN items I 
    ON SI.item = I.item 
 GROUP BY SI.shop 
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM items)
   AND COUNT(I.item) = (SELECT COUNT(item) FROM items)


SELECT '����ȱʧ�ı��' AS gap 
  FROM seqtbl 
HAVING COUNT(*) <> MAX(seq) 
UNION ALL 
SELECT '������ȱʧ�ı��' AS gap 
  FROM seqtbl 
HAVING COUNT(*) = MAX(seq)


SELECT CASE WHEN COUNT(*) <> MAX(seq) 
            THEN '����ȱʧ�ı��'
			ELSE '������ȱʧ�ı��' END AS gap 
FROM seqtbl

SELECT dpt 
  FROM students 
GROUP BY dpt 
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date BETWEEN '2005-09-01' AND '2005-09-30' THEN 1 ELSE 0 END)

SELECT SI.shop,
       COUNT(SI.item) AS my_item_cnt,
	   (SELECT COUNT(item) FROM Items) -COUNT(SI.item) AS diff_cnt
FROM shopItems SI, Items I
WHERE SI.item = I.item 
GROUP BY SI.shop

