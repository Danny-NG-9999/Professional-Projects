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

<img width="2122" height="1187" alt="image" src="https://github.com/user-attachments/assets/75ac1130-a789-46a6-b9c9-ec934d1177f1" />

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
| **Exploratory Data Analysis (EDA)**       | MySQL (CTEs, window functions), Python (Heatmap, WordCloud)              | Uncovering patterns in customer behavior, seller performance, payment trends, and geographical distribution.                           |
| **Business Intelligence & Visualization** | Power BI, Python                                                         | Building interactive executive dashboards with KPIs for sales, operations, customer satisfaction, and regional performance.            |
| **Documentation & Reporting**             | GitHub (Markdown)                                                        | Presenting reproducible analysis, technical documentation, and business recommendations for stakeholders.                              |


---
## Executive Summary and Key Takeaways
This comprehensive analysis of Olist’s Brazilian E-Commerce Dataset—spanning 100,000+ orders from 2016 to 2018—reveals a marketplace characterized by rapid growth but constrained by logistical inefficiencies and customer retention gaps. After rigorous data cleaning and transformation, the refined dataset includes:
- 96,100 unique customers
- 3,100 active sellers
- ~99,500 orders ready for deep analysis

The analysis uncovers actionable patterns in sales performance, customer behavior, and market dynamics, offering a data-driven roadmap to optimize operational efficiency and elevate customer satisfaction. Below are the strategic takeaways:
- Growth Trajectory: Strong upward momentum in order volume and revenue, signaling market expansion opportunities.
- Logistical Bottlenecks: Persistent delays and inefficiencies in order fulfillment, risking customer trust and repeat business.
- Customer Retention: High churn rates among first-time buyers, highlighting the need for targeted engagement and loyalty initiatives.
- Lead Conversion: Digital acquisition channels — particularly organic search, paid search, and direct traffic — drive strong funnel performance, though there remains significant potential to optimize conversion rates and enhance overall marketing efficiency.

### 1️⃣ Operational Performance
- Growth & Seasonality: Olist demonstrates consistent year-over-year growth, with pronounced and predictable sales peaks during the New Year and summer seasons. These seasonal patterns emphasize the importance of proactive inventory management and demand forecasting to optimize stock levels and resource allocation.
- Market Concentration: Order volumes and customer activity are predominantly concentrated in major metropolitan regions—especially São Paulo and Rio de Janeiro. This indicates that geographic optimization and logistics efficiency within these high-density hubs are critical to maximizing revenue potential.
- Product Strategy: The “Health and Beauty” and “Sports & Leisure” categories lead in both sales volume and revenue contribution, positioning them as Olist’s primary growth drivers and strategic focus areas.
- Cross-Selling Opportunities: An analysis of the correlation matrix among the top five product categories (which collectively account for ~70% of total revenue) revealed limited cross-selling potential. This suggests minimal opportunity for bundled promotions, though targeted investments in fast-growing, high-margin categories remain strategically viable.

### 2️⃣ Logistics Performance
- Primary Bottleneck: Shipping delays remain the most significant driver of negative customer sentiment and lower satisfaction (CSAT) scores. Enhancing delivery consistency and reliability is essential to improving overall customer experience.
- Fulfillment Variability: Delivery timelines exhibit considerable fluctuation across regions and months, highlighting the need for improved communication and dynamic Estimated Delivery Date (EDD) management to better align customer expectations.
- Seller Efficiency: A key operational insight is that the marketplace's smaller sellers demonstrate slightly faster shipping times on average than larger sellers. This suggests an opportunity to formalize best practices from the small seller cohort and scale them across the entire seller ecosystem.

### 3️⃣ Customer Reviews
- Satisfaction Driver: Despite the negative impact of shipping issues, the overall customer sentiment (indicated in average review score) remains largely positive, reflecting confidence in product quality and platform reliability.
- Retention Challenge: A critical finding is the notably low repeat purchase rate, signaling a critical need to strengthen customer retention strategies and enhance Customer Lifetime Value (CLV) through loyalty programs or personalized engagement initiatives.
- Behavioral Window: Customers are most active during midday to evening hours on weekdays, averaging 750–1,100 orders per hour. These behavioral insights provide an ideal basis for timing targeted promotions, marketing campaigns, and retention efforts to maximize engagement.

### 4️⃣ Lead Conversion (Seller Acquisition)
- Channel Performance: Paid Search and Organic Search generate the highest lead volumes, contributing significantly to overall acquisition. Paid Search achieves a conversion rate of 12.3%, slightly outperforming Organic Search (11.8%), underscoring the strong return on investment from search-driven channels.
- High-Efficiency Channels: While Unknown sources show the highest conversion rate (16.7%), the category likely includes untracked or blended referrals. Direct Traffic (11.2%) and Referral (8.5%) also demonstrate stable performance, suggesting loyal or repeat visitors are more likely to convert.
- Low-Volume Channels: Channels such as Email (3.0%), Social (5.6%), and Display (5.1%) exhibit lower conversion efficiency, highlighting opportunities to refine targeting, messaging, and audience segmentation.
- Funnel Leakage: Despite strong lead acquisition, there is a notable drop-off between qualification and closure, especially within high-volume search channels. This indicates a need for improved lead nurturing, enhanced CRM workflows, and cross-channel attribution tracking to strengthen conversion performance.
- Funnel Optimization Opportunity: Overall, Olist demonstrates robust digital acquisition capability but has room to improve funnel efficiency through data-driven lead scoring, personalized engagement strategies, and marketing–sales process alignment to maximize conversion outcomes.

---
## Deep Dive Analysis
### Operational Performance
<img width="2122" height="1187" alt="image" src="https://github.com/user-attachments/assets/24b36b3b-063c-4fd0-98fd-d3354db4ba06" />

#### Highly Contrentrated Revenue
- Revenue Concentration: The top three product categories — Sports & Leisure, Health & Beauty, and Cool Stuff — account for 55.02% of total gross sales ($8.60M). While these are high-performing category segments, this overreliance represents a strategic risk, as any demand disruption or supply chain issue could significantly affect revenue stability.

**💡 Actionable Insights and Recommendation:**
- Diversify Product Portfolio: Invest in and Promoting emerging categories such as Electronics and Stationery to reduce category dependency.
- Bundle & Cross-Sell: Develop cross-category bundles (e.g., Computer Accessories + PC Gamer) to boost average order value and category breadth.
- Dynamic Pricing: Implement AI-driven pricing strategies to stimulate demand during off-peak months, particularly in Q4.
- Data-Driven Expansion: Use market intelligence (e.g., Google Trends) to identify and onboard sellers in fast-growing niches like sustainable products.

### Customer Behavior & Retention
- Retention Challenge: Olist’s customer base is overwhelmingly transactional, with 93.6% one-time buyers and an average of only 1.03 orders per customer across 96K users. This “leaky bucket” model indicates strong acquisition but weak retention — a major barrier to profitability.

**💡 Actionable Insights and Recommendation:**

Loyalty Programs: Launch a points-based or subscription model for replenishable categories like Health & Beauty to increase repeat purchases.

Targeted Re-Engagement: Deploy post-purchase and win-back campaigns at 30- and 60-day intervals to recover 5–10% of inactive customers.

Experience Optimization: Address delivery-related complaints to raise the average review rating to 4.5+, improving both retention and conversion.
---
## Conclusion


