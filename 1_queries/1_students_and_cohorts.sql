-- Students in Cohort
-- Get the names of all of the students from a single cohort.

-- Select their id and name.
-- Order them by their name in alphabetical order.
-- Since this query needs to work with any specific cohort, just use any number for the cohort_id.

SELECT id, name
FROM students
where cohort_id = 1
ORDER BY name;

-- Total Students in Cohorts
-- The admissions department wants to know the total number of students from any number of cohorts combined.

-- Select the total number of students who were in the first 3 cohorts.

SELECT count(id)
FROM students
where cohort_id in (1,2,3);

-- Contact Details
-- We need to make sure that we can contact students through a phone number or through email. If student's don't have a phone number or email associated with their account, we'll need to message them on slack to update their details.

-- Get all of the students that don't have an email or phone number.

SELECT name, id
FROM students
WHERE email is null or phone is null 
ORDER BY name;

-- Non Gmail Students
-- Recently we've been having trouble emailing students without a gmail account. To make sure that we can reliably contact all students, we'll need to make sure that student's without a gmail account have a phone number.

-- Get all of the students without a gmail.com or phone number.
-- Get their name, email, id, and cohort_id.


SELECT name, id, email, cohort_id
FROM students
WHERE email not like '%gmail.com' or phone is null
ORDER BY name;

-- Currently Enrolled Students
-- A student's end date will be NULL when they are currently enrolled in Bootcamp.

-- Get all of the students currently enrolled.

-- Get their name, id, and cohort_id.
-- Order them by cohort_id.

SELECT name, id, cohort_id
FROM students
WHERE end_date is null
ORDER BY cohort_id;

-- Github Activity
-- Once a student graduates, the career services department needs to keep track of their activity on Github. If a graduate has not linked their Github account, we need to contact them to do so.

-- Get all graduates without a linked Github account.

-- Get their name, email, and phone.

SELECT name, email, phone
FROM students
WHERE github is null and end_date is null
ORDER BY name;

-- Rollover Students
-- Now that we understand JOINs a little bit, let's try writing another query that requires a JOIN. Sometimes a student's start_date will differ from their cohort's start_date. A student may have started in one cohort, gotten sick, and had to finish in a different cohort. We'll call this type of student a rollover student.

-- Select all rollover students.

-- Get the student's name, student's start_date, cohort's name, and cohort's start_date.
-- Alias the column names to be more descriptive.
-- Order by the name of the cohort.

select students.name as student_name, cohorts.name as cohort_name, cohorts.start_date as cohort_start_date, students.start_date as student_start_date
from students
join cohorts
on students.cohort_id = cohorts.id
where cohorts.start_date != students.start_date
order by student_name;

