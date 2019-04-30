1. 非等值自连接
```
SELECT p1.name AS name1, p2.name AS name2, p3.name AS name3
FROM products p1, products p2, products p3
WHERE p1.name > p2.name AND p2.name > p3.name
```
```
-- 找出局部不一致的列
SELECT DINSTINCT A1.name, A1.address
FROM Addresses AS A1, Addresses AS A2
WHERE A1.family_id = A2.family_id 
  AND A1.address <> A2.address
```
