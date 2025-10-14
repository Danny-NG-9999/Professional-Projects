# 🛒 Strategic BI Analysis of the Brazilian E-Commerce Platform

## Project Background
This project presents a comprehensive Business Intelligence (BI) analysis of the Brazilian E-Commerce Public Dataset by Olist, one of Brazil’s leading online retail platforms. Olist connects thousands of small and medium-sized enterprises (SMEs) with customers nationwide, offering a rich dataset for analyzing sales performance, customer behavior, seller operations, and logistics efficiency.

The dataset comprises over 100,000 orders placed between 2016 and 2018, encompassing detailed transactional data such as order status, pricing, payment methods, freight performance, customer demographics, product attributes, and customer reviews. It also includes geolocation data linking Brazilian ZIP codes to latitude and longitude coordinates, enabling granular regional and demographic analysis. All records have been anonymized to protect both customer and business identities.

Using Power BI, Python, and MySQL, the dataset was systematically cleaned, transformed, modeled, and visualized to create interactive dashboards and derive actionable insights. The analytical workflow followed an end-to-end data analytics pipeline, incorporating:
1. Data extraction and validation
2. Data cleaning and transformation
3. SQL-based exploration and modeling
4. Comprehensive analysis and interactive reporting

The primary objective of this study is to evaluate Olist’s operational performance and uncover actionable opportunities to enhance customer satisfaction, sales efficiency, and logistical effectiveness. Insights derived from the analysis are categorized into four strategic focus areas:
- ⚙️ Operational Performance – Analysis of sales trends, order volumes, top-performing categories, and purchasing behavior.
- 🚚 Logistics Performance – Evaluation of payment patterns, delivery timelines, monthly variance, and shipping reliability.
- ⭐ Customer Reviews – Exploration of sentiment patterns and key drivers influencing satisfaction and dissatisfaction.
- 💰 Lead Conversion – Assessment of marketing funnel efficiency, from qualified leads to closed conversions.

Through this BI-driven approach, the project transforms raw transactional data into strategic business intelligence, empowering data-informed decision-making and revealing pathways to strengthen Olist’s sales growth, customer experience, and competitive positioning in the Brazilian e-commerce landscape.

**💻 Softwares Used**
- Microsoft Power BI
- Python
- MySQL

**📊 Supporting Resources**
- Datasource: Kaggle
- Dashboard: Interactive Power BI Dashboard file
- Git project format for PowerBI
- Exploratory Data Analysis (EDA) and Data Inspection — in-depth SQL-based analysis of core tables
- SQL Queries — scripts used for data transformation and PowerBI visualization modelling
- Preview of the dashboard in PDF format

---

## Data structure & Initial check
The Olist E-Commerce Database is a comprehensive relational dataset that provides a complete view of the transaction lifecycle within the Olist online marketplace ecosystem. This schema is meticulously designed to capture the entire ecosystem, from initial customer contact and order placement to final delivery and review, enabling deep analytical insights into business performance, customer behavior, and marketplace dynamics. 

This dataset contains over 100,000 orders placed by approximately 99,000 unique customers and fulfilled by nearly 3,100 active sellers, covering the period from 2016 to 2018. It comprises 11 core tables and one custom-enriched table (`brazil_states`), which together enable the detailed analysis across geographical, operational, and commercial dimensions. The tables are logically interconnected to represent the e-commerce funnel and operational workflow within the Olist platform. 

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
| `products`                          | `product_id`                    | Centralized management of product listings with details specifications and attributes                   |
| `product_category_name_translation` | `product_category_name`         | Provides English translations for Portuguese product category names.                                    |
| `geolocation`                       | `geolocation_zip_code_prefix`   | A reference table for latitude, longitude, city, and state based on Brazilian ZIP code prefixes.        |
| `leads_qualified`                   | `N/A`                           | Tracks Marketing Qualified Leads (MQLs), capturing their first contact date and origin.                 |
| `leads_closed`                      | `mql_id_id`                     | Extends `leads_qualified` with data on won opportunities, including business segment and lead profile.  |
| `brazil_states`                     | `state_code`                    | **Custom Table:** Enriches geographical analysis by mapping state codes to names and macro-regions.     |

---
## Methodology
This project followed a structured, end-to-end data analytics workflow designed to transform raw e-commerce data into actionable business intelligence. The methodology ensures data integrity, analytical rigor, and reproducible insights for Olist's marketplace optimization.

| **Layer**                                 | **Tools / Techniques**                                                   | **Purpose**                                                                                                                            |
| ----------------------------------------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| **Data Storage & Querying**               | MySQL                                                                    | Data extraction, relational database management, and complex join operations across 12 interconnected tables.                          |
| **Data Cleaning & Preparation**           | MySQL, Python                                                            | Data validation, handling missing values, type conversion, and ensuring referential integrity across the entire transaction lifecycle. |
| **Exploratory Data Analysis (EDA)**       | MySQL (CTEs, window functions), Python (Matplotlib, Seaborn, WordCloud)  | Uncovering patterns in customer behavior, seller performance, payment trends, and geographical distribution.                           |
| **Business Intelligence & Visualization** | Power BI, Python                                                         | Building interactive executive dashboards with KPIs for sales, operations, customer satisfaction, and regional performance.            |
| **Documentation & Reporting**             | GitHub (Markdown)                                                        | Presenting reproducible analysis, technical documentation, and business recommendations for stakeholders.                              |


