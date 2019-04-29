1. 关系数据库以行为单位读写数据。
2. 一个单元格中只能输入一个数据。
3. SQL 根据功能不同可以分为三类，其中使用最多的是DML。
  3.1 DDL（Data Definition Language，数据定义语言）
  CREATE： 创建数据库和表等对象
  DROP： 删除数据库和表等对象
  ALTER： 修改数据库和表等对象的结构
  3.2 DML（Data Manipulation Language，数据操纵语言）
  SELECT：查询表中的数据
  INSERT：向表中插入新数据
  UPDATE：更新表中的数据
  DELETE：删除表中的数据
  3.3 DCL（Data Control Language，数据控制语言）
  COMMIT： 确认对数据库中的数据进行的变更
  ROLLBACK： 取消对数据库中的数据进行的变更
  GRANT： 赋予用户操作权限
  REVOKE： 取消用户的操作权限
4. SQL 语句以分号（;）结尾。
5. 关键字不区分大小写。
● 关键字大写
● 表名的首字母大写
● 其余（列名等）小写

6. 字符串和日期常数需要使用单引号（'）括起来。
   数字常数无需加注单引号（直接书写数字即可）。
7. 单词之间需要使用半角空格或者换行符进行分隔。

8. 创建数据库shop
```
CREATE DATABASE shop;  -- 相当于右键创建表
```

9. 变更表名：
```
sp_rename 'Poduct', 'Product';
```

10. 给表添加一列
```
-- ALTER TABLE 表名 ADD 列定义;
 ALTER TABLE AddressBook ADD postal_code CHAR(8) NOT NULL;
```

11. 删除一列
```
-- ALTER TABLE <表名> DROP COLUMN <列名>；
 ALTER TABLE AddressBook DROP COLUMN postal_code;
```

12. 中文表别名不需要加引号
```
SELECT product_id	AS 商品编号, -- SQL Server中别名不需要引号
  FROM product;
```
13. 使用DISTINCT可以删除重复行，NULL也被视为一类数据。
```
-- 对多列组合去重，DISTINCT只需写一个在第一列之前
SELECT DISTINCT product_type, regist_date
FROM Product;
```

14. 字符串类型的数据原则上按照字典顺序进行排序，不能与数字的大小顺序混淆。
> 1
> 10
> 11
> 2
> 222
> 3

15. 函数：输入某个值就能输出相应结果的盒子
> COUNT函数的结果根据参数的不同而不同。COUNT(*)会得到包含NULL的数据
行数，而COUNT(<列名>)会得到NULL之外的数据行数。
> 聚合函数会将NULL排除在外。但COUNT(*)例外，并不会排除NULL。
> MAX/MIN函数几乎适用于所有数据类型的列。SUM/AVG函数只适用于数值类型的列。

16. DISTINCT和聚合函数
```
SELECT COUNT(DISTINCT product_type) -- sum, avg等都可用
FROM Product;
```

17. GROUP BY 和WHERE 并用时SELECT 语句的执行顺序
> FROM → WHERE → GROUP BY → SELECT
使用GROUP BY子句时，SELECT子句中不能出现聚合键之外的列名。
GROUP BY必须有其确定的意义

> 使用GROUP BY往往是因为要使用聚合函数

18. 使用HAVING 子句时SELECT 语句的顺序
> SELECT → FROM → WHERE → GROUP BY → HAVING

> HAVING是以聚合函数为筛选条件

19. 
> WHERE 子句 = 指定行所对应的条件
> HAVING 子句 = 指定组所对应的条件
> 将条件写在WHERE 子句
中要比写在HAVING 子句中的处理速度更快，返回结果所需的时间更短。

20. 在ORDER BY子句中可以使用SELECT子句中定义的别名。
使用HAVING 子句时SELECT 语句的顺序
> FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
```
SELECT product_id AS id, product_name, sale_price AS sp, purchase
_price
FROM Product
ORDER BY sp, id;  -- 对多个列先后顺序排序
```

