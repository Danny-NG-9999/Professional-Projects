# Branch
CREATE OR REPLACE VIEW overview AS
WITH first_rows AS (
  SELECT p.patient_id, p.gender, p.date_of_birth, p.insurance_provider, p.registration_date AS first_registration_date,
	EXTRACT(YEAR FROM p.registration_date) AS registration_year, d.hospital_branch, d.doctor_id,
    ROW_NUMBER() OVER (PARTITION BY p.patient_id ORDER BY p.registration_date ASC, d.doctor_id) AS rn
  FROM hospital_management.patients AS p
  JOIN hospital_management.appointments AS a ON p.patient_id = a.patient_id
  JOIN hospital_management.doctors AS d ON a.doctor_id = d.doctor_id)
SELECT fr.registration_year, fr.hospital_branch, fr.gender, fr.patient_id, fr.insurance_provider,
  fr.doctor_id, fr.first_registration_date,
  ROUND(EXTRACT(YEAR FROM fr.first_registration_date) - EXTRACT(YEAR FROM fr.date_of_birth), 0) AS age_at_registration
FROM first_rows AS fr
WHERE fr.rn = 1
ORDER BY fr.registration_year, fr.hospital_branch, fr.gender DESC, fr.patient_id;

# Branch revenue
CREATE OR REPLACE VIEW branch_revenue AS
SELECT d.hospital_branch, t.treatment_type, t.description AS treatment_description,
	p.patient_id, p.insurance_provider, d.doctor_id, a.appointment_id, t.treatment_id, a.status, b.payment_method, b.payment_status,
    ROUND(SUM(b.amount),2) AS total_revenue,
    ROUND(SUM(CASE WHEN a.status='Completed' THEN t.cost ELSE 0 END),2) AS realized_revenue,
    ROUND(SUM(CASE WHEN a.status='Scheduled' THEN t.cost ELSE 0 END),2) AS pending_revenue,
    ROUND(SUM(CASE WHEN a.status IN ('No-show','Cancelled') THEN t.cost ELSE 0 END),2) AS unearned_revenue
FROM hospital_management.patients p
JOIN hospital_management.appointments a ON p.patient_id=a.patient_id
JOIN hospital_management.doctors d ON a.doctor_id=d.doctor_id
JOIN hospital_management.treatments t ON a.appointment_id=t.appointment_id
JOIN hospital_management.billing b ON b.treatment_id=t.treatment_id
GROUP BY d.hospital_branch, t.treatment_type, t.description, p.patient_id, d.doctor_id, a.status, a.appointment_id, t.treatment_id, b.payment_method, b.payment_status, p.insurance_provider
ORDER BY d.hospital_branch, t.treatment_type, t.treatment_type, total_revenue DESC;

# Doctor overview
CREATE OR REPLACE VIEW doctor_overview AS
SELECT d.hospital_branch, d.specialization, t.treatment_type, d.doctor_id,
    -- Total doctors and average experience
    ROUND(AVG(d.years_experience), 1) AS avg_years_experience,
    -- Total unique patients treated by doctors in this branch & specialization
    COUNT(DISTINCT a.patient_id) AS total_patients_served,
    -- Average patients per doctor
    COALESCE(ROUND(COUNT(DISTINCT a.patient_id) / NULLIF(COUNT(DISTINCT d.doctor_id), 0), 2), 0) AS avg_patients_per_doctor,
    -- Total & average appointments handled
    COUNT(a.appointment_id) AS total_appointments, COALESCE(ROUND(COUNT(a.appointment_id) / NULLIF(COUNT(DISTINCT d.doctor_id), 0), 2), 0) AS avg_appointments_per_doctor,
    -- Revenue metrics (linked through treatments)
    COALESCE(ROUND(SUM(t.cost), 2), 0) AS total_revenue_generated,
    COALESCE(ROUND(SUM(t.cost) / NULLIF(COUNT(DISTINCT d.doctor_id), 0), 2), 0) AS avg_revenue_per_doctor
