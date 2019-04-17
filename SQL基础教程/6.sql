DECLARE @m NUMERIC(4,2)
DECLARE @n INT
SET @m = 3.448
SET @n = 3
SELECT ROUND(@m, @n), '四舍五入'
union
SELECT LEN(@m % @n), '取余长度'

