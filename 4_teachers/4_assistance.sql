-- Total Teacher Assistance Requests
-- We need to be able to see how many assistance requests any teacher has completed.

-- Get the total number of assistance_requests for a teacher.

-- Select the teacher's name and the total assistance requests.
-- Since this query needs to work with any specific teacher name, use 'Waylon Boehm' for the teacher's name here.

select count(*) as total_assistance, teachers.name as name 
from assistance_requests
join teachers
on teachers.id = teacher_id
Where name = 'Waylon Boehm'
Group by teachers.name;

-- Total Student Assistance Requests
-- We need to be able to see how many assistance requests any student has requested.

-- Get the total number of assistance_requests for a student.

-- Select the student's name and the total assistance requests.
-- Since this query needs to work with any specific student name, use 'Elliot Dickinson' for the student's name here.

select count(*) as total_assistance, students.name as name 
from assistance_requests
join students
on students.id = student_id
Where name = 'Elliot Dickinson'
Group by students.name;

-- Assistance Requests Data
-- Each assistance request is related to a bunch of data like a teacher, student, assignment, and more. We want to be able to see all important data about an assistance request.

-- Get important data about each assistance request.

-- Select the teacher's name, student's name, assignment's name, and the duration of each assistance request.
-- Subtract completed_at by started_at to find the duration.
-- Order by the duration of the request.

select teachers.name as teacher, students.name as student, assignments.name as assignment, assistance_requests.completed_at - assistance_requests.started_at as duration
from assistance_requests
join students
on students.id = student_id
join teachers
on teachers.id = teacher_id
join assignments
on assignments.id = assignment_id
order by assistance_requests.completed_at - assistance_requests.started_at;

-- Average Assistance Time
-- We need to be able to see the current average time it takes to complete an assistance request.

-- Get the average time of an assistance request.

-- Select just a single row here and name it average_assistance_request_duration
-- In Postgres, we can subtract two timestamps to find the duration between them. (timestamp1 - timestamp2)

select avg(assistance_requests.completed_at - assistance_requests.started_at) as average_assistance_request_duration
from assistance_requests

-- Average Cohort Assistance Time
-- We need to be able to see the average duration of a single assistance request for each cohort.

-- Get the average duration of assistance requests for each cohort.

-- Select the cohort's name and the average assistance request time.
-- Order the results from shortest average to longest.

select cohorts.name as name, avg(assistance_requests.completed_at - assistance_requests.started_at) as average_assistance_request_duration
from assistance_requests
join students
on students.id = student_id
join cohorts
on cohorts.id = cohort_id
group by cohorts.name
order by average_assistance_request_duration;

-- Cohort With Longest Assistances
-- Get the cohort with the longest average duration of assistance requests.

-- The same requirements as the previous query, but only return the single row with the longest average.

select cohorts.name as name, avg(assistance_requests.completed_at - assistance_requests.started_at) as average_assistance_time 
from assistance_requests
join students
on students.id = student_id
join cohorts
on cohorts.id = cohort_id
group by cohorts.name
order by average_assistance_time DESC
limit 1;

-- Average Assistance Request Wait Time
-- We need to know the average amount of time that students are waiting for an assistance request. This is the duration between an assistance request being created, and it being started.

-- Calculate the average time it takes to start an assistance request.

-- Return just a single column here.

select avg(assistance_requests.started_at - assistance_requests.created_at) as average_wait_time 
from assistance_requests;

-- Total Cohort Assistance Duration
-- We need to be able to see the total amount of time being spent on an assistance request for each cohort. This number will tell use how much time is being spent on assistance requests for each cohort.

-- Get the total duration of all assistance requests for each cohort.

-- Select the cohort's name and the total duration the assistance requests.
-- Order by total_duration.
-- Look at the ERD to see how to join the tables.

select avg(total_duration.total_duration) as average_total_duration
from (select
sum(assistance_requests.completed_at - assistance_requests.started_at) as total_duration
from assistance_requests
join students
on students.id = student_id
join cohorts
on cohorts.id = cohort_id
group by cohorts.name
order by total_duration)as total_duration;

-- Most Confusing Assignments
-- We need to know which assignments are causing the most assistance requests.

-- List each assignment with the total number of assistance requests with it.

-- Select the assignment's id, day, chapter, name and the total assistances.
-- Order by total assistances in order of most to least.

select assignments.id as id, assignments.name as name, assignments.day as day, assignments.chapter as chapter, count(assistance_requests) as total_request
from assignments  
join assistance_requests
on assignments.id = assignment_id
group by assignments.id
order by total_request DESC;

-- Total Assignments and duration
-- We need to be able to see the number of assignments that each day has and the total duration of assignments for each day.

-- Get each day with the total number of assignments and the total duration of the assignments.

-- Select the day, number of assignments, and the total duration of assignments.
-- Order the results by the day.

select day, count(assignments.id) as number_of_assignments, sum(duration) as duration
from assignments
group by day
order by day;

-- Name of Teachers That Assisted
-- We need to know which teachers actually assisted students during any cohort.

-- Get the name of all teachers that performed an assistance request during a cohort.

-- Select the instructor's name and the cohort's name.
-- Don't repeat the instructor's name in the results list.
-- Order by the instructor's name.
-- This query needs to select data for a cohort with a specific name, use 'JUL02' for the cohort's name here.

select distinct teachers.name as teacher, cohorts.name as cohort
from teachers
join assistance_requests
on teachers.id = teacher_id
join students
on students.id = student_id
join cohorts
on cohorts.id = cohort_id
where cohorts.name = 'JUL02'
order by teacher;

-- Name of Teachers and Number of Assistances
-- We need to know which teachers actually assisted students during any cohort, and how many assistances they did for that cohort.

-- Perform the same query as before, but include the number of assistances as well.

select distinct teachers.name as teacher, cohorts.name as cohort, count(assistance_requests.*) as total_assistance
from teachers
join assistance_requests
on teachers.id = teacher_id
join students
on students.id = student_id
join cohorts
on cohorts.id = cohort_id
where cohorts.name = 'JUL02'
group by teachers.name, cohorts.name
order by teacher;