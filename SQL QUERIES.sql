-- show tables
show tables;

-- selecting the table
select* from project2.walmartsalesanalysis;

-- Data cleaning

-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM walmartsalesanalysis;

ALTER TABLE walmartsalesanalysis ADD COLUMN time_of_day VARCHAR(20);

-- Add day_name column
SELECT
	date,
	DAYNAME(date)
FROM walmartsalesanalysis;

ALTER TABLE walmartsalesanalysis ADD COLUMN day_name VARCHAR(10);

UPDATE walmartsalesanalysis
SET day_name = DAYNAME(date);


-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM walmartsalesanalysis;

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM walmartsalesanalysis;


-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM walmartsalesanalysis;


-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM walmartsalesanalysis
GROUP BY product_line
ORDER BY qty DESC;


-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM walmartsalesanalysis
GROUP BY product_line
ORDER BY qty DESC;

-- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM walmartsalesanalysis
GROUP BY product_line
ORDER BY avg_rating DESC;


-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM walmartsalesanalysis
GROUP BY gender, product_line
ORDER BY total_cnt DESC;


-- Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM walmartsalesanalysis
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmartsalesanalysis);


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(quantity) AS avg_qnty
FROM walmartsalesanalysis;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM walmartsalesanalysis
GROUP BY product_line;


-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM walmartsalesanalysis
GROUP BY product_line
ORDER BY total_revenue DESC;


-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM walmartsalesanalysis
GROUP BY city, branch 
ORDER BY total_revenue;


-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM walmartsalesanalysis;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM walmartsalesanalysis;


-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM walmartsalesanalysis
GROUP BY customer_type
ORDER BY count DESC;


-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM walmartsalesanalysis
GROUP BY customer_type;


SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesanalysis
GROUP BY gender
ORDER BY gender_cnt DESC;


SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesanalysis
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;


-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------
-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM walmartsalesanalysis
GROUP BY customer_type
ORDER BY total_revenue;





