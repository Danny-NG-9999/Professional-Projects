## Project Background
The dataset for this study is from a Brazilian e-commerce company called Olist Store. It contains information on 100,000 orders made from 2016 to 2018 from various marketplaces in Brazil. The dataset includes details such as the status of the order, the price and payment information, customer location, and product attributes. It also includes customer reviews. The geolocation data associate Brazilian zip codes with latitude and longitude coordinates.

This is real commercial data, it has been anonymized, and references to the companies and partners in the review text have been replaced.




In this project, I have analyzed the data provided and make a dashboard using the Brazilian E-Commerce Public Dataset by Olist. Also, I have looked into the company's store performance to bring insights on opportunity to improve overall customer satisfaction.

In our exploration of the Olist dataset, we have uncovered several insights into the company’s operations. We observed that Olist experienced steady growth over the period covered by the dataset, with a significant increase in sales around Christmas. Sales trends showed that certain product categories are growing much faster than others. Purchasing patterns indicate that customers are more likely to place orders at the start of the week. The bulk of sales is concentrated in populous cities, particularly São Paulo and Rio de Janeiro. Shipping durations vary significantly across different cities and are sometimes affected by postal strikes. Despite many positive reviews, there are frequent complaints about shipping delays. Most orders are of low value, though there is considerable variation in the costs of orders. The most popular product category is "Health and Beauty". The dataset includes very few repeat customers. There some products that are frequently bought together, especially in the categories "Garden Tools" and "Computer Accessories". Most of Olist’s sellers are small businesses, and these generally have slightly faster shipping times than larger sellers. The key channels for acquiring sellers for Olist include organic search, paid search, and direct traffic.

# About the Dataset
The dataset has information on 100,000 orders from 2016 to 2018 made at multiple marketplaces in Brazil. The orders include details such as order status, price, payment, freight performance to customer location, product attribute, and reviews written by customers. The geolocation data is associated to Brazilian zip codes with latitude and longitude coordinates.

This is real commercial data, it has been anonymized, and references to the companies and partners in the review text have been replaced.

# Software Used
- Microsoft Power BI
- Python
- MySQL


The dataset has been loaded and processed in the Power Query Editor and MySQL. In order to facilitate better recognition, I had to promote headers for most of the dataset since Power Query initially struggled to identify them. Additionally, I adjusted the data types for many entries. To enhance clarity and user-friendliness, I replaced technical jargon with more understandable terms, particularly in the "product_category_name_translation" file.

## Data structure & Initial check
The Olist E-Commerce Database is a comprehensive relational dataset that provides a complete view of the transaction lifecycle within the Olist online marketplace ecosystem. This schema is meticulously designed to capture the entire ecosystem, from initial customer contact and order placement to final delivery and review, enabling deep analytical insights into business performance, customer behavior, and marketplace dynamics. 

This dataset contains over 100,000 orders placed by approximately 96,000 unique customers and fulfilled by nearly 3,100 active sellers, covering the period from 2016 to 2018. It comprises 11 core tables and one custom-enriched table (`brazil_states`), which together enable the detailed analysis across geographical, operational, and commercial dimensions. The tables are logically interconnected to represent the e-commerce funnel and operational workflow within the Olist platform. 

The **Entity Relationship Diagram (ERD)** and detailed table descriptions are provided below for reference.

### 1️⃣ Entity Relationship Diagram (ERD)
<img width="984" height="1374" alt="ERD (e-commerce)" src="https://github.com/user-attachments/assets/cc19b442-109c-4adf-83b1-1e6fea51fcd6" />


### 2️⃣ Table Relationships and Descriptions

| **Table**                           | **Primary Key**                 | **Description**                                                                                         |
| ----------------------------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `orders`                            | `order_id`                      | The central table tracking each order’s status and key timestamps from purchase to delivery.            |
| `customers`                         | `customer_id`                   | Stores unique customer identifiers and their geographical location data.                                |
| `order_payments`                    | `N/A`                           | Records all payment transactions associated with each order, including method, installments, and value. |
| `order_items`                       | `N/A`                           | Details the products, sellers, prices, and shipping details for every item within an order.             |
| `sellers`                           | `seller_id`                     | Contains seller profile information and their geographical location.                                    |
| `order_reviews`                     | `review_id`                     | Captures customer-submitted review scores and feedback for completed orders.                            |
| `product_category_name_translation` | `product_category_name`         | Provides English translations for Portuguese product category names.                                    |
| `geolocation`                       | `geolocation_zip_code_prefix`   | A reference table for latitude, longitude, city, and state based on Brazilian ZIP code prefixes.        |
| `leads_qualified`                   | `N/A`                           | Tracks Marketing Qualified Leads (MQLs), capturing their first contact date and origin.                 |
| `leads_closed`                      | `mql_id_id`                     | Extends `leads_qualified` with data on won opportunities, including business segment and lead profile.  |
| `brazil_states`                     | `state_code`                    | **Custom Table:** Enriches geographical analysis by mapping state codes to names and macro-regions.     |

---
## Methodology

---
## Executive Summary and Key Takeaways

---
## Deep Dive Analysis

---
## Conclusion


