# 📊 Retail Sales Analysis (SQL Project)

## 🧾 Project Overview
This project focuses on analyzing retail sales data using SQL. It demonstrates essential data analysis skills including database creation, data cleaning, exploratory data analysis (EDA), and solving business-related questions.

It is designed for beginners who want to build a strong foundation in SQL for data analysis.

---

## 🎯 Objectives
- Create and set up a retail sales database  
- Clean and validate the dataset  
- Perform exploratory data analysis (EDA)  
- Answer key business questions using SQL  

---

## 🗂️ Database Setup

### Create Database and Table
```sql
CREATE DATABASE Project_one;

DROP TABLE IF EXISTS Retail_Sales;

CREATE TABLE Retail_Sales
(
    Transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(25),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```
🔍 Data Exploration
View Dataset
```sql
Total Records
SELECT COUNT(*) FROM retail_sales;
```
Total Sales Count
```sql
SELECT COUNT(*) AS Total_sales FROM retail_sales;
```
Unique Customers
```sql
SELECT COUNT(DISTINCT customer_id) AS Total_customers 
FROM retail_sales;
Unique Categories
SELECT COUNT(DISTINCT category) AS categories 
FROM retail_sales;
```
🧹 Data Cleaning
Check for Null Values
```sql
SELECT *
FROM retail_sales
WHERE 
    Transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
```
📈 Data Analysis & Business Questions
1. Sales on a Specific Date
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
2. Clothing Transactions (Nov 2022, Quantity > 2)
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing' 
AND quantiy > 2 
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```
3. Total Sales by Category
```sql
SELECT 
    category, 
    SUM(total_sale) AS Net_sales, 
    COUNT(*) AS Total_orders
FROM retail_sales
GROUP BY category;
```
4. Average Age (Beauty Category
```sql
SELECT 
    category,
    ROUND(AVG(age), 2)
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;
```
6. High-Value Transactions (>1000)
``` sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```
7. Transactions by Gender & Category
```sql
SELECT 
    COUNT(Transactions_id),
    category,
    gender
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

8. Best Selling Month Each Year
```sql
SELECT * 
FROM
(
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS YEAR,
        EXTRACT(MONTH FROM sale_date) AS MONTH,
        ROUND(AVG(total_sale), 2) AS AVG_SALES,
        RANK() OVER(
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY ROUND(AVG(total_sale), 2) DESC
        ) AS ranks
    FROM retail_sales
    GROUP BY 1,2
) AS T1
WHERE ranks = 1;
```
9. Top 5 Customers by Sales
```sql
SELECT 
    customer_id,
    SUM(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;
```
10. Unique Customers per Category
```sql
SELECT 
    COUNT(DISTINCT customer_id), 
    category
FROM retail_sales
GROUP BY category;
11. Sales by Time Shift (CTE)
WITH Hourly_sale AS
(
    SELECT *,
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
            WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'EVENING'
        END AS SHIFT
    FROM retail_sales 
)

SELECT
    COUNT(*),
    SHIFT
FROM Hourly_sale
GROUP BY SHIFT;
```
📊 Key Insights
The dataset includes multiple product categories and diverse customer demographics
High-value transactions (>1000) indicate premium purchases
Sales trends vary across months, showing seasonality
Customer segmentation by gender and category provides useful insights
Time-based analysis reveals peak sales periods
📌 Conclusion

This project demonstrates how SQL can be used to:

Structure and clean raw data
Perform exploratory data analysis
Generate business insights from transactional data

It is a strong beginner project for anyone starting in data analytics.

🚀 How to Use
Create the database using the SQL script
Insert your dataset into the retail_sales table
Run the queries step by step
Modify queries to explore additional insights
