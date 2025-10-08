# 🏥 Hospital Operations Performance Analysis (India, 2023)
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

# Data structure & Initial check
The hospital’s database is organized into a relational schema of five core tables — appointments, billing, doctors, patients, and treatments. Together, these data tables provide a 360° view of hospital operations, covering patient activity, financial transactions, hospital performance, and resource utilization.

<img width="956" height="527" alt="ERD (Hospital Management)" src="https://github.com/user-attachments/assets/1c0b77ca-f73b-4a24-b1a4-a070659de8ac" />

A total of 200 appointment records were analyzed, linking 48 unique patients to 10 doctors across three hospital branches. Each table plays a distinct but interconnected role within the hospital management system:

| Table            | Description                                                            | Purpose                                                            |
| ---------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------ |
| **Appointments** | Tracks appointment date, patient attendance, and the status            | Foundation for operational and utilization analysis.               |
| **Billing**      | Records payment methods, amount billed, and payment status.            | Used to assess revenue realization and collection efficiency.      |
| **Doctors**      | Contains doctor profiles, specialization, and experience.              | Supports performance and utilization analysis.                     |
| **Patients**     | Stores patient demographics and identifiers.                           | Enables segmentation and behavioral insight.                       |
| **Treatments**   | Details the treatment type, description, cost, and linked appointment. | Core input for treatment-level cost and revenue analysis.          |


# Executive Summary and Key take aways
Number of Patients: Only 48 patients book and take part in appointments in the system; 200 appointments recorded.
Appointment outcomes present a critical area for operational improvement. Only 23% of appointments are completed, while 51.5% result in cancellations or no-shows, indicating a high attrition rate and inefficient utilization of clinical capacity. Most missed appointments are concentrated in consultations, therapy, and follow-up visits—accounting for 67 out of 103 cancelled or no-show cases. Despite this, 33.15% of these patients had already made advance payments, representing both a service delivery gap and a potential patient satisfaction risk. Immediate focus on reducing cancellations and no-shows could significantly enhance both patient throughput and revenue realization.
- High attrition rate: Over 51.5% of appointments result in cancellations or no-shows.
- Low completion efficiency: Only 23% of appointments reach completion.
- Concentrated problem areas: Consultations, therapy, and follow-ups make up 65%+ of missed visits.
- Financial leakage: About 33.15% of cancelled or no-show appointments were already paid in advance, creating operational and customer-experience risk.
- Opportunity: A 10–15% reduction in no-shows could significantly improve utilization, revenue, and patient satisfaction.


Collection performance is the second biggest drag as Overall payment and revenue conversion performance reveal clear disparities across hospital branches and payment methods.
- Central Hospital outperforms all branches with the highest realized and potential revenue across payment modes, achieving a cash conversion rate of 1.14 — indicating timely collections and strong front-desk processes.
- Eastside Clinic maintains stable but moderate conversion rates (0.51–0.97), reflecting consistent operations but room to tighten payment capture, especially in cash transactions.
- Westside Clinic, however, exhibits the weakest conversion efficiency (0.32–0.63), with lower realized revenue relative to potential, suggesting delays or leakage in both insurance reimbursements and credit card settlements.

When viewed by payment method, cash remains the most liquid revenue source (conversion 0.83), followed by insurance (0.70) and credit card (0.56).
This indicates that while digital and insured payments expand access, they create cash flow delays and dependency on external processes (payer approvals, clearing cycles).
- Central Hospital demonstrates the highest realized revenue and strongest cash conversion, particularly for cash and insurance payments.
- Westside Clinic shows the lowest conversion efficiency (cash conversion rates below 0.5 across methods).
- Across all branches, credit card transactions lead total realized revenue but have moderate conversion efficiency (0.56), suggesting processing or claim lag.
- Cash payments deliver better liquidity (conversion rate 0.83) compared to insurance (0.70) and credit card (0.56).
- Improving insurance claim turnaround and credit card settlement cycles could boost overall cash realization and working capital.

Finally, Doctor utilization across the hospital network reveals a mixed performance profile. While some doctors achieve high patient attendance and balanced workloads, others experience elevated no-show or cancellation rates, directly impacting operational efficiency and patient throughput.

At a branch level:

Central Hospital demonstrates strong appointment management, led by doctors like Sarah Taylor (Dermatology) and Alex Davis (Pediatrics) who consistently maintain favorable ratios — up to 4:5 show-to-no-show or better — across diverse treatments.

Eastside Clinic displays moderate utilization, with performance variance across doctors. For example, Jane Smith maintains a near-balanced ratio (e.g., 4:3, 2:3) while others, like Jane Davis, exhibit volatility by treatment type (e.g., 3:0 for MRI vs. 2:4 for Chemotherapy).

Westside Clinic faces low consistency and higher no-show patterns, especially in Oncology and Dermatology. Doctors such as Robert Davis and Linda Brown report ratios like 0:2 or 1:3, indicating repeated patient absenteeism and underuse of capacity.

This uneven distribution suggests systemic challenges in appointment reliability, follow-up management, and patient engagement, particularly for specialized treatments (Chemotherapy, Physiotherapy, and MRI).

Utilization & mix: Completions per doctor are low and uneven (e.g., top doctors only ~5–6 completed visits in the period). Demand mix skews to Checkups/Consultations/Therapy; treatment revenue concentrates in MRI, Physiotherapy, X-Ray, Chemotherapy, ECG with highest average charge per MRI (~£3.2k).


- Significant variance in doctor utilization across branches and specializations — from highly efficient practitioners with strong attendance ratios to those affected by frequent no-shows or cancellations.
- Central Hospital doctors (e.g., Sarah Taylor, Alex Davis) maintain the most balanced appointment-to-no-show ratios, indicating effective patient management and communication.
- Westside Clinic and Eastside Clinic show higher patient attrition, particularly in oncology and dermatology services, suggesting a need for operational or scheduling improvements.
- Experience alone does not guarantee higher efficiency — mid-career doctors (17–24 years) often outperform senior peers in show-up consistency.
- Targeted scheduling optimization, patient reminders, and performance benchmarking can improve both doctor utilization and appointment reliability.

# 🔍 Deep Dive Analysis
## Appointment data
The appointment data reveals a concerning imbalance in visit outcomes.
Out of all scheduled appointments:
- 23.0% were successfully completed
- 25.5% were cancelled
- 26.0% were no-shows
- 25.5% remain scheduled (yet to occur)

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
