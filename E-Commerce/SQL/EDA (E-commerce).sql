# Customers geographical map
CREATE OR REPLACE VIEW customer_geographical_map AS
SELECT c.customer_city, c.customer_state, st.state_name, c.customer_zip_code_prefix,
  COUNT(*) AS customer_count, g.lat, g.lng
FROM `e-commerce`.customers c
LEFT JOIN (
  SELECT geolocation_zip_code_prefix, ROUND(AVG(geolocation_lat), 2) AS lat, ROUND(AVG(geolocation_lng), 2) AS lng
  FROM `e-commerce`.geolocation
  GROUP BY geolocation_zip_code_prefix) g ON g.geolocation_zip_code_prefix = c.customer_zip_code_prefix
INNER JOIN brazil_states AS st ON st.state_code = c.customer_state
GROUP BY c.customer_state, st.state_name, c.customer_city, c.customer_zip_code_prefix, g.lat, g.lng
ORDER BY customer_count DESC
LIMIT 100000;

## Sellers geographical map
CREATE OR REPLACE VIEW seller_geographical_map AS
SELECT s.seller_city, s.seller_state, st.state_name, s.seller_zip_code_prefix,
  COUNT(*) AS seller_count, g.lat, g.lng
FROM `e-commerce`.sellers s
LEFT JOIN (
  SELECT geolocation_zip_code_prefix, ROUND(AVG(geolocation_lat), 2) AS lat, ROUND(AVG(geolocation_lng), 2) AS lng
  FROM `e-commerce`.geolocation
  GROUP BY geolocation_zip_code_prefix) g ON g.geolocation_zip_code_prefix = s.seller_zip_code_prefix
INNER JOIN brazil_states AS st ON st.state_code = s.seller_state
GROUP BY s.seller_city, s.seller_state, st.state_name, s.seller_zip_code_prefix, g.lat, g.lng
ORDER BY seller_count DESC
LIMIT 100000;

# Total GMV
SELECT COUNT(*) AS items_qty, ROUND(SUM(oi.price), 2) AS merchandise_value, ROUND(SUM(oi.freight_value), 2) AS freight_value, ROUND(SUM(oi.price + oi.freight_value), 2) AS gmv
FROM order_items AS oi
INNER JOIN products AS p ON p.product_id = oi.product_id;

## GMV by order ID and product ID
SELECT oi.order_id, oi.product_id, oi.seller_id, COUNT(*) AS items_qty, ROUND(SUM(oi.price), 2) AS merchandise_value,
	ROUND(SUM(oi.freight_value), 2) AS freight_value, ROUND(SUM(oi.price + oi.freight_value), 2) AS gmv, 
    p.product_category_name, t.product_category_name_english AS category_en
FROM order_items AS oi
INNER JOIN products as p ON p.product_id = oi.product_id
INNER JOIN product_category_name_translation t ON t.product_category_name = p.product_category_name
GROUP BY oi.order_id, oi.product_id, oi.seller_id, p.product_category_name, category_en
LIMIT 1000000;

## Group payment with order ID
CREATE OR REPLACE VIEW order_values_payments AS
WITH payment_summary AS (
    SELECT order_id, ROUND(SUM(payment_value), 0) AS total_paid,
	MAX(CAST(COALESCE(payment_installments, 0) AS UNSIGNED)) AS max_installments,
    GROUP_CONCAT(DISTINCT payment_type ORDER BY payment_type ASC SEPARATOR ', ') AS payment_types
    FROM order_payments
    GROUP BY order_id)
SELECT oi.order_id, oi.product_id, oi.seller_id, o.order_estimated_delivery_date,
    COUNT(*) AS items_qty, ROUND(SUM(oi.price), 0) AS merchandise_value,
    ROUND(SUM(oi.freight_value), 0) AS freight_value, ROUND(SUM(oi.price + oi.freight_value), 0) AS gmv,
    p.product_category_name, t.product_category_name_english AS category_en, ps.total_paid,
    ps.max_installments, ps.payment_types
FROM order_items AS oi
INNER JOIN products AS p ON p.product_id = oi.product_id
INNER JOIN product_category_name_translation AS t ON t.product_category_name = p.product_category_name
INNER JOIN payment_summary AS ps ON ps.order_id = oi.order_id
INNER JOIN orders AS o ON o.order_id = oi.order_id
GROUP BY oi.order_id, oi.product_id, oi.seller_id, p.product_category_name, category_en, 
	ps.total_paid, ps.max_installments, ps.payment_types, o.order_estimated_delivery_date