FROM hospital_management.doctors AS d
INNER JOIN hospital_management.appointments AS a ON a.doctor_id = d.doctor_id
INNER JOIN hospital_management.treatments AS t ON t.appointment_id = a.appointment_id
GROUP BY d.hospital_branch, d.specialization, t.treatment_type, d.doctor_id
ORDER BY d.hospital_branch, d.specialization, total_revenue_generated DESC;

# Billing
CREATE OR REPLACE VIEW billing_overview AS
SELECT d.hospital_branch, t.treatment_type, t.description, COALESCE(b.payment_method,'Unknown') AS payment_method,
	COALESCE(b.payment_status,'Unknown') AS payment_status, d.doctor_id,
  CASE
    WHEN b.payment_method='Insurance' THEN COALESCE(p.insurance_provider,'Not Specified')
    WHEN b.payment_method='Credit Card' THEN 'Credit Card'
    WHEN b.payment_method='Cash' THEN 'Cash'
    ELSE 'N/A'
  END AS insurance_providers,
  p.patient_id, a.appointment_id, t.treatment_id, COALESCE(ROUND(SUM(b.amount),2),0) AS total_billed_amount,
  COALESCE(ROUND(SUM(CASE WHEN b.payment_status='Paid'    THEN b.amount ELSE 0 END),2),0) AS collected_revenue,
  COALESCE(ROUND(SUM(CASE WHEN b.payment_status='Pending' THEN b.amount ELSE 0 END),2),0) AS pending_revenue,
  COALESCE(ROUND(SUM(CASE WHEN b.payment_status='Failed'  THEN b.amount ELSE 0 END),2),0) AS failed_revenue,
  DATE_FORMAT(b.bill_date,'%Y-%m') AS billing_month
FROM hospital_management.billing      b
JOIN hospital_management.treatments   t ON b.treatment_id = t.treatment_id
JOIN hospital_management.appointments a ON a.appointment_id = t.appointment_id
JOIN hospital_management.doctors      d ON d.doctor_id     = a.doctor_id
JOIN hospital_management.patients     p ON p.patient_id    = a.patient_id
GROUP BY d.hospital_branch, b.payment_method, b.payment_status, d.doctor_id, insurance_providers,
  p.patient_id, a.appointment_id, t.treatment_id, t.treatment_type, t.description, billing_month
ORDER BY d.hospital_branch, t.treatment_type, t.description, b.payment_method, billing_month, total_billed_amount DESC;

# Patients and operation
## Top 10 patients in the system
CREATE OR REPLACE VIEW top10_customers AS
WITH top10 AS (
SELECT d.hospital_branch, t.treatment_type, t.description, p.gender,
      /* show insurer name only when payment is Insurance; else show method */
      CASE
        WHEN b.payment_method = 'Insurance'              THEN COALESCE(p.insurance_provider,'Not Specified')
        WHEN b.payment_method IN ('Cash','Credit Card')  THEN b.payment_method
        ELSE 'Unknown'
      END AS insurance_provider_display,
      p.patient_id, CONCAT(p.first_name,' ',p.last_name) AS patient_name, ROUND(SUM(COALESCE(b.amount,0)),2) AS total_billed_amount
  FROM hospital_management.patients     p
  JOIN hospital_management.appointments a ON p.patient_id   = a.patient_id
  JOIN hospital_management.doctors      d ON a.doctor_id    = d.doctor_id
  JOIN hospital_management.treatments   t ON a.appointment_id = t.appointment_id
  LEFT JOIN hospital_management.billing b ON b.treatment_id = t.treatment_id
  WHERE a.status IN ('Completed','Scheduled','Cancelled','No-Show')
  GROUP BY d.hospital_branch, t.treatment_type, t.description, p.gender, insurance_provider_display, p.patient_id, patient_name
  ORDER BY total_billed_amount DESC
  LIMIT 10)
  
