/***************************************************
 *                     ��ֵ�߼�                    *
 ***************************************************/

-- �� NULL ʹ�ñȽ�ν�ʺ�õ��Ľ������ unknown
-- ���磺1 = null, 2 <> null �õ��Ķ���unknown 
-- NULL �Ȳ���ֵҲ���Ǳ�����NULL ֻ��һ����ʾ��û��ֵ���ı�ǣ����Ƚ�ν��ֻ������ֵ��
-- ��IS NULL�� ������ν�������������ʹ��ɵ�


-- ��������SQL������
/* 
SELECT *
FROM products 
WHERE price <> NULL   -- unknown
   OR price = NULL    -- unknown
*/

SELECT *
  FROM products
 WHERE price = 30 
    OR price <> 30
    OR price IS NULL;


-- NOT IN �� NOT EXISTS���ȼ�
SELECT * 
FROM  class_A
WHERE age NOT IN (SELECT age FROM class_B WHERE city = '����')
-- NOT IN����unknown���Ϊ��

SELECT * 
  FROM class_A A
 WHERE NOT EXISTS(SELECT * 
                    FROM class_B B
				   WHERE A.age = B.age  -- ��B.ageΪnull,���Ϊunknown
				     AND B.city = '����')  --���AND ���������unknown�����������true, �Ӳ�ѯ�����ؽ��
-- ���Ӳ�ѯ�᷵�ش��ڵĽ����Ҳ����˵ NOT EXISTS�ų���NULL

-- ��ֵ������max()��min()���ᵱNULLֵ�����ڣ��ҵ����Ϊ�ռ�ʱ�᷵��NULL 
-- ��count()��ľۺϺ���Ҳ�᷵��NULL

/* 
01. NULL ����ֵ��
02. ��Ϊ NULL ����ֵ�����Բ��ܶ���ʹ��ν�ʡ�
03. �� NULL ʹ��ν�ʺ�Ľ���� unknown ��
04. unknown ���뵽�߼�����ʱ��SQL �����л��Ԥ��Ĳ�һ����
05. ������׷�� SQL ��ִ�й�������ЧӦ�� 4 �е������
*/
