ORDER BY ps.total_paid DESC, ps.max_installments DESC
LIMIT 1000000;

## Total order
SELECT COUNT(*) AS total_orders_all
FROM orders;

### Total delivered orders (6 cancelled order)
SELECT COUNT(*) AS total_orders_delivered
FROM orders
WHERE order_status = 'delivered';

## Day different between actual and estimated delivery date for each order_id and corresponding review score
CREATE OR REPLACE VIEW order_summary AS
WITH payment_summary AS (
    SELECT order_id, ROUND(SUM(payment_value), 2) AS total_payment
    FROM order_payments
    GROUP BY order_id)
SELECT o.order_id, MAX(oi.product_id) AS product_id, MAX(oi.seller_id) AS seller_id,
    COUNT(DISTINCT oi.order_item_id) AS items_qty, YEAR(MAX(o.order_purchase_timestamp)) AS order_year, MONTH(MAX(o.order_purchase_timestamp)) AS order_month,
    ROUND(SUM(oi.freight_value), 0) AS freight_value, ROUND(SUM(oi.price + oi.freight_value), 0) AS gmv,
    MAX(p.product_category_name) AS category_br, MAX(t.product_category_name_english) AS category_en,
    ROUND(MAX(ps.total_payment), 0) AS payment_value, MAX(rv.review_score) AS review_score,
    MAX(o.order_estimated_delivery_date) AS order_estimated_delivery_date, MAX(o.order_delivered_customer_date) AS order_delivered_customer_date,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date)), 2) AS delivery_delay
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN products AS p ON p.product_id = oi.product_id
LEFT JOIN product_category_name_translation AS t ON t.product_category_name = p.product_category_name
LEFT JOIN payment_summary AS ps ON ps.order_id = o.order_id
LEFT JOIN order_reviews AS rv ON rv.order_id = o.order_id
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL
GROUP BY o.order_id
ORDER BY order_year, order_month
LIMIT 100000;

SELECT * FROM order_summary
WHERE order_id IS NULL OR product_id IS NULL OR seller_id IS NULL
   OR items_qty IS NULL OR order_year IS NULL OR order_month IS NULL
   OR freight_value IS NULL OR gmv IS NULL OR category_br IS NULL OR category_en IS NULL
   OR payment_value IS NULL OR review_score IS NULL OR order_estimated_delivery_date IS NULL
   OR order_delivered_customer_date IS NULL OR delivery_delay IS NULL;

CREATE OR REPLACE VIEW order_summary_clean AS
SELECT o.*,
    -- Replace NULL payment_value with GMV
    COALESCE(o.payment_value, o.gmv) AS payment_value_filled,
    -- Compute delivery status
    CASE 
        WHEN o.delivery_delay < 0 THEN 'early'
        WHEN o.delivery_delay > 0 THEN 'late'
        ELSE 'on_time'
    END AS delivery_status,
    -- Replace NULL review_score based on category and delivery status averages
    COALESCE(o.review_score, 
    (SELECT ROUND(AVG(sub.review_score), 2)  FROM order_summary AS sub
    WHERE sub.category_br = o.category_br
    AND ((o.delivery_delay < 0 AND sub.delivery_delay < 0) OR (o.delivery_delay > 0 AND sub.delivery_delay > 0))
    AND sub.review_score IS NOT NULL)) AS review_score_filled
FROM order_summary AS o
-- Drop rows that still have NULLs in either payment or review after fixes
WHERE COALESCE(o.payment_value, o.gmv) IS NOT NULL
  AND COALESCE(o.review_score,(
  SELECT ROUND(AVG(sub.review_score), 2)
  FROM order_summary AS sub
  WHERE sub.category_br = o.category_br
  AND ((o.delivery_delay < 0 AND sub.delivery_delay < 0) OR (o.delivery_delay > 0 AND sub.delivery_delay > 0))
  AND sub.review_score IS NOT NULL)) IS NOT NULL;
  
## Popular day for orders
SELECT DATE(order_purchase_timestamp) AS order_date, COUNT(*) AS total_orders
FROM orders AS o
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL
GROUP BY DATE(order_purchase_timestamp)
ORDER BY total_orders DESC, order_date
LIMIT 100000;