SELECT t10.hospital_branch, t10.treatment_type, t10.description AS treatment_description, t10.gender,
	 t10.patient_id, t10.patient_name, a.appointment_id, t.treatment_id, a.status AS appointment_status,
     COALESCE(b.payment_status,'Unknown') AS payment_status, COALESCE(b.payment_method,'Unknown') AS payment_method,
     t10.insurance_provider_display AS insurance_provider, COALESCE(a.reason_for_visit, t.description) AS reason_for_visit,
     t.cost AS treatment_cost, b.amount AS billed_amount, a.appointment_date, t10.total_billed_amount AS patient_total_billed_amount
FROM top10 t10
JOIN hospital_management.appointments a ON a.patient_id = t10.patient_id
JOIN hospital_management.treatments  t ON t.appointment_id = a.appointment_id
LEFT JOIN hospital_management.billing b ON b.treatment_id = t.treatment_id
JOIN hospital_management.patients p ON p.patient_id = a.patient_id
JOIN hospital_management.doctors  d ON d.doctor_id = a.doctor_id
WHERE a.status IN ('Completed','Scheduled','Cancelled','No-Show')
  AND d.hospital_branch = t10.hospital_branch
  AND t.treatment_type = t10.treatment_type
  AND t.description = t10.description
  /* keep the same insurance-provider display as in the Top10 grouping */
  AND(
      CASE
        WHEN b.payment_method = 'Insurance'              THEN COALESCE(p.insurance_provider,'Not Specified')
        WHEN b.payment_method IN ('Cash','Credit Card')  THEN b.payment_method
        ELSE 'Unknown'
      END) = t10.insurance_provider_display
ORDER BY t10.total_billed_amount DESC, t10.patient_id, a.appointment_date DESC;

## Top 10 by branch
CREATE OR REPLACE VIEW top10_customersbranch AS
WITH customer_totals AS (
  SELECT d.hospital_branch, p.patient_id, CONCAT(p.first_name,' ',p.last_name) AS patient_name, SUM(COALESCE(b.amount,0)) AS total_billed_amount,
      ROW_NUMBER() OVER (PARTITION BY d.hospital_branch ORDER BY SUM(COALESCE(b.amount,0)) DESC) AS rn
  FROM hospital_management.patients     p
  JOIN hospital_management.appointments a ON p.patient_id     = a.patient_id
  JOIN hospital_management.doctors      d ON a.doctor_id      = d.doctor_id
  JOIN hospital_management.treatments   t ON a.appointment_id = t.appointment_id
  LEFT JOIN hospital_management.billing b ON b.treatment_id   = t.treatment_id
  WHERE a.status IN ('Completed','Scheduled','Cancelled','No-Show')
  GROUP BY d.hospital_branch, p.patient_id, patient_name),
top10 AS (
  SELECT * FROM customer_totals
  WHERE rn <= 10)
  
SELECT t10.hospital_branch, t10.patient_id, t10.patient_name, a.appointment_id,
	t.treatment_id, a.status AS appointment_status, COALESCE(b.payment_status,'Unknown') AS payment_status,
  COALESCE(b.payment_method,'Unknown') AS payment_method,
  CASE
    WHEN b.payment_method = 'Insurance'             THEN COALESCE(p.insurance_provider,'Not Specified')
    WHEN b.payment_method IN ('Cash','Credit Card') THEN b.payment_method
    ELSE 'Unknown'
  END                                              AS insurance_provider,
  COALESCE(a.reason_for_visit, t.description)      AS reason_for_visit,
  t.treatment_type, t.description AS treatment_description, t.cost AS treatment_cost, b.amount AS billed_amount,
  a.appointment_date, ROUND(t10.total_billed_amount, 2) AS patient_total_billed_amount
