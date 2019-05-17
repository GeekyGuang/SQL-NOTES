/******************************************
 *           HAVING子句的力量             *
 ******************************************/
-- 面向集合语言的第二个特性——以集合为单位进行操作
/*
SQL 通过不断生成子集来求得目标集合。SQL 不像面向过程语
言那样通过画流程图来思考问题，而是通过画集合的关系图来思
考。
WHERE 子句用来调查集合元素的性质，而 HAVING 子句用来调查
集合本身的性质。
*/

SELECT '存在缺失的编号' AS gap
  FROM SeqTbl 
HAVING COUNT(*) <> MAX(seq)
-- HAVING不需要和GROUP BY一起使用

SELECT MIN(seq + 1) AS gap
  FROM seqtbl
 WHERE (seq + 1) NOT IN (SELECT seq FROM seqtbl)

SELECT income, COUNT(*) AS cnt
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= ALL (SELECT COUNT(*)   -- 拿掉ALL是不行的
                          FROM Graduates
                         GROUP BY income)

-- 当ALL里有NULL时, 会出问题，改用极值函数
SELECT income, COUNT(*) AS cnt
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= (SELECT MAX(cnt) 
                      FROM(SELECT COUNT(*) AS cnt 
                             FROM Graduates
                            GROUP BY income) tmp)

-- 查询不包含NULL的集合
SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = COUNT(sbmt_date)  -- 前者包含NULL,后者不包含

SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date IS NULL THEN 0 ELSE 1 END) -- 用SUM()函数和CASE表达式实现COUNT()

-- 购物篮分析
-- 表一：items 
-- 表二：shopitems

-- 求表二中包含表一商品的店铺
SELECT SI.shop
FROM shopitems SI, items I
WHERE SI.item = I.item
GROUP BY SI.shop 
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM items)

-- 在上一题的基础上去除有多余商品的店铺
SELECT SI.shop
  FROM shopitems SI LEFT JOIN items I 
    ON SI.item = I.item 
 GROUP BY SI.shop 
HAVING COUNT(SI.item) = COUNT(I.item) 
   AND COUNT(I.item) = (SELECT COUNT(item) FROM items)

-- 或者
SELECT SI.shop
  FROM shopitems SI LEFT JOIN items I 
    ON SI.item = I.item 
 GROUP BY SI.shop 
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM items)
   AND COUNT(I.item) = (SELECT COUNT(item) FROM items)


SELECT 
FROM seqtbl 