## Popular month for order
CREATE OR REPLACE VIEW popular_month AS
SELECT MONTH(order_purchase_timestamp) AS order_month, DATE_FORMAT(order_purchase_timestamp, '%M') AS month_name, COUNT(*) AS total_orders
FROM orders AS o
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL
GROUP BY MONTH(order_purchase_timestamp), DATE_FORMAT(order_purchase_timestamp, '%M')
ORDER BY total_orders DESC;

## Popular products category for orders
CREATE OR REPLACE VIEW popular_month_details AS
WITH monthly_category_orders AS (
    SELECT MONTH(o.order_purchase_timestamp) AS order_month, DATE_FORMAT(o.order_purchase_timestamp, '%M') AS month_name,
    t.product_category_name_english AS category_name, COUNT(DISTINCT o.order_id) AS orders_in_category
    FROM orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
    JOIN products AS p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation AS t ON p.product_category_name = t.product_category_name
    WHERE o.order_status = 'delivered'
    GROUP BY MONTH(o.order_purchase_timestamp), DATE_FORMAT(o.order_purchase_timestamp, '%M'), t.product_category_name_english),
monthly_totals AS (
    SELECT MONTH(order_purchase_timestamp) AS order_month, DATE_FORMAT(order_purchase_timestamp, '%M') AS month_name, COUNT(DISTINCT order_id) AS monthly_total_orders
    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY MONTH(order_purchase_timestamp), DATE_FORMAT(order_purchase_timestamp, '%M')),
ranked_categories AS (
    SELECT mco.order_month, mco.month_name, mco.category_name, mco.orders_in_category,
    ROW_NUMBER() OVER (PARTITION BY mco.order_month ORDER BY mco.orders_in_category DESC) AS category_rank
    FROM monthly_category_orders mco)
