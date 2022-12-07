SELECT * FROM patients;
select * from admissions;
select * from doctors;
select * from province_names;


/*
  Start by selecting a question by pressing 'Start' or 'View All Questions'.
  Use the resources and information about the database from the left panel to help.
  Press the run button to execute the query.
  Question is automatically validated every time you execute the query.
  Make your output match the expected output.
 
  If you can't solve a question you can press 'Skip Question' to view the solution.
 
  Keybinds:
    [ctrl + enter]: Execute the SQL
    [ctrl + q]: Auto-format the SQL
*/


select (select count(*) from patients where gender = 'M') as number_mailes, (select count(*) from patients where gender = 'F') as number_females


--Medium Questions

/*

*/
select
	first_name,
    last_name,
    allergies
from patients
where allergies = 'Morphine' or allergies = 'Penicillin'
order by allergies asc,
	first_name,
    last_name

/*
Show patient_id, diagnosis from admissions. 
Find patients admitted multiple times for the same diagnosis.
*/

select
	patient_id,
    diagnosis
from admissions
group by 
	patient_id,
    diagnosis
having count(*) > 1

/*
Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.
*/

select
	city,
    count(*) as total_pop
from patients
group by
	city
order by total_pop desc,
	city


/*
Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"
*/

select first_name, last_name, 'Patient' as role
from patients
union All
select first_name, last_name, 'Doctor' as role
from doctors


/*
Show all allergies ordered by popularity. Remove NULL values from query.
*/
    
select 
	allergies,
    count(allergies) as total_diagnosis
from patients
where allergies is not null	
group by
	allergies
order by total_diagnosis desc


/*
Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
Sort the list starting from the earliest birth_date.
*/

select
	first_name,
    last_name,
    birth_date
from patients
where year(birth_date) between 1970 and 1979
order by birth_date


/*
We want to display each patient's full name in a single column. 
Their last_name in all upper letters must appear first, 
then first_name in all lower case letters. Separate the last_name 
and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane
*/

select
	concat(upper(last_name), ',',  lower(first_name)) as full_name
from patients
order by first_name desc

/*
Show the province_id(s), 
sum of height; 
where the total sum of its patient's
height is greater than or equal to 7,000.
*/
select
	province_id,
    sum(height) as tot_h
from patients
group by province_id
having tot_h >= 7000

/*
Show the difference between the largest weight
and smallest weight for patients with the last name 'Maroni'
*/
select 
	max(weight) - min(weight) as weight_delta
from (select * from patients where last_name = 'Maroni')

/*
Show all of the days of the month (1-31) 
and how many admission_dates occurred on that day. 
Sort by the day with most admissions to least admissions.
*/

select
	day(admission_date) as adday,
    count(*) as number
from admissions
group by adday
order by number desc

/*
Show all columns for patient_id 542's
most recent admission_date.
*/

select
	*
from admissions
where patient_id = 542
group by patient_id
having max(admission_date)

/*

Show patient_id, attending_doctor_id, and diagnosis for admissions 
that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
*/

select
	patient_id,
    attending_doctor_id,
    diagnosis
from admissions
where attending_doctor_id in  (1, 5, 19) and patient_id % 2 = 1
Union ALL
select
	patient_id,
    attending_doctor_id,
    diagnosis
from admissions
where len(patient_id) = 3 and attending_doctor_id like '%2%'

/*
Show first_name, last_name, and the total number of 
admissions attended for each doctor.
Every admission has been attended by a doctor.
*/

select
	doctors.first_name,
    doctors.last_name,
    count(*)  as number_add
    --sum(count(*)) over() as total_admission,
    --concat(round(100.0 *count(*) / (sum(count(*))over()), 4), '%') as percentage_of_total
from 
	admissions
join doctors on doctors.doctor_id = admissions.attending_doctor_id
group by attending_doctor_id
order by number_add desc
--------------------------------------------
SELECT
  first_name,
  last_name,
  count(*)
from
  doctors p,
  admissions a
where
  a.attending_doctor_id = p.doctor_id
group by p.doctor_id;

/*
For each physicain, display their id, full name,
and the first and last admission date they attended.
*/

select
	doctors.doctor_id,
    concat(doctors.first_name, ' ', doctors.last_name) as full_name,
    min(admissions.admission_date),
    max(admissions.admission_date)
from admissions
join doctors on doctors.doctor_id = admissions.attending_doctor_id
group by full_name

/*
Display the total amount of patients for each province. Order by descending. Full province name.
*/
select *
from patients

select *
from province_names

select
    province_names.province_name,
	count(*) as number
from patients
join province_names on patients.province_id = province_names.province_id
group by province_names.province_name
order by number desc

/*
For every admission, display the patient's full name, 
their admission diagnosis, and their doctor's full 
name who diagnosed their problem
*/
SELECT * FROM patients;
select * from admissions;
select * from doctors;
select * from province_names;

select
    concat(patients.first_name, ' ', patients.last_name) as their_name,
    admissions.diagnosis,
    concat(doctors.first_name, ' ', doctors.last_name) as their_doctor
from admissions
join doctors on admissions.attending_doctor_id = doctors.doctor_id
join patients on patients.patient_id=admissions.patient_id

/*
display the number of duplicate patients based on their first_name and last_name.
*/

select
	first_name,
    last_name,
    count(*) as num_of_dups
from patients
group by
	first_name,
    last_name
having num_of_dups > 1
order by num_of_dups desc
