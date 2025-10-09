SELECT * FROM hospital_management.patients;
SELECT * FROM hospital_management.treatments;
SELECT * FROM hospital_management.appointments;
SELECT * FROM hospital_management.billing;
SELECT * FROM hospital_management.doctors;

# Check for Missing or Null Values
SELECT COUNT(DISTINCT a.appointment_id) AS total_records,
    SUM(CASE WHEN a.appointment_id IS NULL THEN 1 ELSE 0 END) AS null_appointment_id,
    SUM(CASE WHEN p.patient_id IS NULL THEN 1 ELSE 0 END) AS null_patient_id,
    SUM(CASE WHEN d.doctor_id IS NULL THEN 1 ELSE 0 END) AS null_doctor_id,
    SUM(CASE WHEN a.status IS NULL THEN 1 ELSE 0 END) AS null_appointment_status,
    SUM(CASE WHEN b.payment_status IS NULL THEN 1 ELSE 0 END) AS null_payment_status
FROM hospital_management.appointments AS a
INNER JOIN hospital_management.patients AS p ON p.patient_id = a.patient_id
INNER JOIN hospital_management.treatments AS t ON t.appointment_id = t.appointment_id
INNER JOIN hospital_management.doctors AS d ON d.doctor_id = a.doctor_id
INNER JOIN hospital_management.billing AS b ON b.patient_id = p.patient_id;

# Check the mean and standard deviation 
SELECT ROUND(AVG(cost), 2) AS avg_cost, ROUND(STDDEV(cost), 2) AS stddev_cost, ROUND(AVG(cost) + 2 * STDDEV(cost), 2) AS outlier_threshold
FROM hospital_management.treatments;
# Identify outliers above that threshold
SELECT treatment_id, appointment_id, treatment_type, description, cost, treatment_date
FROM hospital_management.treatments
WHERE cost > (SELECT AVG(cost) + 2 * STDDEV(cost) FROM hospital_management.treatments);

# Appointment Attrition Analysis: Reasons, Costs, and Outcome Shares
SELECT c.outcome, c.reason_for_visit, c.visits, ROUND(100 * c.visits / NULLIF(SUM(c.visits) OVER (PARTITION BY c.outcome), 0), 1) AS pct_of_outcome,
  ROUND(100 * c.visits / NULLIF(SUM(c.visits) OVER (), 0), 1) AS pct_of_total,
  ROUND(c.total_cost, 2) AS total_cost, ROUND(100 * c.total_cost / NULLIF(SUM(c.total_cost) OVER (PARTITION BY c.outcome), 0), 1) AS pct_cost_of_outcome,
  ROUND(100 * c.total_cost / NULLIF((SELECT SUM(amount) FROM hospital_management.billing), 0), 2) AS pct_total_cost_of_total_billed,
  SUM(c.visits) OVER () AS total_visit, (SELECT ROUND(SUM(amount), 2) FROM hospital_management.billing) AS total_revenue
FROM (
  SELECT
    CASE
      WHEN LOWER(a.status) IN ('no-show','no show','noshow') THEN 'No-show'
      WHEN LOWER(a.status) IN ('cancelled','canceled') THEN 'Cancelled'
    END AS outcome,
    a.reason_for_visit, COUNT(*) AS visits, SUM(COALESCE(t.cost, 0)) AS total_cost
  FROM hospital_management.appointments a
  LEFT JOIN hospital_management.treatments t
    ON t.appointment_id = a.appointment_id
  WHERE LOWER(a.status) IN ('no-show','no show','noshow','cancelled','canceled')
  GROUP BY outcome, a.reason_for_visit) AS c
ORDER BY c.outcome, c.visits DESC, c.total_cost DESC;