SELECT rc.order_month, rc.month_name, rc.category_name, rc.orders_in_category AS total_orders_in_category,
	mt.monthly_total_orders, ROUND((rc.orders_in_category / mt.monthly_total_orders) * 100, 2) AS category_share_percent, rc.category_rank,
    ROUND(SUM(rc.orders_in_category) OVER (PARTITION BY rc.order_month ORDER BY rc.orders_in_category DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  / mt.monthly_total_orders * 100, 2) AS cumulative_top_categories_percent
FROM ranked_categories AS rc
JOIN monthly_totals AS mt ON rc.order_month = mt.order_month
WHERE rc.category_rank <= 10
ORDER BY rc.order_month, rc.category_rank;

# Lead conversion
CREATE OR REPLACE VIEW lead_conversion AS
SELECT COALESCE(NULLIF(NULLIF(lq.origin, ''), 'N/A'), 'unknown') AS origin,
       COUNT(DISTINCT lq.mql_id) AS qualified_leads,
       COUNT(DISTINCT lc.mql_id_id) AS closed_leads,
       COUNT(DISTINCT lc.mql_id_id) * 100.0 / COUNT(DISTINCT lq.mql_id)
           AS conversion_rate
FROM leads_qualified AS lq
LEFT JOIN leads_closed AS lc ON lq.mql_id = lc.mql_id_id -- Explicit ON clause is safer than USING
GROUP BY COALESCE(NULLIF(NULLIF(lq.origin, ''), 'N/A'), 'unknown')
ORDER BY COUNT(lq.mql_id) DESC;

## Order-Day-Hour timeline
SET @count_orders_per_hour = 'COUNT(CASE WHEN hour = 0 THEN 1 END) AS "0",
    COUNT(CASE WHEN hour = 1 THEN 1 END) AS "1",
    COUNT(CASE WHEN hour = 2 THEN 1 END) AS "2",
    COUNT(CASE WHEN hour = 3 THEN 1 END) AS "3",
    COUNT(CASE WHEN hour = 4 THEN 1 END) AS "4",
    COUNT(CASE WHEN hour = 5 THEN 1 END) AS "5",
    COUNT(CASE WHEN hour = 6 THEN 1 END) AS "6",
    COUNT(CASE WHEN hour = 7 THEN 1 END) AS "7",
    COUNT(CASE WHEN hour = 8 THEN 1 END) AS "8",
    COUNT(CASE WHEN hour = 9 THEN 1 END) AS "9",
    COUNT(CASE WHEN hour = 10 THEN 1 END) AS "10",
    COUNT(CASE WHEN hour = 11 THEN 1 END) AS "11",
    COUNT(CASE WHEN hour = 12 THEN 1 END) AS "12",
    COUNT(CASE WHEN hour = 13 THEN 1 END) AS "13",
    COUNT(CASE WHEN hour = 14 THEN 1 END) AS "14",
    COUNT(CASE WHEN hour = 15 THEN 1 END) AS "15",
    COUNT(CASE WHEN hour = 16 THEN 1 END) AS "16",
    COUNT(CASE WHEN hour = 17 THEN 1 END) AS "17",
    COUNT(CASE WHEN hour = 18 THEN 1 END) AS "18",
    COUNT(CASE WHEN hour = 19 THEN 1 END) AS "19",
    COUNT(CASE WHEN hour = 20 THEN 1 END) AS "20",
    COUNT(CASE WHEN hour = 21 THEN 1 END) AS "21",
    COUNT(CASE WHEN hour = 22 THEN 1 END) AS "22",
    COUNT(CASE WHEN hour = 23 THEN 1 END) AS "23"';

CREATE VIEW orders_per_day_of_the_week_and_hour AS
WITH OrderDayHour AS (
    SELECT
        -- Day of the week abreviated. DAYOFWEEK() returns 1 (Sun) to 7 (Sat).
        CASE DAYOFWEEK(order_purchase_timestamp)
            WHEN 2 THEN 'Mon'
            WHEN 3 THEN 'Tue'
            WHEN 4 THEN 'Wed'
            WHEN 5 THEN 'Thu'
            WHEN 6 THEN 'Fri'
            WHEN 7 THEN 'Sat'
            WHEN 1 THEN 'Sun'
            END AS day_of_week_name,
        -- Day of the week as integer (Sunday=1, Monday=2, ..., Saturday=7)
        DAYOFWEEK(order_purchase_timestamp) AS day_of_week_int,
        -- Hour of the day (0-23)
        HOUR(order_purchase_timestamp) AS hour
    FROM orders
)
SELECT
    day_of_week_name,
    -- The list of COUNT(CASE...) for all 24 hours
    COUNT(CASE WHEN hour = 0 THEN 1 END) AS "0",
    COUNT(CASE WHEN hour = 1 THEN 1 END) AS "1",
    COUNT(CASE WHEN hour = 2 THEN 1 END) AS "2",
    COUNT(CASE WHEN hour = 3 THEN 1 END) AS "3",
    COUNT(CASE WHEN hour = 4 THEN 1 END) AS "4",
    COUNT(CASE WHEN hour = 5 THEN 1 END) AS "5",
    COUNT(CASE WHEN hour = 6 THEN 1 END) AS "6",
    COUNT(CASE WHEN hour = 7 THEN 1 END) AS "7",
    COUNT(CASE WHEN hour = 8 THEN 1 END) AS "8",
    COUNT(CASE WHEN hour = 9 THEN 1 END) AS "9",
    COUNT(CASE WHEN hour = 10 THEN 1 END) AS "10",
    COUNT(CASE WHEN hour = 11 THEN 1 END) AS "11",
    COUNT(CASE WHEN hour = 12 THEN 1 END) AS "12",
    COUNT(CASE WHEN hour = 13 THEN 1 END) AS "13",
    COUNT(CASE WHEN hour = 14 THEN 1 END) AS "14",
    COUNT(CASE WHEN hour = 15 THEN 1 END) AS "15",
    COUNT(CASE WHEN hour = 16 THEN 1 END) AS "16",
    COUNT(CASE WHEN hour = 17 THEN 1 END) AS "17",
    COUNT(CASE WHEN hour = 18 THEN 1 END) AS "18",
    COUNT(CASE WHEN hour = 19 THEN 1 END) AS "19",
    COUNT(CASE WHEN hour = 20 THEN 1 END) AS "20",
    COUNT(CASE WHEN hour = 21 THEN 1 END) AS "21",
    COUNT(CASE WHEN hour = 22 THEN 1 END) AS "22",
    COUNT(CASE WHEN hour = 23 THEN 1 END) AS "23"
FROM OrderDayHour
GROUP BY day_of_week_name, day_of_week_int
ORDER BY day_of_week_int;
