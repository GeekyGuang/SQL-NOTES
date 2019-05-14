/************************************************************************
 *                1-2 �����ӵ��÷�                                      *
 * ���򼯺����� SQL �Լ��ϵķ�ʽ����������                              *
 * ���۱�����ͼ�������϶��Ǽ��ϡ��������� SQL �ܴ����Ψһ�����ݽṹ  *
 ************************************************************************/
 -- �����<1,2> != <2,1> ����
 -- �����{1,2} = {2,1} ���
 -- �����Ӳ�ѯ: ����һ�ű�������ݵ���һ�ű������Ϲ�������������
 -- ������: ����������ͬ�ı�
 -- SELECT���ŷָ����ֶ�֮���Զ�����ƥ���Ӧ��ϵ
 -- �����������ӷ�ʽ�޹أ������ᡢ�����ӡ��������Ӷ�������������
 -- �����ӵ����ܿ�������Ӧ�������������ӵ��н�������

 



 -- �� "�ǵ�ֵ������" ���ͬһ��Ԫ�صĲ�ͬ���
 -- �������ӵõ��ѿ����������
 SELECT p1.name AS name_1, p2.name AS name_2
 FROM products p1, products p2      -- �ѿ����� 3*3��
 -- WHERE p1.name <> p2.name  -- ȥ����ͬԪ����ɵĶ� 3*2��
 WHERE p1.name > p2.name  -- ȥ��˳��ͬ�Ķԣ����ַ�˳��Աȣ� 3��

 -- ��ȡ3��Ԫ�ص����
 SELECT p1.name AS name_1, p2.name AS name_2, p3.name AS name_3
 FROM products p1, products p2, products p3
 WHERE p1.name > p2.name AND p2.name > p3.name 


 -- ȥ���ظ�����
 /* 
DELETE FROM products p1
WHERE EXISTS (SELECT * FROM products p2 
              WHERE p1.name = p2.name 
			    AND p1.price = p2.price 
				AND p1.rowid < p2.rowid)    -- ֻ��oracle��֧��rowid
*/


-- ���Ҿֲ���һ�µ���
-- �ù����Ӳ�ѯ
SELECT *
FROM addresses a1
WHERE EXISTS (SELECT * FROM addresses a2 
              WHERE a1.family_id = a2.family_id
			  AND a1.address <> a2.address)

-- �÷ǵ�ֵ������
SELECT DISTINCT a1.name, a1.address  -- ����2�����ϵ���ҪDISTINCT
FROM addresses a1, addresses a2
WHERE a1.family_id = a2.family_id 
      AND a1.address <> a2.address


-- ����MySQL��֧��RANK()��DENSE_RANK()��������
-- �ù����Ӳ�ѯʵ��RANK()
SELECT p1.name,
       p1.price,
	   (SELECT COUNT(p2.price)
	   FROM products p2
	   WHERE p2.price > p1.price) + 1 AS rank_1  -- �����ǽ�������
FROM products p1

SELECT p1.name,
       p1.price,
	   (SELECT COUNT(DISTINCT p2.price)    -- ����DISTINCT��ʵ����DENSE_RANK()
	   FROM products p2
	   WHERE p2.price > p1.price) + 1 AS rank_1 
FROM products p1


-- ��������ʵ��
SELECT p1.name,
       MAX(p1.price) AS price,
	   COUNT(p2.price) + 1 AS rank_1
  FROM products p1 LEFT OUTER JOIN products p2
    ON p1.price < p2.price
GROUP BY p1.name

SELECT p1.name,
       MAX(p1.price) AS price,
	   COUNT(DISTINCT p2.price) + 1 AS rank_1
  FROM products p1 LEFT OUTER JOIN products p2
    ON p1.price < p2.price
GROUP BY p1.name


/*******************************************************************
 *                           ��ϰ��                                *
 *******************************************************************/
 -- 1.
SELECT p1.name AS name_1,
       p2.name AS name_2
  FROM products p1, products p2
--WHERE p1.name > p2.name OR p1.name = p2.name    -- �õ��Ľ����Ϊ (1 + 2 + ... + n)
 WHERE p1.name >= p2.name
-- 2. 
-- �ÿ�������
SELECT district, name, price, 
       RANK() OVER(PARTITION BY district ORDER BY price)
  FROM DistrictProducts

-- ��������
SELECT dp1.district,
       dp1.name,
	   dp1.price,
	   COUNT(dp2.price) + 1 AS rank_1,
	   COUNT(DISTINCT dp2.price) + 1 AS rank_2
  FROM DistrictProducts dp1 LEFT JOIN DistrictProducts dp2
    ON dp1.district = dp2.district 
   AND dp1.price < dp2.price
 GROUP BY dp1.district, dp1.name, dp1.price

-- �ñ����Ӳ�ѯ
SELECT dp1.district,
       dp1.name,
	   dp1.price,
	   (SELECT COUNT(dp2.price)       -- �����Ӳ�ѯֻ����һ��ֵ�����Կ��Է���select
	      FROM DistrictProducts dp2
		 WHERE dp1.district = dp2.district 
		   AND dp1.price < dp2.price) + 1 AS rank_1,
	   (SELECT COUNT(DISTINCT dp2.price)
	      FROM DistrictProducts dp2
		 WHERE dp1.district = dp2.district 
		   AND dp1.price < dp2.price) + 1 AS rank_2
  FROM DistrictProducts dp1


-- 3.
UPDATE DistrictProducts2 p1     -- SQL Server��֧������д
SET ranking = (SELECT COUNT(p2.price) + 1
                 FROM DistrictProducts2 p2
			    WHERE p1.district = p2.district 
			      AND p1.price < p2.price)















 