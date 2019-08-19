SELECT id, name
FROM students
where cohort_id = 1
ORDER BY name;

SELECT count(id)
FROM students
where cohort_id in (1,2,3);

SELECT name, id
FROM students
WHERE email is null or phone is null 
ORDER BY name;

SELECT name, id, email, cohort_id
FROM students
WHERE email not like '%gmail.com' or phone is null
ORDER BY name;

SELECT name, id, cohort_id
FROM students
WHERE end_date is null
ORDER BY cohort_id;

SELECT name, email, phone
FROM students
WHERE github is null and end_date is null
ORDER BY name;

select students.name as student_name, cohorts.name as cohort_name, cohorts.start_date as cohort_start_date, students.start_date as student_start_date
from students
join cohorts
on students.cohort_id = cohorts.id
where cohorts.start_date != students.start_date
order by student_name;

