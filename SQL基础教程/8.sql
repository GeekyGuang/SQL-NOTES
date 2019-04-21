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
            THEN '商品种类 合计'
			ELSE product_type END as product_type,
	   CASE WHEN GROUPING(regist_date) = 1
	        THEN '登记日期 合计'
			ELSE cast(regist_date as varchar(16)) end as regist_date,
       sum(sale_price) as sum_price
from product
group by rollup(product_type, regist_date);

SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '商品种类 合计'
			ELSE product_type END as product_type,
	   CASE WHEN GROUPING(regist_date) = 1
	        THEN '登记日期 合计'

    -- CASE所有分支的返回类型必须一致，所以用cast转换
			ELSE cast(regist_date as varchar(16)) end as regist_date,
       sum(sale_price) as sum_price
from product
group by cube(product_type, regist_date)
order by product_type;


select product_id, product_name, sale_price,
       MAX(sale_price) over (order by product_id) as
	   current_max_price
from product;