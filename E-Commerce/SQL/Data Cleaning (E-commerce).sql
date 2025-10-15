USE `e-commerce`;

-- Check current setting
SHOW VARIABLES LIKE 'max_execution_time';
-- Increase to 10 minutes (600000 ms)
SET GLOBAL max_execution_time = 600000;

# Check for Missing or Null Values function
DROP PROCEDURE IF EXISTS check_missing;
DELIMITER //
CREATE PROCEDURE check_missing(IN p_table VARCHAR(250))
BEGIN
  DECLARE v_schema VARCHAR(250) DEFAULT DATABASE();
  SET SESSION group_concat_max_len = 1000000;
  SELECT GROUP_CONCAT(
    CONCAT('SELECT ''', column_name, ''' AS column_name, ', 'SUM(CASE WHEN ', column_name, ' IS NULL',
        CASE
          WHEN data_type IN ('char','varchar','text','tinytext','mediumtext','longtext')
          THEN CONCAT(' OR TRIM(', column_name, ') = ''''')
          ELSE '' END,
      ' THEN 1 ELSE 0 END) AS missing_rows ',
      'FROM `', v_schema, '`.`', p_table, '`')
    SEPARATOR ' UNION ALL ') INTO @sql
  FROM information_schema.columns
  WHERE table_schema = v_schema AND table_name = p_table;
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

CALL check_missing('customers');
CALL check_missing('geolocation');
CALL check_missing('leads_closed');
CALL check_missing('leads_qualified');
CALL check_missing('order_items');
CALL check_missing('order_payments');
CALL check_missing('order_reviews');
CALL check_missing('orders');
CALL check_missing('product_category_name_translation');
CALL check_missing('products');
CALL check_missing('sellers');

