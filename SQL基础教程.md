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

18. 使用HAVING 子句时SELECT 语句的顺序
> SELECT → FROM → WHERE → GROUP BY → HAVING

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





