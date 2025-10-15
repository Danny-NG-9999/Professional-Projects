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
- Datasource: [Download the data here](https://www.kaggle.com/datasets/terencicp/e-commerce-dataset-by-olist-as-an-sqlite-database/data)
- Dashboard: [Interactive Power BI Dashboard file](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/E-Commerce/Power%20BI/E-commerce%20(Olist).pbix)
- Dashboard: [Git project format for PowerBI](https://github.com/Danny-NG-9999/Professional-Projects/tree/main/E-Commerce/E-commerce%20(git%20format))
- Database: [SQL table creation and setting](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/E-Commerce/SQL/created_tables_ecommerce.sql)
- Database Schema: [Entity Relationship Diagram (ERD)](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/E-Commerce/ERD%20(e-commerce).mwb)
- Data cleaning: [SQL Queries used for data transformation and PowerBI visualization modelling](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/E-Commerce/SQL/Data%20Cleaning%20(E-commerce).sql)
- Exploratory Data Analysis (EDA): [In-depth SQL-based analysis of core tables](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/E-Commerce/SQL/EDA%20(E-commerce).sql)

**📘 Preview of the BI report**
<img width="2122" height="1187" alt="image" src="https://github.com/user-attachments/assets/75ac1130-a789-46a6-b9c9-ec934d1177f1" />

---
## 📑 Table of Contents
- [Data Structure & Initial Check](#data-structure--initial-check)
  - [1️⃣ Entity Relationship Diagram (ERD)](#1️⃣-entity-relationship-diagram-erd)
  - [2️⃣ Table Relationships and Descriptions](#2️⃣-table-relationships-and-descriptions)
- [Methodology](#methodology)
- [Executive Summary and Key Takeaways](#executive-summary-and-key-takeaways)
- [Deep Dive Analysis and Actionable Insight](#deep-dive-analysis-and-actionable-insight)
    - [Operational Performance](#operational-performance)
    - [Logistics Performance](#logistics-performance)
    - [Customer Reviews](#customer-reviews)
    - [Lead Conversion (Seller Acquisition)](#lead-conversion-seller-acquisition)
- [Conclusion](#conclusion)

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

### 1️⃣ Operational Performance
1. Seasonality & Sales Trends: Gross sales peak in August ($2.18M) and March ($1.77M), with troughs in October ($0.68M) and November ($0.79M). The average order value (AOV) remains modest at $15.73, indicating a high-volume, low-ticket model.
    - Recommendation: Implement ML-based demand forecasting to align inventory with seasonal demand; introduce “free shipping thresholds” and off-peak promotions to raise AOV and stabilize sales.
2. Revenue Concentration Risk: The top three categories — Sports & Leisure, Health & Beauty, and Cool Stuff — drive 55% of total gross sales ($8.6M), signaling category overdependence.
    - Recommendation: Diversify revenue through emerging categories (e.g., Electronics, Stationery), and promote cross-category bundles to mitigate concentration risk.
3. Customer Retention Challenge: 93.6% of customers are one-time buyers, with an average 1.03 orders per user, reflecting strong acquisition but weak retention.
    - Recommendation: Introduce loyalty or subscription programs, automated re-engagement campaigns, and experience improvements to elevate repeat purchase rates.
4. Seller Ecosystem Efficiency: Small sellers (37.7%) outperform large ones in fulfillment speed (8.9 vs. 9.6 days), contributing 46% of total sales ($7.2M). Yet, seller productivity remains low at 32 orders per seller.
    - Recommendation: Launch a Seller Performance Framework with tiered incentives, training, and SLA-based monitoring to scale high-performing behaviors.

### 2️⃣ Logistics Performance
1. Fulfillment Bottlenecks: Average processing time is 0.43 hours, but seller-to-carrier handoff lags by 2.8 days, indicating operational inefficiencies.
    - Recommendation: Deploy a Predictive Delivery Promise Engine using ML to improve ETA accuracy; tighten seller-level operational SLAs.
2. Carrier Optimization: Delivery delays and inconsistency in regional performance suggest dependency on limited logistics partners.
    - Recommendation: Implement a multi-carrier strategy with dynamic carrier selection based on regional data and seasonal demand to cut delivery variance and cost.
3. Payment Mix & Reliability: Credit cards dominate (majority of transactions), followed by Boleto — a critical local payment method. Cancellations remain low, but incremental improvements could yield +$312K in revenue.
    - Recommendation: Standardize product listings and EDD visibility to reduce cancellations; introduce seller-level monitoring for proactive intervention.
4. Regional Disparities: Southeast states (SP, MG, RJ) dominate revenue and customer base, while the North and Central-West remain underpenetrated.
    - Recommendation: Explore a dual logistics model — a regional SP/RJ fulfillment hub for dense markets and decentralized partnerships for low-volume regions.

### 3️⃣ Customer Reviews
1. Primary Pain Points: Negative reviews are driven by delivery delays, product mismatches, and quality issues, particularly in high-risk categories (Furniture, Bed & Bath, Electronics).
    - Recommendation: Enforce packaging compliance for fragile categories and standardized product listings to ensure accuracy and prevent mismatches.
2. Sentiment Dynamics: Overall ratings remain high (4–5 stars dominant), but sentiment dips during high-volume months (March, August) due to logistics strain.
    - Recommendation: Perform root-cause diagnostics on seasonal dips; implement capacity planning and a 3-star recovery program to convert neutral buyers into loyal promoters.
3. Review Concentration: High-volume categories correlate with higher bad-review density, emphasizing the need for category-specific quality control.
    - Recommendation: Create feedback loops where category managers review negative feedback monthly and act on recurring issues via seller retraining and listing updates.

### 4️⃣ Lead Conversion (Seller Acquisition)
1. High-Intent Channels Driving Growth: Paid Search (12.3%), Organic Search (11.8%), and Direct Traffic (11.2%) contribute ~62% of all closed leads, validating strong intent-driven acquisition and brand trust.
    - Recommendation: Scale Paid Search around top-performing keyword clusters and expand SEO content targeting seller pain points.
2. Untapped Referral Opportunity: The Referral channel (8.45%) shows high conversion efficiency but lacks formal structure.
    - Recommendation: Launch a tiered referral program rewarding conversions, leveraging seller advocacy for low-CAC lead generation.
3. Reseller Dependency: Resellers comprise 69.7% of all sellers, while manufacturers (28.7%) offer greater margin potential.
    - Recommendation: Develop a Manufacturer Enablement Program with reduced commissions, co-marketing, and direct-to-consumer support to attract high-value sellers.
4. Marketplace Diversification: Minimal participation from other business types (1.5%) reveals limited vertical integration.
    - Recommendation: Broaden the ecosystem by onboarding service vendors, private labels, and logistics partners, fostering a more resilient and value-rich marketplace.

In summary, Olist’s marketplace demonstrates robust seller acquisition, healthy sales volumes, and scalable operational capacity. To sustain and accelerate growth, the platform must modernize logistics, enhance customer retention, diversify product categories, and expand its seller ecosystem. Effective execution of these initiatives could drive a 10–15% increase in customer lifetime value, reduce fulfillment variability by 10%, and broaden market penetration into underdeveloped regions.

---
## Deep Dive Analysis and Actionable Insight
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
- Revenue Concentration: The top three product categories — Sports & Leisure, Health & Beauty, and Cool Stuff — account for 55.02% of total gross sales ($8.60M out of $15.64M). While these are high-performing category segments, this overreliance represents a strategic risk, as any demand disruption or supply chain issue could significantly affect revenue stability.

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
- Seller-Driven Delays: Over 10,000 late dispatches were attributed to seller-side inefficiencies, which can be primarily driven by inventory mismanagement (e.g., stockouts or inaccurate listings) or inefficient packaging workflows (e.g., manual processes and limited automation) or suboptimal order prioritization, such as delays in processing high-volume orders, highlighting the need for deeper analysis and improved seller communication to identify the true root causes.
- Processing vs. Handoff Gap: While order processing is efficient (averaging 0.43 hours), a 2.8-day delay before carrier handoff highlights a significant operational bottleneck at the seller level.
- Business Impact: Extended delivery timelines are strongly associated with reduced customer satisfaction, lower repeat purchase rates, and a competitive disadvantage in the fast-paced e-commerce environment.
- Delivery Variance: Orders generally arrive earlier than scheduled, with an average lead time of up to 16 days in July, indicating a positive variance. However, this inconsistency demonstrates a misalignment between scheduled and actual delivery performance, where occasional severe delays undermine overall delivery reliability.

**💡 Actionable Insights and Recommendation:**
- Predictive Delivery Promise Engine: Utilize machine learning to generate accurate and dynamic delivery estimates, improving customer trust and satisfaction. The model should incorporates seller performance history, carrier reliability, and seasonal demand patterns to enhance predictive accuracy.
- Carrier Performance Evaluation: Assess current carriers using regional delivery data and historical performance metrics to identify inefficiencies and opportunities for improvement.
- Multi-Carrier Strategy: Develop a diverse and flexible carrier network to mitigate risks associated with single-provider dependency and ensure consistent delivery reliability.
- Dynamic Carrier Routing: Implement a data-driven routing system that selects carriers based on destination, seasonal demand, and past performance, optimizing both delivery speed and cost-efficiency.


#### Correlation Matrix between top performing product category
- Weak Inter-Category Correlation: The correlation matrix for Olist’s top five categories (Auto, Computers & Accessories, Furniture & Decor, Health & Beauty, Sports & Leisure) shows minimal correlation, indicating that purchases in one category are largely independent of others. This pattern suggests category-specific purchasing behavior, with buyers focused on specific needs rather than exploratory or impulse shopping across categories.
- Limited Cross-Selling Potential: Customers predominantly focus on specific product categories, with little multi-category purchasing observed, reducing opportunities to increase AOV through broad cross-category promotions.
- Category-Focused Growth Opportunities: Revenue growth is more likely to come from within-category engagement, such as personalized recommendations, sub-category bundling, and targeted promotions aligned with customer preferences.

**💡 Actionable Insights and Recommendation:**
- Targeted Cross-Promotions Within Categories: Focus on sub-category bundling (e.g., complementary products within Health & Beauty or Computers & Accessories) rather than broad cross-category bundles, where correlation is weak.
- Personalized Recommendation Engine: Implement machine learning-driven product recommendations tailored to each customer’s purchasing history, which can help identify latent cross-selling patterns not visible in aggregate correlations.

### Customer Reviews
<img width="2120" height="1194" alt="image" src="https://github.com/user-attachments/assets/e2178e38-d4b7-4419-ba6f-a5a4c24cec29" />

#### Top Drivers of Dissatisfaction (Word Cloud)
Analysis of negative customer reviews, visualized via a word cloud, highlights recurring complaints that can be grouped into three primary issues:
1. Logistics Failures:
- Predominant driver of negative sentiment, with frequent mentions of delivery delays or missing orders.
- Common terms include produto não recebi (product not received), demora (delay), não chegou (did not arrive), and ainda não (still not).
- Indicates that timely and reliable fulfillment remains the most critical factor affecting customer satisfaction.

2. Product Mismatches:
- Complaints related to items not matching descriptions or images.
- While present, these issues are significantly less frequent than logistics-related complaints, suggesting a secondary impact on overall sentiment.

3. Quality Issues:
- Reports of defective, damaged, or counterfeit products appear in reviews, highlighting occasional gaps in product quality control.

**💡 Actionable Insights and Recommendation:**
- Logistics Optimization: Partner with reliable carriers, implement real-time shipment tracking, and proactively communicate delays. Offer compensation incentives (e.g., discounts on future purchases) to maintain customer trust and satisfaction.
- Product Listing Standards: Enforce high-quality product images and comprehensive descriptions (dimensions, materials, specifications). Flag sellers with high mismatch or error rates for review to ensure consistent product quality and reduce order issues.
- Post-Purchase Support: Automate customer follow-ups (e.g., “Did your order meet expectations?”) to identify and resolve issues early. Streamline returns and refunds processes for defective or unsatisfactory items to enhance the overall post-purchase experience.

#### Review Volume and Sentiment Over Time
- Positive Sentiment Stability: Despite fluctuations in order volume, the majority of customers consistently award 4- and 5-star ratings, indicating strong satisfaction when products are delivered on time and as described. This resilience underscores Olist’s ability to meet expectations under normal operating conditions.
- Seasonal Impact: Noticeable dips in sentiment during high-volume months—notably March and August—suggest that logistics strain during promotional or holiday periods leads to delivery delays and increased low ratings. The December slowdown shows some improvement, but recurring negative feedback points to persistent operational bottleneck

**💡 Actionable Insights and Recommendation:**
- Root Cause Diagnostics: Conduct targeted failure analyses for the March and August review dips to identify logistics or fulfillment weaknesses. Use findings to stress-test and reinforce delivery infrastructure ahead of peak demand cycles.
- 3-Star Recovery Program: Focus on converting neutral (3-star) customers—who represent a major “at-risk” segment—into promoters through personalized post-purchase engagement, proactive support, and retention-driven incentives (e.g., discounts on next purchase). This initiative can directly improve repeat purchase rates and overall customer lifetime value (CLV).

#### Top 10 Categories with Bad Reviews
- High-Volume, High-Risk Categories: Categories such as Health & Beauty and Sports & Leisure generate substantial sales and naturally attract a higher number of negative reviews. This correlation is typical of high-volume segments, where larger order volumes increase exposure to customer dissatisfaction.
- Disproportionate Risk Zones: Categories like Bed, Bath & Table, Furniture & Decor, and Computers & Accessories are overrepresented in the “Bad Reviews” treemap. These items are typically large, fragile, or technically complex, making them more susceptible to fulfillment issues, damage during transit, or mismatched customer expectations.
- Quality Control Gaps: The concentration of poor reviews in high-touch categories (e.g., Furniture, Electronics) highlights potential seller quality control deficiencies and inadequate packaging standards, signaling a need for stricter operational governance in product handling and delivery.

**💡 Actionable Insights and Recommendation:**
- Enforce Packaging Compliance: Introduce mandatory packaging standards (e.g., reinforced boxing, protective padding) for high-risk categories such as Furniture & Decor, Bed, Bath & Table, and Computers & Accessories. Tie compliance to seller performance scores and marketplace visibility.
- Category-Specific Seller Management: Establish tiered seller vetting and monitoring based on product risk profile. For fragile or high-value goods, enforce stricter review thresholds, faster delivery SLAs, and periodic performance audits.
- Feedback Integration Loop: Implement a closed feedback mechanism requiring category managers to review all 1- and 2-star reviews monthly. Insights should feed directly into product improvement, listing accuracy updates, and seller coaching programs to prevent recurring quality issues.

### Lead Conversion (Seller Acquisition)
<img width="2124" height="1192" alt="image" src="https://github.com/user-attachments/assets/eb445f7b-3aa9-43e0-9145-e1adf7d4bfde" />

#### Lead Funnel Efficiency
- High-Intent, High-Performance Channels: Paid Search (12.30%), Organic Search (11.80%), and Direct Traffic (11.22%) collectively drive approximately 62% of all closed leads, forming the backbone of Olist’s seller acquisition funnel. Their strong conversion rates highlight the effectiveness of intent-driven marketing in attracting sellers who are actively seeking a marketplace platform. Moreover, the solid performance of Direct Traffic reinforces strong brand recall and organic marketplace credibility.
- Low-Efficiency Awareness Channels: Channels such as Social Media, Display Advertising, Email, and Other Publicities currently underperform, with conversion rates below 6%. While these channels may contribute to brand awareness and top-of-funnel engagement, they demonstrate low transactional efficiency, implying a misalignment between campaign messaging and conversion intent.
- Untapped Referral Potential: The Referral channel (8.45%) presents a high-quality but underutilized growth lever. Its strong conversion efficiency suggests that satisfied existing sellers are powerful advocates, capable of generating pre-qualified leads at a lower customer acquisition cost (CAC). This indicates a clear opportunity to formalize and scale referral-based acquisition strategies.

**💡 Actionable Insights and Recommendation:**
- Launch a Structured Referral Program: Formalize a tiered seller referral initiative, rewarding participants not only for generating leads but also for successful conversions. Incentivize advocates through commission-based or visibility-based rewards, leveraging existing trust within the seller community to accelerate high-quality lead acquisition.
- Optimize Paid Search Investment: Conduct an in-depth performance diagnostic of keyword clusters to identify and expand high-performing segments. Reallocate budgets toward these proven, high-intent keywords while phasing out underperforming ones to maximize ROI and lead quality.
- Strengthen Organic & Content Strategy: Enhance SEO and content marketing efforts by targeting commercial-intent keywords aligned with seller pain points and search behaviors. Develop educational, conversion-oriented content to maintain organic visibility and further reduce dependency on paid acquisition.

#### Closed Lead Distribution by Business Type: Partnership Focus
- Reseller Dominance (69.7%): Olist’s marketplace is primarily driven by resellers — small to mid-sized businesses that source from established supply chains. While this structure aligns with Olist’s core B2B aggregation model, it also introduces concentration risk. Any performance volatility among top resellers could directly affect overall sales stability and marketplace resilience.
- Manufacturer Growth Opportunity (28.7%): Manufacturers represent a smaller yet strategically valuable segment. Expanding manufacturer participation can enhance product exclusivity, margin control, and pricing flexibility, while differentiating Olist from purely reseller-driven platforms. Strengthening this segment supports long-term profitability and brand equity.
- Limited Marketplace Diversification (1.5%): The minimal representation of other business types — such as service providers, private-label brands, or logistics partners — indicates an opportunity to broaden Olist’s ecosystem. Diversifying seller profiles could create a more balanced, vertically integrated marketplace, improving operational efficiency and reducing dependency on resellers.

**💡 Actionable Insights and Recommendation:**
- Revenue & LTV Segmentation: Conduct a comparative profitability and lifetime value (LTV) analysis between resellers and manufacturers. Prioritize high-value cohorts through dedicated account management and tailored incentive structures
- Manufacturer Enablement Program: Develop a targeted acquisition and support initiative for manufacturers — offering benefits such as reduced commissions, co-branded marketing campaigns, and direct-to-consumer sales enablement to attract and retain high-margin sellers.
- Portfolio Diversification Strategy: Expand the marketplace by onboarding complementary business types — including white-label producers, service vendors, and logistics partners — to create a more resilient, end-to-end commerce ecosystem capable of sustaining long-term growth.

---
## Conclusion
Olist’s e-commerce performance reflects a robust, high-volume marketplace driven by intent-based acquisition and strong operational fundamentals but constrained by retention, logistics, and category concentration challenges. Sales peak in August and March, with the top three categories generating over half of total revenue, underscoring the need for portfolio diversification. While fulfillment reliability is solid, seller-to-carrier handoff delays and regional delivery disparities highlight opportunities for process automation and carrier optimization. Customer satisfaction remains high overall, though recurring complaints around delivery and product mismatches point to packaging and seller quality gaps. Strengthening predictive logistics, expanding manufacturer participation, and implementing data-driven retention and referral programs will be key to driving sustainable growth, higher LTV, and improved marketplace resilience.
