CREATE DATABASE Project_one;

DROP TABLE IF EXISTS Retail_Sales;
CREATE TABLE Retail_Sales
(
Transactions_id INT PRIMARY KEY,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category  VARCHAR(25),
quantiy	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale FLOAT
);

SELECT *
FROM retail_sales
;

SELECT
COUNT(*)
FROM 
retail_sales;


-- datacleaning

SELECT *
FROM retail_sales
WHERE 
Transactions_id IS NULL
 OR
 sale_date IS NULL
 OR
 sale_time IS NULL
 OR
 customer_id IS NULL
 OR
gender IS NULL
 OR
 age IS NULL
 OR
 category IS NULL
 OR
 quantiy IS NULL
 OR
 price_per_unit IS NULL
 OR
 cogs IS NULL
 OR
 total_sale IS NULL
 ; 
 
 SELECT * FROM retail_sales;
 
  SELECT COUNT(*)AS Total_sales FROM retail_sales;
-- How many Unique customers we have
SELECT COUNT(DISTINCT customer_id)AS Total_sales FROM retail_sales;
-- How many categories we have
SELECT COUNT(DISTINCT category)AS categories FROM retail_sales;
-- query to retrive all columns for sales made on 2022-11-05
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
-- QUERY to retrieve all the transaction that the category is clothing and quantity sold is more than 2 in NOV 2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing' AND quantiy > 2 AND TO_CHAR (sale_date, 'YYYY-MM') = '2022-11';

--  query to calculate total sales for each category
SELECT category, sum(total_sale) AS Net_sales, COUNT(*) AS Total_orders
FROM retail_sales
GROUP BY category;

-- A QUERY to find the average age of customers who purchased items from the beauty category
SELECT category,ROUND(avg(age),2)
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

-- query to find all transactions where total sale > 1000
SELECT*
FROM retail_sales
WHERE total_sale > 1000;

-- Write a query to find the number of each transaction(transaction_id) made by each gender in each category
SELECT COUNT(Transactions_id),category,gender
FROM retail_sales
GROUP BY Category, gender
ORDER BY category;

-- query to calculate the average sale for each month, find out the best selling month in each year(SUBQUERY)
SELECT* FROM
(
SELECT 
EXTRACT( YEAR FROM sale_date) AS YEAR,
EXTRACT( MONTH FROM sale_date) AS MONTH,
ROUND(AVG(total_sale),2) AS AVG_SALES,
RANK()OVER(PARTITION BY EXTRACT( YEAR FROM sale_date)ORDER BY ROUND(AVG(total_sale),2)DESC) AS ranks
FROM retail_sales
GROUP BY 1,2
) AS T1
WHERE ranks = 1;
-- ORDER BY 1,3 DESC

-- query to find the top 5 customers based on the highest total sales
SELECT customer_id,sum(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY sum(total_sale) DESC
LIMIT 5;

-- Query to find the number of unique customers who purchased items from each category
SELECT COUNT(DISTINCT customer_id), category
FROM retail_sales
GROUP BY category;

-- Query to create each shift and nurmber of orders (example morning <=12,afternoon between 12 and 17 ,evening >17(CTE)
WITH Hourly_sale
AS
(
SELECT*,
CASE 
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
WHEN EXTRACT(HOUR FROM sale_time) >17 THEN 'EVENING'
END AS SHIFT
FROM retail_sales 
)
SELECT
COUNT(*),SHIFT
FROM Hourly_sale
GROUP BY SHIFT

-- End of Project






 
 