21. INSERT省略一列未赋值，若未设定默认值，则会插入null。
> 显示方式插入默认值 insert into xx values(.., DEFAULT, ..); --用default关键字

22. INSERT INTO ... SELECT复制查询的数据插入到另一张表
```
-- 将商品表中的数据复制到商品复制表中
INSERT INTO ProductCopy (product_id, product_name, product_type, 
sale_price, purchase_price, regist_date)
SELECT product_id, product_name, product_type, sale_price, 
purchase_price, regist_date
FROM Product;
```
> 复制表时有可能违反主键约束

```
SELECT XXX INTO XXX FROM XXX
-- 把查询复制到一张新表，有#前缀的是临时表 
```

23. DELETE
```
DELETE FROM <表名>
WHERE <条件>;

-- TRUNCATE <表名>; 只能用来清空一张表，速度更快
```

24. UPDATE
```
UPDATE <表名>
SET <列名> = <表达式>
WHERE <条件>;

-- UPDATE多列
-- 使用逗号对列进行分隔排列
UPDATE Product
SET sale_price = sale_price * 10,
purchase_price = purchase_price / 2
WHERE product_type = '厨房用具';
```

```
UPDATE ProductMargin 
SET sale_price = 3000,
    margin = sale_price - purchase_price  -- 这里的sale_price不会被改成3000，必须分开UPDATE
WHERE product_name = '菜刀';
```

25. 事务：以一系列DML语句为一个单元，有开始和结束
```
事务开始语句（BEGIN TRANSACTION）;
DML语句①;
DML语句②;
DML语句③;
.. .
事务结束语句（COMMIT或者ROLLBACK）;
```
 
 > SQL Server是自动提交模式，每一条语句都是一个事务，若没有BEGIN TRANSACTION，则无法ROLLBACK。

 ```
 BEGIN TRANSACTION;  -- 先执行事务开始语句，后面的语句可以逐条执行
  
  UPDATE Product 
  SET sale_price = sale_price - 100
  WHERE product_name ='菜刀';

-- COMMIT; --如果COMMIT了就不能ROLLBACK
ROLLBACK;  -- 不论BEGIN后执行了多少语句，ROLLBACK都会回到BEGIN开始前
 ```

 ```
 -- 设置保留点 SAVE TRANSACTION <名字>
 -- 回滚 ROLLBACK TRANSACTION <名字>
BEGIN TRANSACTION; 
  
  UPDATE Product 
  SET sale_price = sale_price - 100
  WHERE product_name ='菜刀';

  SAVE TRANSACTION one;  -- 设置保留点

  UPDATE Product 
  SET sale_price = sale_price - 100
  WHERE product_name ='打孔器';

-- ROLLBACK必须指明保留点，不然会回退到BEGIN
ROLLBACK TRANSACTION one; 
 ```

 26. 视图是虚拟的表，存储的是SELECT语句， 应该将经常使用的SELECT语句做成视图。
```
-- 视图的列名可以省略
CREATE VIEW 视图名称(<视图列名1>, <视图列名2>, ……)
AS
<SELECT语句>
```
```
-- 列名一一对应，就像创建一张表
CREATE VIEW ProductSum (product_type, cnt_product) 
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;
```
> 看见代码，在心里模拟敲一遍才能记住细节

```
-- 删除视图
DROP VIEW ProductSum;
```

27. 子查询
> 一言以蔽之，子查询就是一张一次性视图（SELECT语句）。与视图不同，子查询在SELECT语句执行完毕之后就会消失。

> 子查询就是将用来定义视图的SELECT语句直接用于FROM子句当中

```
SELECT product_type, cnt_product
FROM (SELECT product_type, COUNT(*) AS cnt_product
      FROM Product
	  GROUP BY product_type) AS ProdcutSum;  -- 子查询必须定义别名，AS可省略
```

