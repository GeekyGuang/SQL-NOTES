DECLARE @m NUMERIC(4,2)
DECLARE @n INT
SET @m = 3.448
SET @n = 3
SELECT ROUND(@m, @n), '��������'
union
SELECT LEN(@m % @n), 'ȡ�೤��'

