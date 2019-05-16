/***************************************************
 *                     三值逻辑                    *
 ***************************************************/

-- 对 NULL 使用比较谓词后得到的结果总是 unknown
-- 例如：1 = null, 2 <> null 得到的都是unknown 
-- NULL 既不是值也不是变量。NULL 只是一个表示“没有值”的标记，而比较谓词只适用于值。
-- “IS NULL” 这样的谓词是由两个单词构成的


-- 排中律在SQL不适用
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


-- NOT IN 和 NOT EXISTS不等价
SELECT * 
FROM  class_A
WHERE age NOT IN (SELECT age FROM class_B WHERE city = '东京')
-- NOT IN包含unknown结果为空

SELECT * 
  FROM class_A A
 WHERE NOT EXISTS(SELECT * 
                    FROM class_B B
				   WHERE A.age = B.age  -- 若B.age为null,结果为unknown
				     AND B.city = '东京')  --如果AND 运算里包含unknown，结果不会是true, 子查询不返回结果
-- 但子查询会返回存在的结果，也就是说 NOT EXISTS排除掉NULL

-- 极值函数（max()或min()）会当NULL值不存在，且当结果为空集时会返回NULL 
-- 除count()外的聚合函数也会返回NULL

/* 
01. NULL 不是值。
02. 因为 NULL 不是值，所以不能对其使用谓词。
03. 对 NULL 使用谓词后的结果是 unknown 。
04. unknown 参与到逻辑运算时，SQL 的运行会和预想的不一样。
05. 按步骤追踪 SQL 的执行过程能有效应对 4 中的情况。
*/
