```
-- 执行顺序
-- ① 首先执行FROM 子句中的SELECT 语句（子查询）
SELECT product_type, COUNT(*) AS cnt_product
FROM Product
GROUP BY product_type;
-- ② 根据①的结果执行外层的SELECT 语句
SELECT product_type, cnt_product
FROM ProductSum;
```

28. 标量子查询：即返回单一值的子查询。
```
-- WHERE子句不能使用聚合函数，可以使用标量子查询
SELECT *
FROM Product
WHERE sale_price > (SELECT AVG(sale_price) 
                      FROM Product);
```
29. 关联子查询: 在细分的组内进行比较时，需要使用关联子查询。
```
SELECT product_type, product_name, sale_price
FROM Product p1
WHERE sale_price > (SELECT AVG(sale_price)
                    FROM product p2
					WHERE p1.product_type = p2.product_type  -- 指定比较分组
					GROUP BY product_type)
```
> 先进行GROUP BY分组，后用WHERE创建关联

```
CREATE VIEW AvgPriceByType
AS
SELECT product_id, product_name, product_type, sale_price,
		(SELECT AVG(sale_price)
		 FROM product AS p2
		 WHERE p1.product_type = p2.product_type
		 GROUP BY product_type) AS avg_sale_price
FROM product AS p1;
```
30. COALESCE
```
SELECT COALESCE(NULL, 'HELLO', NULL);  -- 合并
```
```
-- 若是NULL,则替换为'不确定'
SELECT COALESCE(SP.shop_id,'不确定')AS shop_id, 
       COALESCE(SP.shop_name, '不确定') AS shop_name, 
	   P.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
     ON SP.product_id = P.product_id
ORDER BY shop_id;
```

31. EXISTS
> EXIST 只关心记录是否存在，因此返回哪些列都没
有关系。
```
SELECT product_name, sale_price
FROM Product AS P 
WHERE EXISTS (SELECT *
              FROM ShopProduct AS SP 
              WHERE SP.shop_id = '000C'
              AND SP.product_id = P.product_id);
```

32. CASE表达式
```
-- 搜索CASE表达式
CASE WHEN <求值表达式> THEN <表达式>
WHEN <求值表达式> THEN <表达式>
WHEN <求值表达式> THEN <表达式>
.. .
ELSE <表达式>
END

-- 简单CASE表达式
CASE <表达式>
WHEN <表达式> THEN <表达式>
WHEN <表达式> THEN <表达式>
WHEN <表达式> THEN <表达式>
.. .
ELSE <表达式>
END
```

```
-- 对按照商品种类计算出的销售单价合计值进行行列转换
SELECT SUM(CASE WHEN product_type = '衣服'
           THEN sale_price ELSE 0 END) AS sum_price_clothes,
       SUM(CASE WHEN product_type = '厨房用具'
           THEN sale_price ELSE 0 END) AS sum_price_kitchen,
       SUM(CASE WHEN product_type = '办公用品'
           THEN sale_price ELSE 0 END) AS sum_price_office
FROM Product;
```

```
-- 统计在某价格区间的个数
SELECT SUM(CASE WHEN sale_price <= 1000 THEN 1 else 0 end) AS low_price,
       SUM(CASE WHEN sale_price BETWEEN 1001 AND 3000 THEN 1 else 0 end) AS mid_price,
	   SUM(CASE WHEN sale_price > 3000 THEN 1 else 0 end) AS high_price
FROM product;
```
> 在对SELECT 语句的结果进行编辑时，CASE 表达式能够发挥较大
作用。


33. 集合运算
> 1. UNION: 并集，去除重复项
> 2. UNION ALL: 并集，包含重复项
> 3. INTERSECT: 交集
> 4. EXCEPT: 减去另一结果中有的

> 集合运算的特征就是以行方向为单位进行操作。通俗地说，就是进行这些集合
运算时，会导致记录行数的增减。

