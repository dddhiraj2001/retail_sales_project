Retail Sales Analysis SQL Project
Project Overview
Project Title: Retail Sales Analysis

In this project, I focused on demonstrating my SQL skills and techniques to explore, clean, and analyze retail sales data. The project involved setting up a retail sales database, conducting exploratory data analysis (EDA), and answering specific business questions through SQL queries.

Objectives
Database Setup: I established a retail sales database and populated it with the provided sales data.
Data Cleaning: I identified and removed records with missing or null values.
Exploratory Data Analysis (EDA): I conducted exploratory analysis to gain a deeper understanding of the dataset.
Business Analysis: I used SQL queries to answer specific business questions and extract valuable insights from the sales data.
Project Structure
1. Database Setup
Database Creation: I started by creating a database named retail_sales.
Table Creation: I created a table named retail_sales to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
CREATE DATABASE retail_sales;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,    
    sale_time TIME,
    customer_id INT,    
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,    
    cogs FLOAT,
    total_sale FLOAT
);
2. Data Exploration & Cleaning
Record Count: I determined the total number of records in the dataset.
Customer Count: I identified the number of unique customers in the dataset.
Category Count: I listed all unique product categories in the dataset.
Null Value Check: I checked for any null values and removed the records containing them.
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
3. Data Analysis & Insights
I developed the following SQL queries to answer specific business questions:

Retrieve all sales made on '2022-11-05':
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

Retrieve all transactions in November 2022 where the category is 'Clothing' and the quantity sold exceeds 4:
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
Calculate total sales (total_sale) for each category:
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
Find the average age of customers who purchased items from the 'Beauty' category:
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

Retrieve transactions where the total_sale exceeds 1000:
SELECT * FROM retail_sales
WHERE total_sale > 1000

Calculate the total number of transactions by each gender for each category:
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

Calculate the average sales for each month and identify the best-selling month each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

Identify the top 5 customers based on the highest total sales:
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

Count the number of unique customers who purchased items from each category:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

Classify sales into shifts (Morning <12, Afternoon 12-17, Evening >17) and count the number of orders for each shift:
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping to identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.
Reports
Sales Summary: I created a detailed report summarizing total sales, customer demographics, and category performance.
Trend Analysis: I provided insights into sales trends across different months and shifts.
Customer Insights: I compiled reports on top customers and unique customer counts per category.
Conclusion
Through this project, I gained hands-on experience with SQL, covering database setup, data cleaning, exploratory data analysis, and developing business-focused SQL queries. The insights I derived from this analysis can help guide business decisions by understanding sales patterns, customer behavior, and product performance.
