1. 用Transact-SQL创建数据库
![](https://upload-images.jianshu.io/upload_images/2920775-0731452bce0ba54d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2. 查看数据库的存储路径
![右键属性](https://upload-images.jianshu.io/upload_images/2920775-2e628c449ff15ff4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. `sp_helpdb`命令查看所有数据库信息

4. 删除数据库
右键`删除`或使用命令
```
DROP DATABASE database_name
```
5. 视图、索引、存储过程、触发器概述
![](https://upload-images.jianshu.io/upload_images/2920775-16fa1e48b053f75f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6. 数据类型
- real是实数
- varchar(n) 中的n是存储字符最大长度

7. 自定义数据类型
![](https://upload-images.jianshu.io/upload_images/2920775-4fad6d9eee5429b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

8. 使用资源管理器修改表结构
![](https://upload-images.jianshu.io/upload_images/2920775-c4bd788546de591f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/2920775-218097c8a428c9f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
若无法保存修改
![](https://upload-images.jianshu.io/upload_images/2920775-a1ea2edb9e8dd44f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/2920775-cb225fa085068463.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

9. 使用SQL命令修改表结构
```
-- 新增字段
ALTER TABLE authors
ADD auth_note VARCHAR(100) NULL

-- 修改字段
ALTER TABLE authors
ALTER COLUMN auth_phone VARCHAR(15)
GO

-- 删除字段
ALTER TABLE authors
DROP COLUMN auth_phone
```

10. 标识符
![](https://upload-images.jianshu.io/upload_images/2920775-57d7e482d97d6c1f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/2920775-a07dbb13c9872fa3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
select @@VERSION AS 'SQL Server版本', @@SERVERNAME AS '服务器名称'
```
11. 局部变量
```
-- 声明局部变量
DECLARE @Name varchar(30), @Phone varchar(20), @Address char(2);

-- 用select赋值
DECLARE @MyCount INT
SELECT @MyCount = 10
SELECT @MyCount
GO

-- 用set赋值
DECLARE @rows int
SET @rows = (SELECT count(*) from member)
SELECT @rows
GO
```
> select 与set的区别：
> select可以一次给多个变量赋值，set一次只能给一个
> set赋值的是多个值的子查询会出错，select会选择最后一个赋值

12. **GO**命令：表示批处理的结束
   批处理若出错，则不会执行
```
USE test   -- 指明要操作的数据库
GO   
-- 一个批处理结束

select * from ...
update ...
...
GO
-- 第二个批处理结束

依次类推
```

13. PRINT输出用户自定义信息以及变量的字符串值
```
DECLARE @name VARCHAR(10) = '小明'  -- 这里DECLARE直接赋值
DECLARE @age INT = 21
PRINT '姓名  年龄'
PRINT @name + '   ' + CONVERT(VARCHAR(20), @age)

-- 若直接PRINT @age会报错，必须是字符串
```

14. 流程控制语句
14.1 BEGIN...END
> 用在while循环和IF...ELSE判断内，以包含多条语句

14.2 IF...ELSE
```
DECLARE @age int
SELECT @age = 10
IF @age < 30
  BEGIN
  PRINT 'HELLO'
  PRINT 'This is a young man!'
  END
ELSE 
  PRINT 'This is an old man!'
```

14.3 CASE 的两种用法
```
USE test_db
SELECT s_id, s_name,
-- 用法一
CASE s_name
  WHEN '马华' THEN '班长'
  WHEN '张三' THEN '学习委员'
  WHEN '李四' THEN '体育委员'
  ELSE '无'
END
AS '职位'
FROM stu_info
```
```
SELECT s_id, s_name, s_score,
-- 用法二
CASE 
  WHEN s_score > 90 THEN '优秀'
  WHEN s_score > 80 THEN '良好'
  WHEN s_score > 70 THEN '一般'
  WHEN s_score > 60 THEN '及格'
  ELSE '不及格'
END
AS '评价'
FROM stu_info
```

14.4 WHILE循环，注意CONTINUE和BREAK
```
DECLARE @num INT;
SELECT @num = 10;
WHILE @num > -1
BEGIN
  IF @num > 5
    BEGIN
	  PRINT '@num 等于' + CONVERT(VARCHAR(4), @num) + '大于5循环继续执行';
	  SELECT @num = @num - 1;
	  CONTINUE;  -- 结束本次循环，进入下一次循环
	END
  ELSE
    BEGIN
	  PRINT '@num 等于' + CONVERT(VARCHAR(4), @num);
	  BREAK;  -- 跳出整个循环
	END
END

PRINT '循环终止之后@num等于' + CONVERT(VARCHAR(4), @num);
```
14.5 GOTO
```
USE test_db;
BEGIN
SELECT s_name FROM stu_info;
GOTO jump            --跳转到jump标签
SELECT s_score FROM stu_info;
jump:                       --jump标签
PRINT '第二条SELECT语句没有执行';
END
```

14.6 WAITFOR延迟
```
DECLARE @name VARCHAR(50);
SET @name = 'admin';
BEGIN
WAITFOR DELAY '00:00:10';    -- 延迟10秒，标准格式
PRINT @name;
END;
```

14.7 RETURN 查询过程无条件退出
```
RETURN 0;  -- 0表示成功，1表示失败
```

15. CAST(x AS TYPE)和CONVERT(TYPE, x)数据类型转换
```
SELECT CAST('121231' AS DATE), CAST(100 AS CHAR(3)), CONVERT(TIME, '2012-05-01 12:11:10');
```
16. 存储过程
> 存储过程是可重复调用的批处理，系统存储过程在master数据库中，用户可以自定义存储过程

```
USE mytest;
GO
CREATE PROCEDURE SelProc  -- 创建查询member表的存储过程
AS
SELECT * FROM member;
GO
```
```
-- 调用存储过程
USE mytest;
GO
EXEC SelProc;
```
```
-- 创建带参数的存储过程
USE test;
GO
CREATE PROCEDURE QueryById @sID INT
AS
SELECT * FROM fruits WHERE s_id = @sID;
GO
```
```
-- 用两种方式调用带参数存储过程
USE test;
GO
EXECUTE QueryById 101;
EXECUTE QueryById @sID=101;  -- 多参数情况下好用
```
```
-- 创建带默认参数的存储过程
USE test;
GO
CREATE PROCEDURE QueryById @sID INT = 101
AS
SELECT * FROM fruits WHERE s_id = @sID;
GO
```
```
-- 创建带输出变量的存储过程
USE test;
GO
CREATE PROCEDURE QueryById3
@sID INT = 101,
@fruitscount INT OUTPUT  -- 输出变量
AS
SELECT @fruitscount=COUNT(fruits.s_id) FROM fruits WHERE s_id=@sID;
GO
```
```
-- 调用带输出参数的存储过程
USE test;
GO
DECLARE @fruitscount INT;
DECLARE @sID INT = 101;
EXEC QueryById3 @sID, @fruitscount OUTPUT
SELECT '该供应商一共提供了' + LTRIM(STR(@fruitscount)) + '种水果'
GO
```
> 用资源管理器可以执行、修改、删除存储过程

16. 函数
```
-- 标值函数，最后返回一个学生姓名
CREATE FUNCTION GetStuNameById(@stuid INT)
RETURN VARCHAR(30)
AS
BEGIN
DECLARE @stuName CHAR(30)
SELECT @stuName=(SELECT s_name FROM stu_info WHERE s_id = @stuid)
RETURN @stuName
END
```
```
-- 表值函数，返回的是一张表
CREATE FUNCTION getStuRecordBySex(@stuSex CHAR(2))
RETURNS TABLE
AS
RETURN
(
  SELECT s_id, s_name, s_sex, (s_score-10) AS newScore
  FROM stu_info
  WHERE s_sex = @stuSex
)

-- 调用表值函数
SELECT * FROM getStuRecordbySex('男');
```

17. 删除存储过程和函数

```
DROP PROCEDURE pName;
DROP FUNCTION fName;
```