# Financial Analysis of Cancelled and No-Show Appointments — Amounts Paid, Pending, and Failed by Reason for Visit
SELECT
  CASE
    WHEN LOWER(a.status) IN ('no-show','no show','noshow') THEN 'No-show'
    WHEN LOWER(a.status) IN ('cancelled','canceled')       THEN 'Cancelled'
  END AS outcome,
  a.reason_for_visit,
  -- Payment breakdown by status
  ROUND(SUM(CASE WHEN LOWER(b.payment_status) = 'paid'    THEN b.amount ELSE 0 END), 2) AS total_paid,
  ROUND(SUM(CASE WHEN LOWER(b.payment_status) = 'pending' THEN b.amount ELSE 0 END), 2) AS total_pending,
  ROUND(SUM(CASE WHEN LOWER(b.payment_status) = 'failed'  THEN b.amount ELSE 0 END), 2) AS total_failed,
  -- Totals and percentage composition
  ROUND(SUM(b.amount), 2) AS total_billed,
  ROUND(100 * SUM(CASE WHEN LOWER(b.payment_status) = 'paid' THEN b.amount ELSE 0 END) / NULLIF(SUM(b.amount), 0), 1) AS pct_paid,
  ROUND(100 * SUM(CASE WHEN LOWER(b.payment_status) = 'pending' THEN b.amount ELSE 0 END) / NULLIF(SUM(b.amount), 0), 1) AS pct_pending,
  ROUND(100 * SUM(CASE WHEN LOWER(b.payment_status) = 'failed' THEN b.amount ELSE 0 END) / NULLIF(SUM(b.amount), 0), 1) AS pct_failed
FROM hospital_management.appointments a
LEFT JOIN hospital_management.treatments t ON t.appointment_id = a.appointment_id
LEFT JOIN hospital_management.billing b ON b.treatment_id = t.treatment_id
WHERE LOWER(a.status) IN ('no-show','no show','noshow','cancelled','canceled')
GROUP BY outcome, a.reason_for_visit
ORDER BY outcome, total_billed DESC;

# Collection rate analysis
SELECT b.payment_method, ROUND(SUM(CASE WHEN b.payment_status = 'paid' THEN b.amount ELSE 0 END), 2) AS total_paid,
ROUND(SUM(CASE WHEN a.status = 'Completed' THEN t.cost ELSE 0 END), 2) AS realized_revenue,
ROUND(SUM(CASE WHEN a.status = 'Scheduled' THEN t.cost ELSE 0 END), 2) AS potential_realized_revenue,
ROUND(SUM(CASE WHEN b.payment_status = 'paid' THEN b.amount ELSE 0 END) / SUM(CASE WHEN a.status IN ('Completed', 'Scheduled') THEN t.cost ELSE 0 END), 2) AS cash_conversion_rate -- % of Realized Revenue Collected
FROM hospital_management.treatments AS t
JOIN hospital_management.billing AS b ON t.treatment_id = b.treatment_id
JOIN hospital_management.appointments AS a ON t.appointment_id = a.appointment_id
GROUP BY b.payment_method
ORDER BY b.payment_method, total_paid DESC, realized_revenue DESC;

SELECT d.hospital_branch, b.payment_method, ROUND(SUM(CASE WHEN b.payment_status = 'paid' THEN b.amount ELSE 0 END), 2) AS total_paid,
    ROUND(SUM(CASE WHEN a.status = 'Completed' THEN t.cost ELSE 0 END), 2) AS total_realized_revenue,
    ROUND(SUM(CASE WHEN a.status = 'Scheduled' THEN t.cost ELSE 0 END), 2) AS potential_realized_revenue,
	ROUND(SUM(CASE WHEN b.payment_status = 'paid' THEN b.amount ELSE 0 END) / SUM(CASE WHEN a.status IN ('Completed', 'Scheduled') THEN t.cost ELSE 0 END), 2) AS cash_conversion_rate_pct -- % of Realized Revenue Collected
