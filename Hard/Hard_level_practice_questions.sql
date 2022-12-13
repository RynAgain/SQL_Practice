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


--Hard level questions

/*
Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.

For example, if they weight 100 to 109 they are placed in the 100 
weight group, 110-119 = 110 weight group, etc.
*/

select
	count(patient_id) as p_in_group,
    floor(weight/10)*10 as weight_group
from patients
group by weight_group
order by weight_group desc


/*
Show patient_id, weight, height, isObese from the patients table.

Display isObese as a boolean 0 or 1.

Obese is defined as weight(kg)/(height(m)2) >= 30.

weight is in units kg.

height is in units cm.

*/
select * from patients

select
	patient_id,
    weight,
    height,
    case
      when (weight/(power(height/100.0, 2))) >= 30 then 1
      else 0
    end as isobese
from patients

/*
Show patient_id, first_name, last_name, 
and attending doctor's specialty.
Show only the patients who has a 
diagnosis as 'Epilepsy' and the doctor's
first name is 'Lisa'

Check patients, admissions, 
and doctors tables for required information.
*/

select * from doctors
select * from patients
select * from admissions

select
	admissions.patient_id,
    patients.first_name,
    patients. last_name,
    doctors.specialty
from admissions
inner join patients on admissions.patient_id = patients.patient_id
inner join doctors on admissions.attending_doctor_id = doctors.doctor_id
where admissions.diagnosis = 'Epilepsy' and doctors.first_name = 'Lisa'


/*
All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date
*/