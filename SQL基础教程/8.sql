select product_type, sum(sale_price) as sum_price
from product
group by rollup(product_type);

SELECT product_type, regist_date, sum(sale_price) as sum_price
from product
group by product_type, regist_date;

SELECT product_type, regist_date, sum(sale_price) as sum_price
from product
group by rollup(product_type, regist_date);

SELECT GROUPING(product_type) AS product_type, 
       GROUPING(regist_date) AS regist_date, sum(sale_price) as sum_price
from product
group by rollup(product_type, regist_date);

SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '��Ʒ���� �ϼ�'
			ELSE product_type END as product_type,
	   CASE WHEN GROUPING(regist_date) = 1
	        THEN '�Ǽ����� �ϼ�'
			ELSE cast(regist_date as varchar(16)) end as regist_date,
       sum(sale_price) as sum_price
from product
group by rollup(product_type, regist_date);

SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '��Ʒ���� �ϼ�'
			ELSE product_type END as product_type,
	   CASE WHEN GROUPING(regist_date) = 1
	        THEN '�Ǽ����� �ϼ�'

    -- CASE���з�֧�ķ������ͱ���һ�£�������castת��
			ELSE cast(regist_date as varchar(16)) end as regist_date,
       sum(sale_price) as sum_price
from product
group by cube(product_type, regist_date)
order by product_type;


select product_id, product_name, sale_price,
       MAX(sale_price) over (order by product_id) as
	   current_max_price
from product;