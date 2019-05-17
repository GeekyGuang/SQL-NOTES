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


SELECT 
FROM seqtbl 