FROM hospital_management.treatments AS t
JOIN hospital_management.billing AS b ON t.treatment_id = b.treatment_id
JOIN hospital_management.appointments AS a ON t.appointment_id = a.appointment_id
JOIN hospital_management.doctors AS d ON a.doctor_id = d.doctor_id  -- ✅ join doctors to access branch info
GROUP BY d.hospital_branch, b.payment_method
ORDER BY d.hospital_branch,cash_conversion_rate_pct DESC;

# Doctor
CREATE OR REPLACE VIEW appointment_noshow AS
SELECT d.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS doctor_name, d.specialization,
	d.years_experience, d.hospital_branch,
    -- Aggregated counts
    SUM(CASE WHEN a.status IN ('No-show', 'Cancelled') THEN 1 ELSE 0 END) AS no_show_cancel,
    SUM(CASE WHEN a.status IN ('Completed', 'Scheduled') THEN 1 ELSE 0 END) AS show_up,
    COUNT(*) AS total_appointments,
    -- Success-to-Failure Ratio
    CASE 
        WHEN SUM(CASE WHEN a.status IN ('No-show', 'Cancelled') THEN 1 ELSE 0 END) = 0
            THEN CONCAT(SUM(CASE WHEN a.status IN ('Completed', 'Scheduled') THEN 1 ELSE 0 END), ':0')
        WHEN SUM(CASE WHEN a.status IN ('Completed', 'Scheduled') THEN 1 ELSE 0 END) = 0
            THEN CONCAT('0:', SUM(CASE WHEN a.status IN ('No-show', 'Cancelled') THEN 1 ELSE 0 END))
        ELSE CONCAT(
            SUM(CASE WHEN a.status IN ('Completed', 'Scheduled') THEN 1 ELSE 0 END), ':',
            SUM(CASE WHEN a.status IN ('No-show', 'Cancelled') THEN 1 ELSE 0 END))
    END AS appointment_to_no_show_ratio
FROM hospital_management.doctors AS d
INNER JOIN hospital_management.appointments AS a ON d.doctor_id = a.doctor_id
INNER JOIN hospital_management.treatments AS t ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, doctor_name, d.specialization, d.years_experience, d.hospital_branch
ORDER BY d.doctor_id, doctor_name, total_appointments DESC;

CREATE OR REPLACE VIEW appointment_noshow_details AS
SELECT d.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS doctor_name, d.specialization,
    d.years_experience, d.hospital_branch, t.treatment_type,
    SUM(CASE WHEN a.status IN ('No-show','Cancelled') THEN 1 ELSE 0 END) AS no_show_cancel,
    SUM(CASE WHEN a.status IN ('Completed','Scheduled') THEN 1 ELSE 0 END) AS show_up,
    COUNT(*) AS total_appointments,
    -- Success-to-Failure Ratio
    CASE 
        WHEN SUM(CASE WHEN a.status IN ('No-show','Cancelled') THEN 1 ELSE 0 END) = 0
            THEN CONCAT(SUM(CASE WHEN a.status IN ('Completed','Scheduled') THEN 1 ELSE 0 END), ':0')
        WHEN SUM(CASE WHEN a.status IN ('Completed','Scheduled') THEN 1 ELSE 0 END) = 0
            THEN CONCAT('0:', SUM(CASE WHEN a.status IN ('No-show','Cancelled') THEN 1 ELSE 0 END))
        ELSE CONCAT(
            SUM(CASE WHEN a.status IN ('Completed','Scheduled') THEN 1 ELSE 0 END), ':',
            SUM(CASE WHEN a.status IN ('No-show','Cancelled') THEN 1 ELSE 0 END))
    END AS appointment_to_no_show_ratio
FROM hospital_management.doctors AS d
INNER JOIN hospital_management.appointments AS a ON d.doctor_id = a.doctor_id
INNER JOIN hospital_management.treatments AS t ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, doctor_name, d.specialization, d.years_experience, t.treatment_type, d.hospital_branch
ORDER BY d.doctor_id, doctor_name, total_appointments DESC;