---
## Executive Summary and Key Takeaways
This analysis of Olist's operations from 2016 to 2018 reveals a marketplace experiencing strong growth but facing critical challenges in logistics and customer retention. The following summary distills key insights across four core performance domains, providing a strategic foundation for targeted business improvements.

This Business Intelligence (BI) analysis of the Olist Brazilian E-Commerce Dataset uncovers key insights into the company’s operational, logistical, and customer experience performance. Drawing from over 100,000 orders (2016–2018), the analysis highlights patterns in sales growth, customer behavior, and market dynamics, providing data-driven recommendations to enhance operational efficiency and customer satisfaction. After data cleaning and transformation, the dataset contain 96,100 unique customers, 3100 sellers and approximately 995000 orders ready to be processed and analyze. The analysis reveals a marketplace experiencing strong growth but facing critical challenges in logistics and customer retention. The following summary distills key insights across four core performance domains, providing a strategic foundation for targeted business improvements.



This comprehensive analysis of Olist’s Brazilian E-Commerce Dataset—spanning 100,000+ orders from 2016 to 2018—reveals a marketplace characterized by rapid growth but constrained by logistical inefficiencies and customer retention gaps. After rigorous data cleaning and transformation, the refined dataset includes:

96,100 unique customers
3,100 active sellers
~995,000 orders ready for deep analysis



Exploratory analysis revealed several patterns in Olist’s e-commerce operations:

Steady growth in order volume, with peaks during the Christmas season

Category-specific trends, with "Health and Beauty" leading in sales

Geographic concentration of orders in São Paulo and Rio de Janeiro

Shipping delays as a common driver of negative reviews

Low repeat purchase rate, indicating potential retention opportunities

Smaller sellers tend to offer faster delivery times than larger ones

Top acquisition channels include organic search, paid search, and direct traffic

Through this BI-driven analysis, the project aims to identify performance bottlenecks, customer experience challenges, and growth opportunities to help Olist improve operational efficiency and customer satisfaction.

Sales & Growth: Olist experienced steady growth, with pronounced seasonal peaks during Christmas. Significant sales concentration was observed in major metropolitan areas like São Paulo and Rio de Janeiro.

Product Performance: The "Health and Beauty" category emerged as the top-selling category, with other niches like "Garden Tools" and "Computer Accessories" showing strong cross-selling potential.

Customer Behavior: Order placement peaks at the start of the week. The customer base is predominantly composed of first-time buyers, indicating a significant opportunity for improving customer retention.

Operational Challenges: Shipping delays were identified as a primary driver of negative customer reviews. Delivery times vary considerably by region and are occasionally impacted by external factors like postal strikes.

Seller Ecosystem: The marketplace is largely powered by small businesses, which, on average, demonstrate slightly faster shipping times than larger sellers.

1. Growth, Concentration, and Product Strategy
Market Concentration: Sales volume is heavily concentrated in Brazil's most populous cities, notably São Paulo and Rio de Janeiro, confirming geographic optimization is key.

Sales Momentum: Olist experienced steady growth during the study period, with a highly predictable peak in demand observed around the Christmas period.

Category Performance: While the overall most popular category is "Health and Beauty," growth analysis indicates that certain product categories are expanding at a significantly faster rate, necessitating focused inventory investment.

Cross-Selling Opportunities: Identified frequent co-purchase patterns, particularly within "Garden Tools" and "Computer Accessories," suggesting immediate opportunities for bundled product promotion.

2. Logistical Gaps and Customer Experience
Shipping Consistency: The analysis highlights significant variability in shipping durations across different cities, occasionally impacted by external events like postal strikes.

Customer Dissatisfaction Driver: Despite generally positive feedback, the most frequent and common customer complaint cited in the reviews pertains directly to shipping delays, confirming logistics as the primary obstacle to high customer satisfaction (CSAT).

Seller Fulfillment Performance: A notable operational insight is that the majority of Olist’s sellers are smaller businesses, and these segments generally exhibit slightly faster shipping times compared to larger sellers.

3. Customer Retention and Acquisition
Low Repeat Rate: A critical finding is the low proportion of repeat customers within the dataset, indicating a major challenge in customer retention and lifetime value (CLV) optimization.

Purchase Timing: Customers are statistically more likely to place orders at the start of the working week (Monday/Tuesday), providing a strategic window for targeted promotional campaigns.

Acquisition Channels: The analysis confirmed the key channels driving seller acquisition for Olist are organic search, paid search, and direct traffic.

---
## Deep Dive Analysis

---
## Conclusion


