-- SQL Retail Sales Analysis --

--Creating Table--
create table retail_sales
(
	transactions_id	INT primary key,
	sale_date DATE,	
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(20),
	quantity INT,
	price_per_unit	FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)

SELECT COUNT(*) from retail_sales;

--DATA CLEANING--

SELECT * FROM retail_sales WHERE transactions_id is NULL;
SELECT * FROM retail_sales WHERE sale_date is NULL;
SELECT * FROM retail_sales WHERE sale_time is NULL;
SELECT * FROM retail_sales 
WHERE 
	transactions_id is NULL 
	or
	sale_date is NULL
	or
	sale_time is NULL
	or 
	gender is NULL
	or 
	category is NULL
	or 
	quantity is NULL
	or 
	cogs is NULL
	or 
	total_sale is NULL;
		;


DELETE FROM retail_sales
WHERE 
	transactions_id is NULL 
	or
	sale_date is NULL
	or
	sale_time is NULL
	or 
	gender is NULL
	or 
	category is NULL
	or 
	quantity is NULL
	or 
	cogs is NULL
	or 
	total_sale is NULL;
		;

--DATA EXPLORATION

--HOW MANY SALES WE HAD
select count(*) as total_sale from retail_sales

--HOW MANY CUSTOMERS WE HAVE
select count(DISTINCT customer_id) as total_sale from retail_sales

--DISTINCT CATEGORIES
select DISTINCT category from retail_sales

--DATA ANALYSIS AND BUSINESS KEY PROBLEMS
SELECT * FROM retail_sales where sale_date = '2022-11-05';

SELECT * from retail_sales where category='Clothing' 
and
to_char(sale_date,'YYYY-MM') = '2022-11'
and quantity >= 4


--TOTAL SALES FOR EACH CATEGORY -- 
select category, sum(total_sale) as net_sale, count(*) as total_orders  from retail_sales group by 1;

--AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM BEAUTY CATEGORY
select ROUND(avg(age),2) as avg_age from retail_sales where category='Beauty'

-- TOTAL SALE GREATER THAN 1000
select * from retail_sales where total_sale>1000

-- GENDER WISE TRANSACTIONS
select category, gender,COUNT(*) as total_trans
from retail_sales group by 1,2 order by 1;

--AVERAGE SALE EACH MONTH
SELECT year,month,avg_sale FROM (
	select extract(year from sale_date) as year,
	extract(month from sale_date) as month,AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	from retail_sales
	group by 1,2 
	) 
	as t1 where rank = 1

--TOP 5 CUSTOMERS
select customer_id,sum(total_sale)as total_sale
from retail_sales group by 1
order by 2 desc limit 5


--Unique Customers from Each category
select category,count(distinct customer_id) as cnt_unique_customers
from retail_sales group by 1

-- Orders received by shift
WITH hourly_sale AS (
    SELECT *,
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
            ELSE 'EVENING'
        END as shift
    FROM retail_sales
)

select shift, COUNT(*) as total_orders from hourly_sale
GROUP BY 1



