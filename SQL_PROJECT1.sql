-- DATA CLEANING:
DELETE FROM retail_sales
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantity IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL


-- DATA STRUCTURE:
-- HOW MANY UNIQUE CUSTOMERS DO WE HAVE?

SELECT COUNT(DISTINCT customer_id) FROM retail_sales

-- 155

-- HOW MANY CATEGORIES DO WE HAVE?

SELECT COUNT(DISTINCT category) FROM retail_sales

-- 3

-- STOCK SOLD PER CATEGORY

SELECT category,SUM(quantity)
FROM retail_sales
GROUP BY category

-- ELECTRONICS- 1682  CLOTHING- 1780  BEAUTY- 1533


-- BUSINESS QUERIES:

-- TOP 5 CUSTOMERS BASED ON TOTAL SALES

SELECT customer_id,SUM(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5

-- 3(1st) , 1(2nd) , 5(3rd) , 2(4th) , 4(5th)


-- TOTAL SALE MADE IN EACH CATEGORY

SELECT category,SUM(total_sale)
FROM retail_sales
GROUP BY category
ORDER BY SUM(total_sale) DESC

-- ELECTRONICS- ₹313810  CLOTHING- ₹311070  BEAUTY- ₹286840


-- TOTAL SALE MADE BY EACH GENDER 

SELECT gender,SUM(total_sale)
FROM retail_sales
GROUP BY gender
ORDER BY SUM(total_sale) DESC

-- FEMALE- ₹463110  MALE- ₹445120 


-- AVERAGE AGE OF CUSTOMERS BUYING BEAUTY PRODUCTS

SELECT AVG(age) FROM retail_sales
WHERE category='Beauty'

-- 40years and 5months

-- NUMBER OF UNIQUE CUSTOMERS IN EACH CATEGORY

SELECT category,COUNT(DISTINCT customer_id) AS customer_base
FROM retail_sales
GROUP BY category

BEAUTY-141  CLOTHING-149  ELECTRONICS-144


-- TOTAL SALE MADE IN ELECTRONICS BY MALE AND IN BEAUTY BY FEMALE

SELECT gender,category,SUM(total_sale)
FROM retail_sales
GROUP BY gender,category

-- MALE(ELECTRONICS)- ₹151880  FEMALE(BEAUTY)- ₹149470


-- TOTAL SALE MADE BY PEOPLE IN THEIR TWENTIES

SELECT SUM(total_sale)
FROM retail_sales
WHERE age BETWEEN 20 AND 29

-- ₹194140


-- TOTAL QUANTITY OF ORDERS IN EACH SHIFT


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


-- TOTAL SALES MADE IN THE EACH QUARTER

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

-- Q1- ₹62200  Q2- ₹73715  Q3- ₹104890  Q4- ₹208530  


-- MONTH WITH HIGEST SALE EACH YEAR

SELECT*FROM(
SELECT 
EXTRACT(YEAR FROM sale_date) AS YEAR,
EXTRACT(MONTH FROM sale_date) AS MONTH,
SUM(total_sale) AS MONTHLYSALE,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY SUM(total_sale) DESC)
FROM retail_sales 
GROUP BY 1,2)
WHERE rank=1

-- DECEMBER OF 2022 and 2023


-- PROFIT PER TRANSACTION

SELECT transactions_id,(price_per_unit-cogs)*quantity AS profit_per_trans
FROM retail_sales

-- TOTAL PROFIT ON SALES

SELECT SUM((price_per_unit-cogs)*quantity) AS total_profit
FROM retail_sales

-- ₹421369












