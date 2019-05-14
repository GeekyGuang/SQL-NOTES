/************************************************************************
 *                1-2 自连接的用法                                      *
 * 面向集合语言 SQL 以集合的方式来描述世界                              *
 * 无论表还是视图，本质上都是集合——集合是 SQL 能处理的唯一的数据结构  *
 ************************************************************************/
 -- 有序对<1,2> != <2,1> 排列
 -- 无序对{1,2} = {2,1} 组合
 -- 关联子查询: 拿着一张表里的数据到另一张表里查符合关联条件的数据
 -- 自连接: 看成两张相同的表
 -- SELECT逗号分隔的字段之间自动满足匹配对应关系
 -- 自连接与连接方式无关，内联结、外连接、交叉连接都可以是自连接
 -- 自连接的性能开销更大，应尽量给用于连接的列建立索引

 



 -- 用 "非等值自连接" 获得同一列元素的不同组合
 -- 交叉连接得到笛卡尔积有序对
 SELECT p1.name AS name_1, p2.name AS name_2
 FROM products p1, products p2      -- 笛卡尔积 3*3对
 -- WHERE p1.name <> p2.name  -- 去除相同元素组成的对 3*2对
 WHERE p1.name > p2.name  -- 去除顺序不同的对（按字符顺序对比） 3对

 -- 获取3个元素的组合
 SELECT p1.name AS name_1, p2.name AS name_2, p3.name AS name_3
 FROM products p1, products p2, products p3
 WHERE p1.name > p2.name AND p2.name > p3.name 


 -- 去除重复的行
 /* 
DELETE FROM products p1
WHERE EXISTS (SELECT * FROM products p2 
              WHERE p1.name = p2.name 
			    AND p1.price = p2.price 
				AND p1.rowid < p2.rowid)    -- 只有oracle才支持rowid
*/


-- 查找局部不一致的列
-- 用关联子查询
SELECT *
FROM addresses a1
WHERE EXISTS (SELECT * FROM addresses a2 
              WHERE a1.family_id = a2.family_id
			  AND a1.address <> a2.address)

-- 用非等值自连接
SELECT DISTINCT a1.name, a1.address  -- 当有2个以上的则要DISTINCT
FROM addresses a1, addresses a2
WHERE a1.family_id = a2.family_id 
      AND a1.address <> a2.address


-- 排序，MySQL不支持RANK()和DENSE_RANK()开窗函数
-- 用关联子查询实现RANK()
SELECT p1.name,
       p1.price,
	   (SELECT COUNT(p2.price)
	   FROM products p2
	   WHERE p2.price > p1.price) + 1 AS rank_1  -- 这里是降序排序
FROM products p1

SELECT p1.name,
       p1.price,
	   (SELECT COUNT(DISTINCT p2.price)    -- 加上DISTINCT就实现了DENSE_RANK()
	   FROM products p2
	   WHERE p2.price > p1.price) + 1 AS rank_1 
FROM products p1


-- 用自连接实现
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
 *                           练习题                                *
 *******************************************************************/
 -- 1.
SELECT p1.name AS name_1,
       p2.name AS name_2
  FROM products p1, products p2
--WHERE p1.name > p2.name OR p1.name = p2.name    -- 得到的结果数为 (1 + 2 + ... + n)
 WHERE p1.name >= p2.name
-- 2. 
-- 用开窗函数
SELECT district, name, price, 
       RANK() OVER(PARTITION BY district ORDER BY price)
  FROM DistrictProducts

-- 用自连接
SELECT dp1.district,
       dp1.name,
	   dp1.price,
	   COUNT(dp2.price) + 1 AS rank_1,
	   COUNT(DISTINCT dp2.price) + 1 AS rank_2
  FROM DistrictProducts dp1 LEFT JOIN DistrictProducts dp2
    ON dp1.district = dp2.district 
   AND dp1.price < dp2.price
 GROUP BY dp1.district, dp1.name, dp1.price

-- 用标量子查询
SELECT dp1.district,
       dp1.name,
	   dp1.price,
	   (SELECT COUNT(dp2.price)       -- 标量子查询只返回一个值，所以可以放在select
	      FROM DistrictProducts dp2
		 WHERE dp1.district = dp2.district 
		   AND dp1.price < dp2.price) + 1 AS rank_1,
	   (SELECT COUNT(DISTINCT dp2.price)
	      FROM DistrictProducts dp2
		 WHERE dp1.district = dp2.district 
		   AND dp1.price < dp2.price) + 1 AS rank_2
  FROM DistrictProducts dp1


-- 3.
UPDATE DistrictProducts2 p1     -- SQL Server不支持这样写
SET ranking = (SELECT COUNT(p2.price) + 1
                 FROM DistrictProducts2 p2
			    WHERE p1.district = p2.district 
			      AND p1.price < p2.price)















 