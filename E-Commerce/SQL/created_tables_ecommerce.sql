SHOW VARIABLES LIKE 'secure_file_priv';

SHOW VARIABLES LIKE 'local_infile';

-- check current value
SHOW VARIABLES LIKE 'local_infile';
-- enable for this server (persists across restarts on 8.0.13+)
SET PERSIST local_infile = 1;
-- if PERSIST not allowed, use:
-- SET GLOBAL local_infile = 1;  -- (won’t persist after restart)


-- confirm values
SELECT @@global.local_infile   AS global_local_infile,
       @@session.local_infile  AS session_local_infile;


-- enable for this session if needed
SET SESSION local_infile = 1;
SET GLOBAL local_infile = 1;

-- re-check
SELECT @@session.local_infile;
SHOW VARIABLES LIKE 'local_infile';

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.orders;
CREATE TABLE orders (
order_id	text,
customer_id	text,
order_status text,
order_purchase_timestamp datetime,
order_approved_at datetime,
order_delivered_carrier_date datetime,
order_delivered_customer_date datetime,
order_estimated_delivery_date datetime
);

## Load the CSV
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE `e-commerce`.orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.products;
CREATE TABLE `e-commerce`.products (
  product_id text,
  product_category_name text,
  product_name_lenght text,
  product_description_lenght text,
  product_photos_qty text,
  product_weight_g text,
  product_length_cm text,
  product_height_cm text,
  product_width_cm text
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE `e-commerce`.products
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.sellers;
CREATE TABLE `e-commerce`.sellers (
seller_id	text,
seller_zip_code_prefix	text,
seller_city	text,
seller_state text
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sellers.csv'
INTO TABLE `e-commerce`.sellers
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.order_items;
CREATE TABLE `e-commerce`.order_items (
order_id text,
order_item_id bigint,
product_id text,
seller_id text,
shipping_limit_date datetime,
price bigint,
freight_value bigint
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items.csv'
INTO TABLE `e-commerce`.order_items
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.order_payments;
CREATE TABLE `e-commerce`.order_payments (
order_id text,	
payment_sequential bigint,
payment_type text,
payment_installments bigint,
payment_value bigint
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_payments.csv'
INTO TABLE `e-commerce`.order_payments
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.geolocation;
CREATE TABLE `e-commerce`.geolocation (
geolocation_zip_code_prefix	text,
geolocation_lat	bigint,
geolocation_lng	bigint,
geolocation_city text,
geolocation_state text
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/geolocation.csv'
INTO TABLE `e-commerce`.geolocation
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.customers;
CREATE TABLE `e-commerce`.customers (
customer_id	text,
customer_unique_id	text,
customer_zip_code_prefix text,	
customer_city text,
customer_state text
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE `e-commerce`.customers
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.leads_closed;
CREATE TABLE `e-commerce`.leads_closed (
mql_id_id text,
seller_id text,
sdr_id text,	
sr_id text,
won_date datetime,
business_segment text,
lead_type text,
lead_behaviour_profile text, 
has_company	text,
has_gtin text,
average_stock text,
business_type text,
declared_product_catalog_size text,
declared_monthly_revenue bigint
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/leads_closed.csv'
INTO TABLE `e-commerce`.leads_closed
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.leads_qualified;
CREATE TABLE `e-commerce`.leads_qualified (
mql_id	text,
first_contact_date date,	
landing_page_id	text, 
origin text
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/leads_qualified.csv'
INTO TABLE `e-commerce`.leads_qualified
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.order_reviews;
CREATE TABLE `e-commerce`.order_reviews (
review_id text,
order_id text,
review_score bigint,
review_comment_title text,
review_comment_message text,
review_creation_date datetime,
review_answer_timestamp datetime
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_reviews.csv'
INTO TABLE `e-commerce`.order_reviews
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.product_category_name_translation;
CREATE TABLE `e-commerce`.product_category_name_translation (
product_category_name text,
product_category_name_english text
);

## Load the CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INTO TABLE `e-commerce`.product_category_name_translation
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


## Recreate the table only if needed
DROP TABLE IF EXISTS `e-commerce`.brazil_states;
CREATE TABLE brazil_states (
    id SERIAL PRIMARY KEY,         
    state_code TEXT NOT NULL,  
    state_name TEXT NOT NULL,
    region TEXT NOT NULL);

-- Insert all 27 federative units
INSERT INTO brazil_states (state_code, state_name, region) VALUES
('AC','Acre','North'),
('AL','Alagoas','Northeast'),
('AM','Amazonas','North'),
('AP','Amapá','North'),
('BA','Bahia','Northeast'),
('CE','Ceará','Northeast'),
('DF','Distrito Federal','Central-West'),
('ES','Espírito Santo','Southeast'),
('GO','Goiás','Central-West'),
('MA','Maranhão','Northeast'),
('MG','Minas Gerais','Southeast'),
('MS','Mato Grosso do Sul','Central-West'),
('MT','Mato Grosso','Central-West'),
('PA','Pará','North'),
('PB','Paraíba','Northeast'),
('PE','Pernambuco','Northeast'),
('PI','Piauí','Northeast'),
('PR','Paraná','South'),
('RJ','Rio de Janeiro','Southeast'),
('RN','Rio Grande do Norte','Northeast'),
('RO','Rondônia','North'),
('RR','Roraima','North'),
('RS','Rio Grande do Sul','South'),
('SC','Santa Catarina','South'),
('SE','Sergipe','Northeast'),
('SP','São Paulo','Southeast'),
('TO','Tocantins','North');


### List tables in the current database
SHOW TABLES;
### See columns of a table
DESCRIBE orders;  

SELECT * 
FROM `e-commerce`.leads_qualified
LIMIT 1000000000;

ALTER TABLE tablename MODIFY columnname INTEGER;

