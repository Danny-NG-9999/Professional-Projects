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
- Growth & Seasonality: Olist demonstrates consistent year-over-year growth, with pronounced and predictable sales peaks during the Spring and Summer seasons. These seasonal patterns emphasize the importance of proactive inventory management and demand forecasting to optimize stock levels and resource allocation.
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

#### Gross Sales Seasonality 
- Peak Months: August ($2.18M) and March ($1.77M).
- Lowest Months: October (0.68M) and November ($0.79M)
- Freight Costs: Relatively stable but spike in Spring and Summer season (holiday seasons).
- Average Order Value (AOV): The platform records a modest average order value of $15.73, indicating a high-volume, low-ticket sales model typical of fast-moving consumer goods and impulse-driven purchases.

**💡 Actionable Insights and Recommendation:**
- Demand Forecasting: Use ML models to predict and optimize inventory level for maximize profit
- Freight Optimization: Negotiate bulk shipping discounts for peak months.
- Introduce "Free Shipping Thresholds" (e.g., orders over $50) to boost AOV (Average Order Value).
- Off-Peak Promotions: Launch "Winter Clearance" (Jan-Feb) or "Back-to-School" (Sep) campaigns to smooth revenue.

#### Highly Contrentrated Revenue
- Revenue Concentration: The top three product categories — Sports & Leisure, Health & Beauty, and Cool Stuff — account for 55.02% of total gross sales ($8.60M). While these are high-performing category segments, this overreliance represents a strategic risk, as any demand disruption or supply chain issue could significantly affect revenue stability.

**💡 Actionable Insights and Recommendation:**
- Diversify Product Portfolio: Invest in and Promoting emerging categories such as Electronics and Stationery to reduce category dependency.
- Bundle & Cross-Sell: Develop cross-category bundles (e.g., Computer Accessories + PC Gamer) to boost average order value and category breadth.
- Dynamic Pricing: Implement AI-driven pricing strategies to stimulate demand during off-peak months, particularly in Q4.
- Data-Driven Expansion: Use market intelligence (e.g., Google Trends) to identify and onboard sellers in fast-growing niches like sustainable products.

#### Customer Behavior & Retention
- Retention Challenge: Olist’s customer base is overwhelmingly transactional, with 93.6% one-time buyers and an average of only 1.03 orders per customer across 96K users. This “leaky bucket” model indicates strong acquisition but weak retention — a major barrier to profitability.

**💡 Actionable Insights and Recommendation:**
- Loyalty Programs: Launch a points-based or subscription model for replenishable categories like Health & Beauty to increase repeat purchases.
- Post-Purchase Engagement: Personalized email campaigns (e.g., "We miss you" discounts, product recommendations) and SMS notifications for abandoned carts or restocks.
- Experience Optimization: Address delivery-related complaints to raise the average review rating to 4.5+, improving both retention and conversion.

#### Seller Ecosystem & Operational Efficiency
- Marketplace Composition: Olist’s marketplace is predominantly composed of large sellers (62.3%), with small sellers representing 37.7% of the total seller base. Despite their smaller footprint, small sellers consistently outperform larger ones in operational efficiency — achieving an average delivery time of 8.9 days, compared to 9.6 days for large sellers. Collectively, small sellers contribute approximately $7.2M in gross sales (46% of total revenue), underscoring their disproportionately strong commercial performance relative to scale.
- Platform Utilization: With 3,095 active sellers handling roughly 99,000 orders, the average volume per seller is only 32 orders. This low throughput indicates underutilized seller capacity and a largely fragmented seller base with significant headroom for growth and scaling.

**💡 Actionable Insights and Recommendation:**
- Operational Standardization: Develop a Seller Logistics Training Program to replicate the high-performance practices of smaller, more efficient sellers across the broader seller network.
- Performance Management: Implement Service Level Agreements (SLAs) for large sellers, with clear KPIs tied to delivery time — reinforced by incentive or penalty mechanisms.
- Seller Tiering & Incentives: Launch a Seller Tier Program that rewards top performers with premium listings, marketing visibility, and bulk shipping discounts to encourage faster growth and sustained quality.
- Small Seller Growth Programs: Offer reduced commission rates to small sellers achieving predefined growth milestones and Provide co-branded marketing support and featured listings to help promising small sellers scale while maintaining operational excellence.

<img width="2235" height="1244" alt="image" src="https://github.com/user-attachments/assets/e8a220ec-0c44-42d6-98a5-d4c9555d4caa" />

#### Temporal Analysis: Order Volume by Day of Week and Hour of Day
- Peak Activity: Order volume is highest at the start of the week, with Mondays (16,196 orders), Tuesdays (15,963 orders), and Wednesdays (15,552 orders) driving the bulk of transactions. Activity gradually declines toward the weekend, reaching its lowest levels on Saturdays (10,887) and Sundays (11,960).
- Hourly Trends: Across all weekdays, order activity peaks consistently between 10:00 and 22:00, aligning with standard working hours and evening online browsing behavior.