34. 联结（JOIN）运算，简单来说，就是将其他表中的列添加过来，进行“添加列”的运算。
34.1 INNER JOIN
> 进行内联结时必须使用ON子句，并且要书写在FROM和WHERE之间
```
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP INNER JOIN Product AS P
     ON SP.product_id = P.product_id
ORDER BY P.product_name;
```
```
-- 三张表的联结
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, 
       IP.inventory_quantity, IP.inventory_id
FROM ShopProduct AS SP INNER JOIN Product AS P
     ON SP.product_id = P.product_id
	 INNER JOIN InventoryProduct AS IP
	 ON SP.product_id = IP.product_id;
```
34.2 LEFT/RIGHT OUTER JOIN
> 用LEFT或RIGHT指定主表，对应项为NULL的也显示
```
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
     ON SP.product_id = P.product_id
```

34.3 CROSS JOIN（笛卡尔积）
> 交叉联结是所有联结的基础，但是不会实际用到
```
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP CROSS JOIN Product AS P
```

34.4 过时的语法
```
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, 
P.sale_price
FROM ShopProduct SP, Product P
WHERE SP.product_id = P.product_id
AND SP.shop_id = '000A';
```

35. 窗口函数
> 通过 PARTITION BY 分组后的记录集合称为“窗口”。实指“范围”

> 原则上窗口函数只能在 SELECT 子句中使用。

```
● RANK 函数
计算排序时，如果存在相同位次的记录，则会跳过之后的位次。
例）有 3 条记录排在第 1 位时：1 位、1 位、1 位、4 位……
● DENSE_RANK 函数
同样是计算排序，即使存在相同位次的记录，也不会跳过之后的位次。
例）有 3 条记录排在第 1 位时：1 位、1 位、1 位、2 位……
● ROW_NUMBER 函数
赋予唯一的连续位次。
例）有 3 条记录排在第 1 位时：1 位、2 位、3 位、4 位……
```
> 学会使用ORDER BY是关键
```
SELECT product_name, product_type, sale_price,
RANK () OVER (PARTITION BY product_type
              ORDER BY sale_price) AS ranking  -- RANK()必须有ORDER BY
FROM Product;
```
```
SELECT product_name, product_type, sale_price,
       RANK () OVER (ORDER BY sale_price) AS ranking,
       DENSE_RANK () OVER (ORDER BY sale_price) AS dense_ranking,
       ROW_NUMBER () OVER (ORDER BY sale_price) AS row_num
FROM Product;
```

```
select product_id, product_name, sale_price,
       -- 如果没有ORDER BY则会计算全部总价，有则计算到自己为止的总价
       sum(sale_price) over(ORDER BY product_id) as current_sum
from product;
```

- 框架 following 和 preceding
```
SELECT product_id, product_name, sale_price,
       AVG (sale_price) OVER (ORDER BY product_id
                              ROWS BETWEEN 1 PRECEDING AND 
                                   1 FOLLOWING) AS moving_avg
FROM Product;
```

- 两个order by
```
SELECT product_name, product_type, sale_price,
       RANK () OVER (ORDER BY sale_price) AS ranking
       FROM Product
       ORDER BY ranking;
```
> 代码一定要自己敲一遍，自己动手改动才会真的理解

36. GROUPING
- ROLLUP
```
select product_type, sum(sale_price) as sum_price
from product
group by rollup(product_type);

-- 一次计算出不同聚合组合的结果
```

```
-- 用GROUPING函数表示超级分组记录，是则为1，否则为0
SELECT GROUPING(product_type) AS product_type, 
       GROUPING(regist_date) AS regist_date, sum(sale_price) as sum_price
from product
group by rollup(product_type, regist_date);
```

```
-- 替换1和0
SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '商品种类 合计'
			ELSE product_type END as product_type,
	   CASE WHEN GROUPING(regist_date) = 1
	        THEN '登记日期 合计'

    -- CASE所有分支的返回类型必须一致，所以用cast转换
			ELSE cast(regist_date as varchar(16)) end as regist_date,
       sum(sale_price) as sum_price
from product
group by rollup(product_type, regist_date);
```
- CUBE: 返回所有可能组合的结果
- GROUPING SETS: 返回个别条件对应的结果，































