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
- Datasource: [Download the data here](https://www.kaggle.com/datasets/kanakbaghel/hospital-management-dataset/data)
- Dashboard: [Interactive Power BI Dashboard file](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/Hospital%20Management/hospital_management(completed).pbix)
- Dashboard: [Git project format for PowerBI](https://github.com/Danny-NG-9999/Professional-Projects/tree/main/Hospital%20Management/gitproject%20format)
- Exploratory Data Analysis (EDA): [In-depth SQL-based analysis of core tables](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/Hospital%20Management/EDA%20(hospital_management).sql)
- [SQL Queries — scripts used for data transformation and PowerBI visualization modelling](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/Hospital%20Management/Hospital%20analysis.sql)
- [Preview of the dashboard in PDF format](https://github.com/Danny-NG-9999/Professional-Projects/blob/main/Hospital%20Management/hospital_management(completed).pdf)

<img width="1904" height="1065" alt="image" src="https://github.com/user-attachments/assets/1f600ef9-d93d-412a-8a8b-85947126faa0" />
  
## Table of Contents

- [Data Structure & Initial Check](#data-structure--initial-check)
- [Methodology](#methodology)
- [Executive Summary and Key Takeaways](#executive-summary-and-key-take-aways)
- [Deep Dive Analysis](#-deep-dive-analysis)
   - [Appointment Data](#appointment-data)
   - [Revenue Conversion & Financial Efficiency](#revenue-conversion--financial-efficiency)
   - [Doctor Utilization & Workforce Efficiency](#doctor-utilization--workforce-efficiency)
- [Conclusion](#-conclusion)
- [Acknowledgements & Support](#acknowledgements--support)

---

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

---

## Methodology
This project followed a structured, end-to-end analytics workflow — from raw data acquisition to insight generation and visualization. Each stage was designed to ensure data integrity, analytical rigor, and actionable outcomes for hospital performance improvement.

| **Layer**                       | **Tools / Techniques**       | **Purpose**                                                                 |
| ------------------------------- | ---------------------------- | --------------------------------------------------------------------------- |
| **Data Storage & Querying**     | SQL (MySQL)                  | Data extraction, relational modeling, and ERD-based schema validation.      |
| **Data Cleaning & Preparation** | SQL, Excel                   | Data validation, transformation, and integrity checks across linked tables. |
| **Exploratory Analysis**        | SQL (CTEs, window functions) | Identifying key trends, performance patterns, and operational drivers.      |
| **Visualization**               | Power BI                     | Building interactive dashboards and performance KPIs.                       |
| **Documentation & Reporting**   | Markdown, GitHub             | Presenting insights, methodology, and reproducible analysis.                |

---
## Executive Summary and Key Takeaways
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

- Doctor performance analysis reveals uneven utilization across branches and specialties. Central Hospital leads in workload but faces notable no-shows and cancellation leakage, Eastside Clinic maintains steady engagement, while Westside Clinic suffers from chronic underutilization and patient disengagement.
- Treatment trends show the highest no-show rates in Physiotherapy and Chemotherapy (elective and long-duration treatments), whereas ECG and MRI maintain the strongest attendance due to their diagnostic urgency.
- Across experience levels, mid-career doctors (17–24 years) demonstrate the most consistent patient engagement, outperforming both senior and junior colleagues—highlighting that experience alone does not guarantee efficiency, but adaptability and proactive communication do.

### 🎯 Overall Insight & Opportunities
The hospital’s operational challenges stem from three interconnected inefficiencies:
- High appointment attrition, leading to underutilized clinical capacity.
- Delayed revenue realization from non-cash payment channels.
- Uneven doctor utilization, reducing patient throughput and service efficiency.

To address these issues and drive sustainable operational improvement, the hospital should adopt the following strategic approaches:
- Enhance Patient Flow Management — Implement automated reminders, flexible rescheduling, and proactive engagement to significantly reduce cancellations and no-shows.
- Standardize Financial Operations — Replicate Central Hospital’s best-in-class billing and collection practices across all branches to strengthen revenue cycle management and cash flow consistency.
- Optimize Clinical Scheduling — Use data-driven insights to rebalance doctor workloads, align treatment demand with capacity, and improve overall staff productivity.

---

## Deep Dive Analysis
### Appointment Data
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
- Personalize reminders based on appointment type (e.g., therapy) to improve show-up rates.

2. Adopt real-time slot optimization
- Deploy an automated slot backfilling mechanism to reassign cancelled or missed appointments to waiting patients.
- Prioritize high-demand treatments (e.g., MRI, ECG) to maximize capacity utilization.

3. Align financial and operational workflows
- Integrate billing data with appointment status to automatically trigger refunds, credits, or reschedules for prepaid but unfulfilled appointments.
- Establish a clear refund turnaround SLA to maintain patient trust.
- Introduce a centralized financial reconciliation dashboard to monitor prepaid and unserved appointments in real time.

### Revenue Conversion & Financial Efficiency

**Payment Method Efficiency**

Despite non-cash channels (credit card and insurance) representing nearly 70% of total billed revenue, they are the slowest to convert into available cash, leading to working capital friction and reduced reinvestment capacity.


| Payment Method  | Total Paid (£) | Realized Revenue (£) | Potential Revenue (£) | Conversion Rate | Interpretation                                                                                                          |
| --------------- | -------------- | -------------------- | --------------------- | --------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Cash**        | 52,691.30      | 23,111.72            | 40,051.96             | **0.83**        | The most reliable and liquid payment channel with minimal processing delays; strong front-end collection.               |
| **Credit Card** | 60,377.11      | 61,435.22            | 45,730.88             | **0.56**        | Generates the highest transaction volume but experiences slower realization due to settlement lags and processing fees. |
| **Insurance**   | 60,356.49      | 39,553.52            | 46,643.86             | **0.70**        | Moderate performance constrained by claim approval timelines and administrative bottlenecks.                            |



**Branch level performance**

The branch-level analysis reveals notable disparities in revenue realization (realized + potentential realized) and cash conversion efficiency across the hospital network. While all three branches contribute significantly to total revenue, their collection consistency and financial discipline vary sharply by payment type.
Central Hospital leads overall in financial strength, driven by effective insurance and cash management. Eastside Clinic performs steadily but lacks uniformity across channels, while Westside Clinic continues to underperform across all payment methods, signaling systemic inefficiencies in cash flow management and claim follow-up.


| **Branch**           | **Cash** | **Insurance** | **Credit Card** | **Key Interpretation**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| -------------------- | -------- | ------------- | --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Central Hospital** | **0.91** | **1.14**      | **0.51**        | **Strong but Uneven Performer.** Central Hospital sets the financial benchmark with the **highest overall conversion efficiency** among all branches. Exceptional insurance realization (114%) indicates effective **advance billing and claims processing**, while cash transactions remain strong (91%), reflecting well-managed front-desk collections. However, a notably weaker credit card conversion (51%) suggests potential inefficiencies in **digital payment reconciliation** or **settlement delays**, which should be addressed to achieve balanced revenue performance across payment channels. |
| **Eastside Clinic**  | **0.97** | **0.56**      | **0.49**        | **Operationally Inconsistent.** Eastside Clinic demonstrates **excellent cash management** (97%), showing disciplined front-line collection practices. Yet, lower performance in insurance (56%) and credit card transactions (49%) reveals dependence on immediate cash payments and challenges in managing **external claims and digital settlements**. This uneven profile highlights the need for **stronger back-office coordination** and **claim follow-up automation** to capture delayed or unprocessed revenue.                                                                                      |
| **Westside Clinic**  | **0.37** | **0.32**      | **0.63**        | **Underperforming Branch with Systemic Gaps.** Westside Clinic exhibits severe underperformance in cash (37%) and insurance (32%) conversion, indicating major gaps in billing oversight, claim management, and reconciliation control. While credit card conversion (63%) is notably higher, it alone fails to offset the systemic weaknesses observed in other payment channels. The data points to a breakdown in operational discipline across both front-desk and administrative functions, necessitating immediate corrective action, staff retraining, and stronger accountability frameworks to mitigate ongoing revenue leakage. |          

💡 Key Insights
- Branch-level inconsistency in collection efficiency highlights the absence of a standardized collection framework or a unified financial governance model.
- Cash transactions remain the most dependable source of liquidity, providing immediate revenue realization and minimal processing friction.
- In contrast, credit and insurance payments, though beneficial for patient access, introduce external processing dependencies that slow overall revenue realization and impact working capital efficiency\
- Central Hospital’s strong front-office and reconciliation discipline demonstrates how structured financial operations can drive superior cash flow performance. Its data-driven collection model should be replicated across all branches to ensure consistency and maximize revenue efficiency.

⚙️ Recommended Actions
1. Standardize Billing Workflows
- Establish a unified billing protocol and consistent documentation standards across all branches.
- Deploy automated reconciliation dashboards for daily monitoring and branch-level variance tracking.

2. Streamline Insurance Claims
- Deploy an automated claims tracking system with real-time monitoring, escalation alerts, and integrated payer dashboards.
- Establish clear SLAs for claim processing and reimbursement timelines to ensure timely follow-ups and staff accountability.

3. Optimize Payment Mix
- Promote same-day or upfront payments through targeted incentives, such as small discounts or loyalty programs, to optimize cash flow and minimize collection delays.
- Reduce dependence on slow-clearing insurance and credit card partners by diversifying payment partnerships and streamlining processes to enhance revenue efficiency.

4. Branch Accountability Framework
- Establish monthly revenue and collection KPIs by branch and payment type to track performance and identify leakages.
- Benchmark all branches against Central Hospital’s best-practice cash flow model to drive consistency and operational excellence.


### Doctor Utilization & Workforce Efficiency
Across the network, Pediatrics and Dermatology remain the most represented and highest-volume specialties, while Oncology shows persistent attendance challenges—likely due to longer treatment cycles and higher patient fatigue rates.

| Metric                                | Observation                                           |
| ------------------------------------- | ----------------------------------------------------- |
| **Total Doctors Analyzed**            | 10                                                    |
| **Average Show-Up Rate**              | ~48%                                                  |
| **Average No-Show/Cancellation Rate** | ~52%                                                  |
| **Highest Total Appointments**        | Sarah Taylor (29), Alex Davis (24), David Taylor (25) |
| **Most Balanced Attendance**          | Jane Davis (12:9), Linda Wilson (11:8)                |
| **Lowest Utilization**                | Robert Davis (6:7), David Jones (6:8)                 |


1️⃣ **Central Hospital**
Central Hospital manages the highest appointment volume with generally balanced attendance ratios, though cancellations remain a challenge.
- Sarah Taylor (Dermatology): Leads with 29 appointments (14:15 show-to-no-show ratio), reflecting strong demand but notable cancellations.
- Alex Davis (Pediatrics): Achieves a balanced 12:12 ratio across 24 appointments, indicating consistent engagement.
- David Jones (Pediatrics): Records a moderate 6:8 ratio, suggesting follow-up adherence issues.
- Sarah Smith (Pediatrics): Shows a 7:10 ratio, pointing to the need for improved patient communication.

2️⃣ **Eastside Clinic**
Eastside Clinic exhibits moderate attendance with stable scheduling performance, particularly for routine treatments.
- Jane Davis (Pediatrics) and Jane Smith (Pediatrics): Manage 21–22 appointments each with near-even ratios (12:9 and 11:11), reflecting reliable engagement.
- Linda Wilson (Oncology): Maintains a positive 11:8 ratio, indicating consistent patient attendance.

3️⃣ **Westside Clinic**
Westside Clinic struggles with significant cancellations and no-shows, leading to underutilized staff and reduced throughput.
- David Taylor (Dermatology): Handles 25 appointments but with an 11:14 ratio, among the highest no-show rates.
- Linda Brown (Dermatology) and Robert Davis (Oncology): Report suboptimal ratios (7:9 and 6:7), reflecting persistent disengagement.

**Treatment-Level Trends**
- Highest no-show rates: Physiotherapy, Chemotherapy — elective or long-term treatments prone to drop-offs.
- Most reliable attendance: ECG and MRI — perceived as essential diagnostics with higher patient urgency.
- Moderate adherence: X-Ray — lower urgency, often rescheduled.

**Experience vs. Efficiency**
- Senior doctors (25+ years): Strong experience but variable attendance rates across treatment types.
- Mid-career doctors (17–24 years): Most consistent and adaptive, with steady patient show-up rates.
- Junior doctors (≤10 years): Inconsistent engagement, indicating the need for mentoring and structured scheduling systems.

⚙️ Recommended Actions
- Doctor Performance Management: Introduce KPIs and interactive dashboards to monitor utilization, improving workload balance and accountability.
- Treatment Prioritization: Use incentives and automated reminders for high no-show treatments (e.g., Physiotherapy, Chemotherapy) to boost adherence.
- Training and Mentorship: Offer shadowing opportunities with top-performing doctors to enhance junior doctors’ patient engagement skills.
- Implementing automated scheduling systems, standardized follow-up protocols, and performance monitoring to reduce cancellations, enhance resource utilization, and improve patient experience across the network.

---
## Conclusion

The 2023 operational analysis of the hospital network provides clear, data-backed insights into performance strengths and inefficiencies across branches, payment systems, and clinical operations. While the hospital demonstrates strong patient activity and diverse service offerings, several systemic challenges limit its overall efficiency and financial realization.

### Strategic Takeaways
- **Operational Efficiency:** High appointment attrition (51.5%) and underutilized doctor capacity indicate the need for proactive patient engagement, automated reminders, and smarter scheduling tools. Reducing no-shows by even 10–15% can yield immediate gains in productivity and patient throughput.
- **Financial Management:** Revenue conversion remains uneven across branches, with cash performing best (conversion 0.83) and insurance and credit card channels lagging. Standardizing billing workflows and automating claims can strengthen cash flow and ensure consistent revenue recognition.
- **Resource Optimization:** Doctor utilization varies widely between branches and experience levels. Central Hospital leads with effective workload balance, while Westside Clinic requires better patient retention and operational controls. Performance dashboards and incentive-linked KPIs can help align staff productivity with hospital goals.

### Future Recommendations
- **Digital Transformation:** Integrate patient engagement platforms with automated appointment reminders, online payments, and real-time rescheduling features to improve attendance reliability.  
- **Revenue Cycle Automation:** Deploy integrated billing and claim tracking systems to monitor collections, accelerate reimbursements, and reduce unrealized revenue.  
- **Performance Governance:** Establish data-driven KPIs for branch managers and doctors to monitor utilization, patient satisfaction, and collection efficiency.  
- **Operational Benchmarking:** Use Central Hospital’s strong cash conversion and collection processes as the blueprint for Eastside and Westside Clinics to ensure uniform best practices.  
- **Continuous Monitoring:** Maintain a Power BI–based executive dashboard to track performance trends, enabling leadership to respond quickly to emerging inefficiencies.

---
## Acknowledgements & Support
**Author:** [Daniel (Viet) Nguyen]([https://github.com/your-github-username](https://github.com/Danny-NG-9999))  
**Copyright:** © 2025 Daniel (Viet) Nguyen. All rights reserved.  

If you found this project useful or insightful, please **consider giving it a ⭐ on GitHub** — your support helps me continue creating open-source projects and sharing knowledge!  