**💡 Actionable Insights and Recommendation:**
- Targeted Early-Week Campaigns: Deploy Monday morning email or SMS promotions featuring limited-time discounts (e.g., 10% off during peak hours) to capitalize on strong early-week engagement.
- Weekend Activation Strategies: Launch weekend-exclusive incentives such as free shipping on Saturdays or bundle offers to boost weekend conversion rates and offset the activity gap.
- Operational Optimization: Align warehouse staffing and customer support coverage with the 10:00–22:00 activity window to improve fulfillment speed and reduce processing backlogs.

#### Geospatial Distribution: Customer and Revenue Concentration
- Customer Distribution: The majority of Olist’s customer base is concentrated in Southeastern Brazil, particularly São Paulo (SP), Minas Gerais (MG), and Rio de Janeiro (RJ) — collectively representing the platform’s largest and most active customer clusters. In contrast, Northern regions (e.g., Amazonas, AM) show minimal customer penetration, highlighting untapped market potential.
- Revenue Distribution: Revenue closely follows customer density, with SP, MG, and RJ generating the highest total sales. However, average revenue per customer varies regionally, suggesting differing purchasing power and product mix preferences that warrant localized pricing strategies.
- Regional Disparities: The Southeast region dominates in both order volume and revenue contribution, while Northern and Central-Western states (e.g., Acre, AC) remain largely underdeveloped in e-commerce activity, underscoring an opportunity for strategic regional expansion.

**💡 Actionable Insights and Recommendation:**
- Revenue Optimization: Conduct regional A/B testing in high-value markets (SP and RJ) to optimize Average Order Value (AOV) through dynamic pricing and bundled offers that aligning offers with local purchasing behavior.
- Dual Fulfillment Strategy (SP/RJ vs. Rest of Brazil):
  - High-Volume Corridor: Perform a feasibility study for opening a regional fulfillment hub or cross-docking center specifically dedicated to serving the São Paulo/Rio de Janeiro corridor. This dedicated infrastructure could cut intra-state delivery times by multiple days, transforming the customer experience.
  - Long-Tail Coverage: For the remaining fragmented, low-volume geographical regions, maintain a low-CAPEX, decentralized logistics strategy. Avoid capital over-investment and instead leverage strategic partnerships with strong, regional carriers to cost-effectively manage the long-tail geographical spread.

### Logistics Performance
<img width="2224" height="1254" alt="image" src="https://github.com/user-attachments/assets/e42cd28e-0014-4657-9ec0-1656e5b3bc93" />

#### Order Status and Payment Types breakdown
- Performance Overview: Olist demonstrates a low overall cancellation and others rate, indicating operational reliability and customer trust. However, even marginal improvements in order completion could yield a revenue uplift of approximately $312K, based on current gross sales of $15.64M. This underscores the financial leverage of process optimization in order management.
- Improvement Potential: A deeper analysis suggests that cancellations often correlate with late dispatches, unclear product information, or stock inaccuracies, all of which can be mitigated through better operational control and transparency.
- Credit Card – Dominant Channel: The majority of transactions are completed via credit cards, underscoring Brazilian consumers’ strong preference for installment-based payments and ease of online use.
- Boleto Bancário – Significant Local Method: A substantial share of payments are made through Boleto, reflecting the continued relevance of traditional and locally trusted payment systems, especially among unbanked or credit-averse customers.
- Debit Card & Other Methods – Limited Adoption: Debit cards and alternative payment methods represent a small fraction of total transactions.

**💡 Actionable Insights and Recommendation:**
- Seller-Level Monitoring: Implement a real-time cancellation dashboard segmented by seller and product category. Flag sellers exceeding a 2% cancellation rate for immediate review and targeted operational support to preserve marketplace consistency.
- Pre-Purchase Clarity: Enhance product page transparency by standardizing descriptions, ensuring accurate stock visibility, and providing dynamic estimated delivery times (EDD). This will help reduce pre-purchase uncertainty — a key driver of preventable cancellations.

#### Delivery Status, Processing - Shipping duration and Delivery variance Breakdown
While 85% of orders arrive on time or early, the 8% late and 2% undelivered rates are costly—leading to customer churn, negative reviews, and lost revenue.
Seller Delays: 10K late dispatches suggest seller operational issues (e.g., inventory mismanagement, poor packaging processes).
While order processing is efficient (0.43 hours), the 2.81-day handoff to carriers indicates seller-side bottlenecks
Business Impact: Extended delivery times directly correlate with negative reviews, reduced repeat purchases, and competitive disadvantage

Variance Consistency: The Delivery Variance (Difference between Scheduled and Actual Delivery) is consistently high throughout the year, with a major spike in July (16.0 days), this mean that most of the time order are delivered earlier than schedule on average which mean if the order is delayed, it was delayed really bad lead to negative feedback .



**💡 Actionable Insights and Recommendation:**
 Predictive Delivery Promise Engine

Implement machine learning to provide accurate delivery estimates

Factor in seller performance history, carrier data, and seasonal patterns

Set realistic customer expectations while maintaining competitiveness

Carrier Partnership Optimization

Benchmark current carriers against regional performance data

Develop multi-carrier strategy to mitigate single-point failures

Implement dynamic carrier selection based on destination and season







---
## Conclusion


