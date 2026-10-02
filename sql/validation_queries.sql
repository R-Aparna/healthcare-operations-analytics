-- Validation 1: Total Appointments
SELECT count(appointment_id) as total_appointments
from appointments;

-- Validation 2: Patients Seen
SELECT COUNT(DISTINCT patient_id) AS patients_seen
FROM appointments;

-- Validation 3: Total Doctors
SELECT COUNT(doctor_id) AS total_doctors
FROM doctors;

-- Validation 4: Appointments by Status
SELECT status, COUNT(appointment_id) AS appointment_count
FROM appointments
GROUP BY status;

-- Validation 5: Cancellation rate by department
select d.department_name,count(a.appointment_id) as total_appointments,
sum(case when a.status = 'Cancelled' then 1 else 0 END) as cancelled_appointments,
round((sum(case when a.status = 'Cancelled' then 1 else 0 END)*1.0/count(a.appointment_id))*100,2) as cancellation_rate
from departments d
left join doctors dr
on d.department_id = dr.department_id
left join appointments a
on a.doctor_id = dr.doctor_id
group by d.department_name
order by cancellation_rate desc;

--Validation 6: Department and Appointment Type Slicer Filters
select COUNT(DISTINCT a.doctor_id) as total_doctors,count(a.appointment_id) as total_appts,count(distinct a.patient_id) as patients_seen,
SUM(case when a.status ='Completed' THEN 1 ELSE 0 END) as Completed_appts,
SUM(case when a.status ='Cancelled' THEN 1 ELSE 0 END ) as Cancelled_appts,
ROUND(
    SUM(CASE WHEN a.status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0
    / COUNT(a.appointment_id),
    2
) AS cancellation_rate
from appointments a
join doctors dr
on a.doctor_id = dr.doctor_id
join departments d
on d.department_id = dr.department_id
where d.department_name = 'Cardiology'
and a.appointment_type = 'Consultation';

-- Validation 7: Appointments by Department
SELECT d.department_name,COUNT(a.appointment_id) AS total_appointments
FROM departments d
JOIN doctors dr
ON d.department_id = dr.department_id
JOIN appointments a
ON dr.doctor_id = a.doctor_id
GROUP BY d.department_name
ORDER BY total_appointments DESC;

-- Validation 8: Monthly Appointment Volume
SELECT DATE_TRUNC('month', appointment_date) AS appointment_month,
COUNT(appointment_id) AS total_appointments
FROM appointments
GROUP BY DATE_TRUNC('month', appointment_date)
ORDER BY appointment_month;

-- Validation 9: Appointment Status distribution by Department
select d.department_name,
SUM(CASE WHEN a.status='Cancelled' THEN 1 ELSE 0 END)AS cancelled_appointments,
SUM(CASE WHEN a.status='No Show' THEN 1 ELSE 0 END) AS no_show_appointments,
SUM(CASE WHEN a.status='Completed' THEN 1 ELSE 0 END) AS completed_appointments
from departments d
left join doctors dr
ON d.department_id = dr.department_id
left join appointments a
on dr.doctor_id = a.doctor_id
group by d.department_id
order by cancelled_appointments desc;







