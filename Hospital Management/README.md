# 🏥 Hospital Operations Performance Analysis (India, 2023)
## Project background
This project aim to delivers a comprehensive operational performance analysis of a multi-branch hospital network in India, consisting of Central Hospital, Eastside Clinic, and Westside Clinic. he dataset, sourced from Kaggle, covers the year 2023 and spans key operational dimensions — appointments, billing, treatments, doctors, and patients.

Despite having accumulated a wealth of operational data, the hospital network had not systematically leveraged it for performance optimization or strategic planning. This project was designed to transform that underutilized data into actionable intelligence — enabling data-driven decisions to enhance efficiency, financial outcomes, and patient experience.

Through end-to-end data analysis processes, including data extraction, cleaning, SQL-based exploration, and interactive visualization in Power BI, the analysis uncovers core performance gaps and improvement opportunities.
The resulting insights inform strategic recommendations across three critical areas:
- Operational efficiency – improving appointment completion and reducing no-shows.
- Financial performance – optimizing revenue realization and cash flow.
- Resource utilization – balancing doctor workloads and enhancing service delivery.
  
**📊 Supporting Resources**
- Datasource: [Kaggle](https://www.kaggle.com/datasets/kanakbaghel/hospital-management-dataset/data)
- Interactive Power BI Dashboard — visualize performance trends and KPIs.
- SQL Queries — scripts used for data preparation and transformation.
- Exploratory Data Analysis (EDA) — in-depth SQL-based analysis of core tables.

## Table of Contents

## Data structure & Initial check
The hospital’s database is organized into a relational schema of five core tables — appointments, billing, doctors, patients, and treatments. Together, these data tables provide a 360° view of hospital operations, covering patient activity, financial transactions, hospital performance, and resource utilization.

<img width="956" height="527" alt="ERD (Hospital Management)" src="https://github.com/user-attachments/assets/1c0b77ca-f73b-4a24-b1a4-a070659de8ac" />

A total of 200 appointment records were analyzed, linking 48 unique patients to 10 doctors across three hospital branches. Each table plays a distinct but interconnected role within the hospital management system:

| **Table**       | **Description**                                                        | **Purpose**                                                        |
| ---------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------ |
| **Appointments** | Tracks appointment date, patient attendance, and the status            | Foundation for operational and utilization analysis.               |
| **Billing**      | Records payment methods, amount billed, and payment status.            | Used to assess revenue realization and collection efficiency.      |
| **Doctors**      | Contains doctor profiles, specialization, and experience.              | Supports performance and utilization analysis.                     |
| **Patients**     | Stores patient demographics and identifiers.                           | Enables segmentation and behavioral insight.                       |
| **Treatments**   | Details the treatment type, description, cost, and linked appointment. | Core input for treatment-level cost and revenue analysis.          |

## Methodology
This project followed a structured, end-to-end analytics workflow — from raw data acquisition to insight generation and visualization. Each stage was designed to ensure data integrity, analytical rigor, and actionable outcomes for hospital performance improvement.

| **Layer**                       | **Tools / Techniques**       | **Purpose**                                                                 |
| ------------------------------- | ---------------------------- | --------------------------------------------------------------------------- |
| **Data Storage & Querying**     | SQL (MySQL)                  | Data extraction, relational modeling, and ERD-based schema validation.      |
| **Data Cleaning & Preparation** | SQL, Excel                   | Data validation, transformation, and integrity checks across linked tables. |
| **Exploratory Analysis**        | SQL (CTEs, window functions) | Identifying key trends, performance patterns, and operational drivers.      |
| **Visualization**               | Power BI                     | Building interactive dashboards and performance KPIs.                       |
| **Documentation & Reporting**   | Markdown, GitHub             | Presenting insights, methodology, and reproducible analysis.                |

## Executive Summary and Key take aways
This project analyzes the 2023 operational performance of a multi-branch hospital system in India, aiming to uncover actionable insights that enhance efficiency, financial health, and patient service quality.
The study integrates appointment, billing, treatment, and doctor performance data across Central Hospital, Eastside Clinic, and Westside Clinic, highlighting key challenges in appointment reliability, revenue conversion, and workforce utilization.

### 1️⃣ Appointment Performance & Patient Behavior

Appointment management stands out as a major operational bottleneck. Of the 200 appointments recorded, only 23% were successfully completed, while more than 51.5% were either cancelled or missed (no-shows) — a clear indicator of underutilized clinical capacity and inefficient scheduling processes.

A closer examination shows that consultations, therapy sessions, and follow-up visits account for nearly two-thirds (65%) of all cancellations or no-shows, highlighting recurring issues in routine and non-urgent appointments. Moreover, 33.15% of these missed or cancelled visits were paid for in advance, creating both a financial exposure risk and a potential source of patient dissatisfaction if refunds or rescheduling are not managed promptly and transparently.

### 2️⃣ Revenue & Collection Efficiency

An analysis of billing and collection patterns reveals strong disparities across branches and payment methods.
- Central Hospital leads performance with the highest realized revenue and a cash conversion rate of 1.14, reflecting robust billing discipline and effective front-desk collection practices.
- Eastside Clinic shows moderate consistency (conversion 0.51–0.97) but room for improvement in cash reconciliation.
- Westside Clinic underperforms, with conversion rates below 0.5 for several payment modes, suggesting delays in claim processing and weak financial follow-up.

Across payment types, cash remains the most reliable and liquid revenue stream (conversion 0.83), while insurance (0.70) and credit cards (0.56) introduce cash flow delays due to external dependencies and processing lags.

### 3️⃣ Doctor Utilization & Workforce Efficiency

Doctor performance analysis indicates uneven utilization across branches and specialties.
- Central Hospital doctors (e.g., Sarah Taylor, Alex Davis) maintain strong patient attendance ratios (up to 5:1), showcasing effective engagement and time management.
- Eastside Clinic shows mixed results, with mid-level practitioners (Jane Smith, Jane Davis) maintaining fair utilization but varying widely by treatment type.
- Westside Clinic faces low appointment consistency, particularly in Oncology and Dermatology, where repeated no-shows (ratios as low as 0:2) reduce doctor productivity and service access.

The data also suggests that experience does not always correlate with efficiency — mid-career doctors (17–24 years experience) often outperform senior peers in show-up consistency, likely due to better adaptability and patient engagement strategies.

### 🎯 Overall Insight & Opportunities
The hospital’s operational challenges stem from three interconnected inefficiencies:
- High appointment attrition, leading to underutilized clinical capacity.
- Delayed revenue realization from non-cash payment channels.
- Uneven doctor utilization, reducing patient throughput and service efficiency.

To address these issues and drive sustainable operational improvement, the hospital should adopt the following strategic approaches:
- Enhance Patient Flow Management — Implement automated reminders, flexible rescheduling, and proactive engagement to significantly reduce cancellations and no-shows.
- Standardize Financial Operations — Replicate Central Hospital’s best-in-class billing and collection practices across all branches to strengthen revenue cycle management and cash flow consistency.
- Optimize Clinical Scheduling — Use data-driven insights to rebalance doctor workloads, align treatment demand with capacity, and improve overall staff productivity.


## 🔍 Deep Dive Analysis
### Appointment data
The appointment data reveals a significant imbalance in visit outcomes, signaling both operational inefficiency and patient management challenges.

| Appointment Outcome  | Percentage | 
| -------------------- | ---------- | 
| Completed            | **23.0%**  | 
| Cancelled            | **25.5%**  | 
| No-show              | **26.0%**  | 
| Scheduled (upcoming) | **25.5%**  |

In total, 51.5% of all appointments were either cancelled or missed, representing a substantial attrition rate and inefficient resource utilization.
A deeper look shows that the majority of missed appointments originate from consultations, therapy, and follow-up visits (67 out of 103 cases) — appointment types typically considered non-urgent or easily deferrable by patients.

From a financial standpoint, 33.15% of cancelled or no-show appointments were prepaid, revealing a disconnect between financial collection and service fulfillment. This not only ties up revenue in refunds or credits but also risks patient dissatisfaction if reimbursement processes lack transparency or timeliness.

💡 Key Insights:
- The current appointment management framework is reactive, lacking proactive engagement and recovery mechanisms to minimize cancellations and no-shows.
- Lower-acuity visits (consultations, therapy, and follow-ups) exhibit the highest attrition, indicating the need for scheduling and reminder strategies.

⚙️ Recommended Actions:
1. Implement proactive patient engagement systems
- Introduce automated SMS/email reminders and in-app confirmations for upcoming visits.
- Allow patients to self-reschedule via digital channels rather than cancel outright.

2. Adopt real-time slot optimization
- Deploy an automated slot backfilling mechanism to reassign cancelled or missed appointments to waiting patients.
- Prioritize high-demand treatments (e.g., MRI, ECG) to maximize capacity utilization.

3. Align financial and operational workflows
- Integrate billing data with appointment status to automatically trigger refunds, credits, or reschedules for prepaid but unfulfilled appointments.
- Establish a clear refund turnaround SLA to maintain patient trust.








This distribution yields an attrition rate of 51.5% (cancelled + no-show), signaling substantial operational inefficiency and lost clinical time. A closer look at the cancelled and no-show segments shows that consultations, therapy sessions, and follow-up appointments represent the majority of missed visits with 67 out of 103 total cases. These categories are typically recurring or lower-acuity visits, which may be more prone to short-notice rescheduling or perceived as non-urgent by patients.

From a financial perspective, 33.15% of the affected appointments had already been paid in advance, underscoring a mismatch between financial and operational performance. This not only locks up revenue in service credits or refunds but also risks patient dissatisfaction and lower retention if rescheduling or reimbursement processes are cumbersome.

To address this, the data suggests prioritizing:
- Enhanced patient engagement for consultation and therapy appointments (reminders, digital rescheduling).
- Automated slot backfilling for last-minute cancellations.
- Transparent refund or credit policies to maintain patient trust for prepaid visits.
- Reducing the no-show and cancellation rate even by 10–15 percentage points could deliver a marked improvement in resource utilization, patient satisfaction, and cash flow reliability.

## Conversion rate
1️⃣ Branch-Level Performance

Central Hospital dominates total collections with the highest total paid (≈ £40k) and conversion > 1.0, showing that revenue realization occasionally exceeds expected potential — likely due to advance collections or bundled service payments.

Eastside Clinic records strong potential revenue (£22.9k) but only partial realization (conversion ≤ 0.97), indicating manageable but improvable billing follow-up processes.

Westside Clinic, by contrast, underperforms across all payment types, particularly insurance (0.32 conversion rate) and credit card (0.37), flagging inefficiencies in claim processing or reconciliations.

2️⃣ Payment Method Efficiency
Payment Method	Total Paid (£)	Realized Revenue (£)	Potential Realized (£)	Conversion Rate	Interpretation
Cash	52,691	23,112	40,052	0.83	Strongest liquidity driver; efficient front-end capture.
Credit Card	60,377	61,435	45,731	0.56	Highest gross revenue but slower conversion due to processing lag.
Insurance	60,356	39,553	46,644	0.70	Moderate; reimbursement cycle length affects cash flow.

While card and insurance channels represent ~70% of total billed value, they contribute to working capital friction because funds are recognized but not immediately realized.

3️⃣ Operational Interpretation

Central Hospital’s systems and collection discipline can be benchmarked as best practice, particularly in cash handling and patient billing verification.

Westside’s low efficiency likely stems from weak claim follow-up or inconsistent reconciliation, causing under-realization against billed amounts.

Insurance-based delays across clinics highlight the need for prior authorization, real-time eligibility checks, and claim tracking automation.

⚙️ Actionable Insights & Recommendations
Focus Area	Issue Identified	Recommended Action	Expected Outcome
Billing Operations	High variation in conversion rates between branches	Standardize billing workflows, reconciliation cutoffs, and daily cash closures	Uniform revenue recognition, fewer billing disputes
Insurance Claims	Lag in reimbursement (avg. conversion ≤ 0.7)	Implement claim automation & payer follow-up dashboards	15–20% faster reimbursement cycle
Payment Method Mix	Overdependence on non-cash payments delays cash flow	Incentivize same-day settlements and early pay discounts	Improved liquidity, reduced DSO
Branch Accountability	Westside underperformance	Introduce monthly collection KPIs and audit variance reports	Increased accountability and revenue recovery

## Doctor utilization
1️⃣ Utilization by Branch and Specialization
Branch	Performance Summary	Key Observations
Central Hospital	Highest doctor utilization and patient show-up rates.	Consistent ratios (e.g., Alex Davis: 5:1, Sarah Taylor: 4:5) show effective patient engagement and time management.
Eastside Clinic	Mixed performance — some high attendance, some underuse.	Jane Smith and Jane Davis handle high volumes but exhibit volatility across treatment types. Suggests inconsistency in patient adherence or scheduling.
Westside Clinic	Lowest utilization, frequent no-shows.	Robert Davis and Linda Brown record multiple zero or low show ratios (e.g., 0:2, 1:3). Indicates patient follow-up or appointment discipline issues.
2️⃣ Patterns by Treatment Type

Physiotherapy and Chemotherapy sessions have the highest cancellation and no-show rates, across multiple doctors and clinics.

ECG and MRI treatments show better attendance consistency, often above a 2:1 ratio, suggesting patients view them as more critical or time-bound procedures.

X-Ray sessions demonstrate medium adherence, potentially due to being short-duration, low-urgency appointments.

3️⃣ Experience vs. Utilization

Senior doctors (25+ years experience, e.g., David Jones, Sarah Taylor) maintain good ratios but show higher patient volatility by treatment type, implying dependency on appointment type rather than tenure.

Mid-level doctors (17–24 years) such as David Taylor and Jane Davis often achieve steady utilization, reflecting balanced workloads and adaptability.

Less-experienced doctors (≤10 years, e.g., Linda Brown) show inconsistent ratios and lower patient adherence, pointing to the need for structured mentoring and scheduling support.

⚙️ Actionable Insights & Recommendations
Focus Area	Issue Identified	Recommended Action	Expected Outcome
Branch-Level Scheduling	Westside & Eastside have poor attendance ratios	Introduce automated reminders and patient pre-confirmations	15–20% reduction in no-shows
Doctor Performance Management	Variance in appointment-to-show ratios	Implement performance dashboard with monthly utilization KPIs	Improved accountability and resource planning
Treatment Prioritization	High no-show in therapy and chemo sessions	Use penalty/rescheduling fees or incentives for on-time attendance	Increased appointment reliability
Training & Patient Communication	Low ratios among junior doctors	Provide engagement training and shadowing with high-performing doctors	Better patient relationships and reduced cancellations
