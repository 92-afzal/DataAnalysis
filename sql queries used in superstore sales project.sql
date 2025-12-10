CREATE TABLE superstore_orders (
    row_id          INTEGER PRIMARY KEY,
    order_id        TEXT,
    order_date      DATE,
    ship_date       DATE,
    ship_mode       TEXT,
    customer_id     TEXT,
    customer_name   TEXT,
    segment         TEXT,
    country         TEXT,
    city            TEXT,
    state           TEXT,
    postal_code     TEXT,
    region          TEXT,
    product_id      TEXT,
    category        TEXT,
    sub_category    TEXT,
    product_name    TEXT,
    sales           NUMERIC(12,2),
    quantity        INTEGER,
    discount        NUMERIC(5,2),
    profit          NUMERIC(12,4)
);

-- to copy the data from csv file to table

COPY public.superstore_orders
FROM 'D:/Data analyst Projects/superstoresales/orders.csv'
WITH (
    FORMAT csv,
    HEADER,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"'
);

create table superstore_returns(
	Returned text,
	order_id text
);


create table superstore_people(
	Person text,
	Region text
);

-- to find the duplicates
SELECT order_id, COUNT(*)
FROM superstore_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- to check how many rows does not have sales,profit or order_date values
SELECT 
    SUM(CASE WHEN sales IS NULL THEN 1 END) AS missing_sales,
    SUM(CASE WHEN profit IS NULL THEN 1 END) AS missing_profit,
    SUM(CASE WHEN order_date IS NULL THEN 1 END) AS missing_order_date
FROM superstore_orders;

-- to check duplicate orders using order_id and product_id
SELECT * FROM superstore_orders a
JOIN superstore_orders b
ON a.order_id = b.order_id
WHERE a.ctid < b.ctid
  AND a.order_id = b.order_id
  AND a.product_id = b.product_id;

-- to get the minimum and maximum order date
SELECT 
    MIN(order_date) AS min_order_date,
    MAX(order_date) AS max_order_date
FROM superstore_orders;

-- to get the total sum of sales
SELECT SUM(sales) AS total_sales
FROM superstore_orders;

 -- to get total profit
SELECT SUM(profit) AS total_profit
FROM superstore_orders;

-- to find unique order
SELECT COUNT(DISTINCT order_id) AS order_count
FROM superstore_orders;

-- to find total sales by region
SELECT region, SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY region
ORDER BY total_sales DESC;

-- to find Profit Margin by Category
SELECT 
    category,
    SUM(profit) / SUM(sales) AS profit_margin
FROM superstore_orders
GROUP BY category
ORDER BY profit_margin ASC;

-- Year-over-Year Region Growth
SELECT 
    region,
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS yearly_sales
FROM superstore_orders
GROUP BY region, year
ORDER BY region, year;

-- YoY %
WITH yearly AS (
    SELECT 
        region,
        EXTRACT(YEAR FROM order_date) AS year,
        SUM(sales) AS yearly_sales
    FROM superstore_orders
    GROUP BY region, year
)
SELECT 
    region,
    year,
    yearly_sales,
    yearly_sales - LAG(yearly_sales) OVER (PARTITION BY region ORDER BY year) AS growth,
    round((yearly_sales - LAG(yearly_sales) OVER (PARTITION BY region ORDER BY year)) 
        / NULLIF(LAG(yearly_sales) OVER (PARTITION BY region ORDER BY year), 0),2) AS growth_rate
FROM yearly
ORDER BY region, year;