FROM top10 t10
JOIN hospital_management.appointments a  ON a.patient_id     = t10.patient_id
JOIN hospital_management.treatments  t   ON t.appointment_id = a.appointment_id
LEFT JOIN hospital_management.billing b   ON b.treatment_id   = t.treatment_id
JOIN hospital_management.patients p       ON p.patient_id     = a.patient_id
JOIN hospital_management.doctors  d       ON d.doctor_id      = a.doctor_id
WHERE a.status IN ('Completed','Scheduled','Cancelled','No-Show') AND d.hospital_branch = t10.hospital_branch
ORDER BY t10.hospital_branch, t10.total_billed_amount DESC, t10.patient_id, a.appointment_date DESC;

# Branch details
CREATE OR REPLACE VIEW top10_customersbranch AS
WITH detail AS (
  SELECT
    d.hospital_branch, t.treatment_type, t.description AS treatment_description, p.gender, p.patient_id,
    CONCAT(p.first_name,' ',p.last_name) AS patient_name, a.appointment_id, t.treatment_id,
    a.status AS appointment_status, COALESCE(b.payment_status,'Unknown') AS payment_status, COALESCE(b.payment_method,'Unknown') AS payment_method,
    /* If payment is Insurance, show the insurer; else show the method (Cash / Credit Card) */
    CASE
      WHEN b.payment_method = 'Insurance'             THEN COALESCE(p.insurance_provider,'Not Specified')
      WHEN b.payment_method IN ('Cash','Credit Card') THEN b.payment_method
      ELSE 'Unknown'
    END AS insurance_providers,
    COALESCE(a.reason_for_visit, t.description)      AS reason_for_visit,
    t.cost                                           AS treatment_cost,
    b.amount                                         AS billed_amount, a.appointment_date,
    /* Patient total billed amount (across all their rows) */
    ROUND(SUM(COALESCE(b.amount,0)) OVER (PARTITION BY p.patient_id), 2) AS patient_total_billed_amount
  FROM hospital_management.patients     p
  JOIN hospital_management.appointments a ON p.patient_id     = a.patient_id
  JOIN hospital_management.doctors      d ON a.doctor_id      = d.doctor_id
  JOIN hospital_management.treatments   t ON a.appointment_id = t.appointment_id
  LEFT JOIN hospital_management.billing b ON b.treatment_id   = t.treatment_id
  WHERE a.status IN ('Completed','Scheduled','Cancelled','No-Show'))
SELECT *
FROM detail
ORDER BY hospital_branch, patient_total_billed_amount DESC, patient_id, appointment_date DESC;



# Doctor ultilization
CREATE OR REPLACE VIEW doctor_load_details AS
SELECT d.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS doctor_name, d.specialization, d.hospital_branch,
	a.appointment_id, a.patient_id, a.status AS appointment_status, a.appointment_date,
    t.treatment_id, t.treatment_type, t.description AS treatment_description, t.cost AS treatment_cost,
    COALESCE(b.payment_method,'Unknown') AS payment_method, COALESCE(b.payment_status,'Unknown') AS payment_status,
    b.amount AS billed_amount, b.bill_date,
  -- Show insurer when method is Insurance; otherwise show the method (Cash / Credit Card / etc.)
	CASE
		WHEN COALESCE(b.payment_method,'Unknown') = 'Insurance'
		THEN COALESCE(p.insurance_provider,'Not Specified')
		ELSE COALESCE(b.payment_method,'Unknown')
    END AS insurance_providers
FROM hospital_management.doctors d
JOIN hospital_management.appointments a ON d.doctor_id = a.doctor_id
JOIN hospital_management.treatments t ON a.appointment_id = t.appointment_id
LEFT JOIN hospital_management.billing b ON b.treatment_id = t.treatment_id
LEFT JOIN hospital_management.patients p ON p.patient_id = a.patient_id
WHERE a.status IN ('Completed','Scheduled','Cancelled','No-Show')
ORDER BY d.hospital_branch, d.doctor_id, b.amount DESC, t.treatment_id;