# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `practice1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **HOW MANY UNIQUE CUSTOMERS DO WE HAVE?**:
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales
```

2. **STOCK SOLD PER CATEGORY**:
```sql
SELECT category,SUM(quantity)
FROM retail_sales
GROUP BY category
```

3. **TOP 5 CUSTOMERS BASED ON TOTAL SALES**:
```sql
SELECT customer_id,SUM(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5
```

4. **TOTAL SALE MADE IN EACH CATEGORY**:
```sql
SELECT category,SUM(total_sale)
FROM retail_sales
GROUP BY category
ORDER BY SUM(total_sale) DESC
```

5. **TOTAL SALE MADE BY EACH GENDER**:
```sql
SELECT gender,SUM(total_sale)
FROM retail_sales
GROUP BY gender
ORDER BY SUM(total_sale) DESC
```

6. **AVERAGE AGE OF CUSTOMERS BUYING BEAUTY PRODUCTS**:
```sql
SELECT AVG(age) FROM retail_sales
WHERE category='Beauty'
```

7. **NUMBER OF UNIQUE CUSTOMERS IN EACH CATEGORY**:
```sql
SELECT category,COUNT(DISTINCT customer_id) AS customer_base
FROM retail_sales
GROUP BY category
```

8. **TOTAL SALE MADE IN ELECTRONICS BY MALE AND IN BEAUTY BY FEMALE**:
```sql
SELECT gender,category,SUM(total_sale)
FROM retail_sales
GROUP BY gender,category
HAVING gender='Male' AND category='Electronics' 
OR gender='Female' AND category='Beauty'
```

9. **TOTAL SALE MADE BY PEOPLE IN THEIR TWENTIES**:
```sql
SELECT SUM(total_sale)
FROM retail_sales
WHERE age BETWEEN 20 AND 29
```

10. **TOTAL QUANTITY OF ORDERS IN EACH SHIFT**:
```sql
SELECT
SUM(CASE
WHEN EXTRACT(HOUR FROM sale_time)<=12 THEN quantity
ELSE 0
END
) AS morning_shift,
SUM(CASE
WHEN EXTRACT(HOUR FROM sale_time)>12 AND EXTRACT(HOUR FROM sale_time)<=17 THEN quantity
ELSE 0
END
) AS afternoon_shift,
SUM(CASE
WHEN EXTRACT(HOUR FROM sale_time)>17 THEN quantity
ELSE 0
END
) AS evening_shift
FROM retail_sales
```

11. ** TOTAL SALE MADE IN EACH QUARTER**:
```sql
SELECT SUM(
CASE
WHEN sale_date BETWEEN '2022-01-01' AND '2022-03-31' THEN total_sale
ELSE 0
END
) AS Q1,
SUM(
CASE
WHEN sale_date BETWEEN '2022-04-01' AND '2022-06-30' THEN total_sale
ELSE 0
END
) AS Q2,
SUM(
CASE
WHEN sale_date BETWEEN '2022-07-01' AND '2022-09-30' THEN total_sale
ELSE 0
END
) AS Q3,
SUM(
CASE
WHEN sale_date BETWEEN '2022-10-01' AND '2022-12-31' THEN total_sale
ELSE 0
END
) AS Q4
FROM retail_sales
```
**MONTH WITH HIGEST SALE EACH YEAR**:
```sql
SELECT*FROM(
SELECT 
EXTRACT(YEAR FROM sale_date) AS YEAR,
EXTRACT(MONTH FROM sale_date) AS MONTH,
SUM(total_sale) AS MONTHLYSALE,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY SUM(total_sale) DESC)
FROM retail_sales 
GROUP BY 1,2)
WHERE rank=1
```
**TOTAL PROFIT ON SALES**:
```sql
SELECT SUM((price_per_unit-cogs)*quantity) AS total_profit
FROM retail_sales
```


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **Sales Trends**: Monthly analysis shows that December is the peak month for sale.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Sk Md Affan

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