# Show missing or null values
DROP PROCEDURE IF EXISTS show_missing;
DELIMITER //
CREATE PROCEDURE show_missing(IN p_table VARCHAR(250))
BEGIN
  DECLARE v_schema VARCHAR(128) DEFAULT DATABASE();
  SET SESSION group_concat_max_len = 1000000;
  -- Build condition dynamically for all columns
  SELECT GROUP_CONCAT(CONCAT('(', column_name, ' IS NULL',
      CASE
        WHEN data_type IN ('char','varchar','text','tinytext','mediumtext','longtext')
        THEN CONCAT(' OR TRIM(', column_name, ') = ''''')
        ELSE ''END,')'
        ) SEPARATOR ' OR ')
  INTO @cond
  FROM information_schema.columns
  WHERE table_schema = v_schema
    AND table_name   = p_table;
  SET @sql = CONCAT('SELECT * FROM `', v_schema, '`.`', p_table, '` WHERE ', @cond, ' LIMIT 10000;');
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

CALL show_missing('customers');
CALL show_missing('geolocation');
CALL show_missing('leads_closed'); # Acceptable missing lead profile
CALL show_missing('leads_qualified'); # Acceptable missing origin
CALL show_missing('order_items');
CALL show_missing('order_payments');
CALL show_missing('order_reviews'); # Acceptable missing comment_title
CALL show_missing('orders'); # Drop row where order_delivered_customer_date are missing 
CALL show_missing('product_category_name_translation');
CALL show_missing('products'); # Drop row where category_name are missing
CALL show_missing('sellers');

# Data clearing and standardization
## Delete values where order_delivered_customer_date are missing in orders table
### Check how many rows would be deleted
SELECT COUNT(*) AS rows_to_delete
FROM orders
WHERE order_delivered_customer_date IS NULL OR TRIM(order_delivered_customer_date) = ''; #2965 rows

### Delete the rows
SET SQL_SAFE_UPDATES = 0;
DELETE FROM orders
WHERE order_delivered_customer_date IS NULL OR TRIM(order_delivered_customer_date) = '';
SET SQL_SAFE_UPDATES = 1;

## Detele values where product_category_name are missing in products table
### Check how many rows would be deleted
SELECT COUNT(*) AS rows_to_delete
FROM products
WHERE product_category_name IS NULL OR TRIM(product_category_name) = '';

### Delete the rows
SET SQL_SAFE_UPDATES = 0;
DELETE FROM products
WHERE product_category_name IS NULL OR TRIM(product_category_name) = '';
SET SQL_SAFE_UPDATES = 1;

## Delete Null rows in brazil states
SET SQL_SAFE_UPDATES = 0;
DELETE FROM brazil_states
WHERE state_code IS NULL OR TRIM(state_code) = '';
SET SQL_SAFE_UPDATES = 1;

## Left join customers table with geolocation table and inner join self-created state table
CREATE OR REPLACE VIEW customer_map AS
SELECT c.customer_city, c.customer_state, st.state_name, c.customer_zip_code_prefix,
  COUNT(*) AS customer_count, g.lat, g.lng
FROM `e-commerce`.customers c
LEFT JOIN (
  SELECT geolocation_zip_code_prefix, AVG(geolocation_lat) AS lat, AVG(geolocation_lng) AS lng
  FROM `e-commerce`.geolocation
  GROUP BY geolocation_zip_code_prefix) g ON g.geolocation_zip_code_prefix = c.customer_zip_code_prefix
INNER JOIN brazil_states AS st ON st.state_code = c.customer_state
GROUP BY c.customer_state, st.state_name, c.customer_city, c.customer_zip_code_prefix, g.lat, g.lng
ORDER BY customer_count DESC
LIMIT 100000;

## Count number of null rows of the join above for mapping later
SELECT COUNT(*) AS total_rows, SUM(CASE WHEN lat IS NULL THEN 1 ELSE 0 END) AS null_lat_count, SUM(CASE WHEN lng IS NULL THEN 1 ELSE 0 END) AS null_lng_count
FROM (SELECT c.customer_city, c.customer_state, st.state_name, 
	c.customer_zip_code_prefix, COUNT(*) AS customer_count, g.lat, g.lng
    FROM `e-commerce`.customers c
    LEFT JOIN (
        SELECT geolocation_zip_code_prefix, AVG(geolocation_lat) AS lat, AVG(geolocation_lng) AS lng
        FROM `e-commerce`.geolocation
        GROUP BY geolocation_zip_code_prefix) g ON g.geolocation_zip_code_prefix = c.customer_zip_code_prefix
    INNER JOIN brazil_states AS st ON st.state_code = c.customer_state
    GROUP BY c.customer_state, st.state_name, c.customer_city, c.customer_zip_code_prefix, g.lat, g.lng) subquery;

## INSERT the 105 records into the 'geolocation' table with cleaned coordinates to prevent null and missing lat and lng
INSERT INTO geolocation (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state) VALUES
('57254', -9.92, -36.46, 'luziapolis', 'AL'),
('48504', -10.99, -37.28, 'aribice', 'BA'),
('44135', -12.21, -38.97, 'humildes', 'BA'),
('43870', -12.63, -38.16, 'jacuipe', 'BA'),
('42843', -12.45, -38.17, 'jaua', 'BA'),
('42716', -12.89, -38.33, 'lauro de freitas', 'BA'),
('41347', -12.88, -38.39, 'salvador', 'BA'),
('41098', -12.97, -38.48, 'salvador', 'BA'),
('62898', -4.46, -38.65, 'dourado', 'CE'),
('61906', -3.87, -38.62, 'maracanau', 'CE'),
('62625', -4.39, -39.11, 'missi', 'CE'),
('72300', -15.88, -48.09, 'brasilia', 'DF'),
('70324', -15.83, -47.93, 'brasilia', 'DF'),
('72536', -16.03, -47.93, 'brasilia', 'DF'),
('72465', -16.03, -48.06, 'brasilia', 'DF'),
('73402', -15.78, -47.78, 'brasilia', 'DF'),
('70701', -15.79, -47.89, 'brasilia', 'DF'),
('71884', -15.82, -47.95, 'brasilia', 'DF'),
('73369', -15.78, -47.99, 'brasilia', 'DF'),
('71919', -15.85, -48.06, 'brasilia', 'DF'),
('72583', -16.03, -47.92, 'brasilia', 'DF'),
('70716', -15.79, -47.89, 'brasilia', 'DF'),
('71551', -15.71, -47.88, 'brasilia', 'DF'),
('73255', -15.78, -47.98, 'brasilia', 'DF'),
('71993', -15.85, -47.99, 'brasilia', 'DF'),
('72002', -15.85, -48.05, 'brasilia', 'DF'),
('71676', -15.85, -47.92, 'brasilia', 'DF'),
('71539', -15.72, -47.87, 'brasilia', 'DF'),
('71810', -15.88, -48.02, 'brasilia', 'DF'),
('72023', -15.85, -48.05, 'brasilia', 'DF'),
('70686', -15.77, -47.95, 'brasilia', 'DF'),
('73081', -15.80, -47.92, 'brasilia', 'DF'),
('72005', -15.85, -48.05, 'brasilia', 'DF'),
('72341', -15.88, -48.10, 'brasilia', 'DF'),
('71905', -15.85, -48.06, 'brasilia', 'DF'),
('72280', -15.78, -48.14, 'brasilia', 'DF'),
('73082', -15.80, -47.92, 'brasilia', 'DF'),
('71574', -15.71, -47.87, 'brasilia', 'DF'),
('72238', -15.86, -48.12, 'brasilia', 'DF'),
('71996', -15.85, -47.99, 'brasilia', 'DF'),
('73272', -15.62, -47.81, 'brasilia', 'DF'),
('71975', -15.85, -48.01, 'brasilia', 'DF'),
('72595', -16.03, -47.92, 'brasilia', 'DF'),
('72017', -15.85, -48.05, 'brasilia', 'DF'),
('72596', -16.03, -47.92, 'brasilia', 'DF'),
('72587', -16.03, -47.92, 'brasilia', 'DF'),
('73401', -15.78, -47.78, 'brasilia', 'DF'),
('71208', -15.78, -47.88, 'brasilia', 'DF'),
('71591', -15.71, -47.87, 'brasilia', 'DF'),
('72535', -16.03, -47.93, 'brasilia', 'DF'),
('73090', -15.80, -47.92, 'brasilia', 'DF'),
('72242', -15.81, -48.14, 'brasilia', 'DF'),
('71971', -15.87, -48.03, 'brasilia', 'DF'),
('70316', -15.79, -47.89, 'brasilia', 'DF'),
('73091', -15.80, -47.92, 'brasilia', 'DF'),
('73391', -15.78, -47.98, 'brasilia', 'DF'),
('73310', -15.78, -47.98, 'brasilia', 'DF'),
('72427', -15.99, -48.06, 'brasilia', 'DF'),
('71995', -15.85, -47.99, 'brasilia', 'DF'),
('70333', -15.83, -47.93, 'brasilia', 'DF'),
('72268', -15.78, -48.14, 'brasilia', 'DF'),
('72455', -16.02, -48.05, 'brasilia', 'DF'),
('72237', -15.86, -48.12, 'brasilia', 'DF'),
('70702', -15.79, -47.89, 'brasilia', 'DF'),
('72760', -15.66, -48.20, 'brasilia', 'DF'),
('73088', -15.80, -47.92, 'brasilia', 'DF'),
('71698', -15.85, -47.92, 'brasilia', 'DF'),
('72338', -15.88, -48.09, 'brasilia', 'DF'),
('73093', -15.80, -47.92, 'brasilia', 'DF'),
('71976', -15.85, -48.01, 'brasilia', 'DF'),
('72440', -16.02, -48.05, 'brasilia', 'DF'),
('72243', -15.81, -48.14, 'brasilia', 'DF'),
('71261', -15.77, -47.93, 'brasilia', 'DF'),
('71593', -15.71, -47.87, 'brasilia', 'DF'),
('71953', -15.85, -48.04, 'brasilia', 'DF'),
('72549', -16.05, -47.98, 'brasilia', 'DF'),
('72457', -16.02, -48.05, 'brasilia', 'DF'),
('71590', -15.71, -47.87, 'brasilia', 'DF'),
('29718', -18.78, -40.38, 'angelo frechiani', 'ES'),
('29196', -19.83, -40.26, 'aracruz', 'ES'),
('29949', -18.67, -39.85, 'sao mateus', 'ES'),
('75784', -18.91, -47.50, 'domiciano ribeiro', 'GO'),
('72821', -16.25, -47.95, 'luziania', 'GO'),
('72867', -16.05, -47.98, 'novo gama', 'GO'),
('72863', -16.05, -47.98, 'novo gama', 'GO'),
('72904', -16.02, -48.27, 'santo antonio do descoberto', 'GO'),
('75257', -16.70, -48.74, 'senador canedo', 'GO'),
('65137', -2.57, -44.20, 'maioba', 'MA'),
('65830', -6.25, -46.72, 'sambaiba', 'MA'),
('36248', -20.91, -43.51, 'conceicao do formoso', 'MG'),
('35242', -19.04, -43.19, 'cuite velho', 'MG'),
('36596', -20.67, -42.84, 'estevao de araujo', 'MG'),
('35408', -20.40, -43.76, 'glaura', 'MG'),
('39103', -17.06, -44.02, 'guinda', 'MG'),
('38710', -18.71, -46.05, 'major porto', 'MG'),
('38627', -18.49, -46.29, 'palmital de minas', 'MG'),
('36857', -20.45, -43.08, 'pinhotiba', 'MG'),
('36956', -20.45, -43.08, 'sao francisco do humaita', 'MG'),
('35104', -19.06, -42.75, 'sao vitor', 'MG'),
('37005', -21.55, -45.43, 'varginha', 'MG'),
('78554', -11.87, -55.51, 'sinop', 'MT'),
('67105', -1.34, -48.40, 'ananindeua', 'PA'),
('68511', -5.37, -49.11, 'maraba', 'PA'),
('68629', -2.99, -47.35, 'paragominas', 'PA'),
('58734', -6.80, -37.05, 'passagem', 'PB'),
('58286', -7.21, -36.43, 'pitanga de estrada', 'PB'),
('55027', -8.29, -35.94, 'caruaru', 'PE'),
('56327', -9.39, -40.49, ' petrolina', 'PE'),
('55863', -7.52, -35.26, 'siriji', 'PE'),
('56485', -9.00, -37.82, 'tacaratu', 'PE'),
('64605', -7.07, -41.47, 'picos', 'PI'),
('64095', -5.09, -42.80, 'teresina', 'PI'),
('64047', -5.09, -42.80, 'teresina', 'PI'),
('87323', -23.42, -52.44, 'alto sao joao', 'PR'),
('83843', -25.75, -49.37, 'doce grande', 'PR'),
('85118', -25.26, -50.15, 'palmeirinha', 'PR'),
('83210', -25.53, -48.55, 'paranagua', 'PR'),
('85958', -24.49, -53.48, 'perola independente', 'PR'),
('86135', -24.47, -52.47, 'santa margarida', 'PR'),
('84623', -24.47, -50.28, 'santana', 'PR'),
('85894', -24.81, -54.00, 'sao clemente', 'PR'),
('86996', -23.63, -51.81, 'sao miguel do cambui', 'PR'),
('87511', -23.77, -53.25, 'umuarama', 'PR'),
('25840', -22.10, -43.11, 'bemposta', 'RJ'),
('28388', -21.43, -42.11, 'bom jesus do querendo', 'RJ'),
('27980', -21.60, -42.44, 'corrego do ouro', 'RJ'),
('28120', -21.98, -41.45, 'ibitioca', 'RJ'),
('28575', -21.65, -42.48, 'jaguarembe', 'RJ'),
('25919', -22.68, -43.04, 'mage', 'RJ'),
('28655', -21.94, -42.41, 'monnerat', 'RJ'),
('28617', -22.30, -42.53, 'nova friburgo', 'RJ'),
('28160', -21.79, -41.32, 'santo eduardo', 'RJ'),
('28530', -21.57, -42.57, 'sao sebastiao do paraiba', 'RJ'),
('59547', -5.73, -36.27, 'pedra preta', 'RN'),
('59299', -6.21, -37.89, 'poco de pedra', 'RN'),
('76968', -11.43, -61.44, 'cacoal', 'RO'),
('76897', -10.43, -62.48, 'jaru', 'RO'),
('93602', -29.62, -51.17, 'estancia velha', 'RS'),
('94370', -29.85, -51.04, 'ipiranga', 'RS'),
('95572', -29.27, -49.85, 'mampituba', 'RS'),
('95853', -29.95, -51.72, 'polo petroquimico de triunfo', 'RS'),
('49870', -10.22, -37.38, 'itabi', 'SE'),
('7412', -23.40, -46.33, 'aruja', 'SP'),
('7430', -23.40, -46.33, 'aruja', 'SP'),
('19740', -22.30, -50.40, 'bora', 'SP'),
('7729', -23.36, -46.73, 'caieiras', 'SP'),
('7784', -23.35, -46.87, 'cajamar', 'SP'),
('6930', -23.87, -46.77, 'cipo-guacu', 'SP'),
('11547', -23.89, -46.43, 'cubatao', 'SP'),
('13307', -23.38, -47.34, 'itu', 'SP'),
('12332', -23.28, -46.04, 'jacarei', 'SP'),
('8980', -23.58, -46.43, 'nossa senhora do remedio', 'SP'),
('12770', -23.55, -46.70, 'pinheiros', 'SP'),
('2140', -23.55, -46.63, 'sao paulo', 'SP'),
('8342', -23.55, -46.63, 'sao paulo', 'SP'),
('17390', -21.46, -46.07, 'sao sebastiao da serra', 'SP'),
('77404', -11.72, -49.06, 'gurupi', 'TO');

## Re-check
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

## Check existence of customer_id on orders and customers table
SELECT c.customer_id, o.customer_id
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id;

## INSERT the update of product category name in english to prevent null and missing values
INSERT INTO product_category_name_translation (product_category_name, product_category_name_english)
VALUES ('pc_gamer', 'pc_gamer'), ('portateis_cozinha_e_preparadores_de_alimentos', 'kitchen_appliances_and_food_processors')
ON DUPLICATE KEY UPDATE product_category_name_english = VALUES(product_category_name_english);

SELECT *
FROM product_category_name_translation
WHERE product_category_name IN ('pc_gamer', 'portateis_cozinha_e_preparadores_de_alimentos');
  
## Sellers info
INSERT INTO geolocation (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
VALUES
    ('82040', -25.43, -49.27, 'curitiba', 'PR'),
    ('91901', -30.03, -51.22, 'porto alegre', 'RS'),
    ('72580', -15.78, -47.93, 'brasilia', 'DF'),
    ('2285', -23.55, -46.64, 'sao paulo', 'SP'),
    ('37708', -21.79, -46.56, 'pocos de caldas', 'MG');

CREATE OR REPLACE VIEW seller_map AS
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

















