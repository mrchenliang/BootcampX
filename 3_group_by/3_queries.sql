-- Assignments Per Day
-- Get the total number of assignments for each day of bootcamp.

-- Select the day and the total assignments.
-- Order the results by day.
-- This query only requires the assignments table

select assignments.day as day, count(*) as total_assignments
from assignments
group by assignments.day
order by assignments.day;

-- Busy Days
-- The same query as before, but only return rows where total assignments is greater than or equal to 10.

select assignments.day as day, count(*) as total_assignments
from assignments
group by assignments.day
having count(*) >= 10
order by assignments.day;

-- Large Cohorts
-- Get all cohorts with 18 or more students.

-- Select the cohort name and the total students.
-- Order by total students from smallest to greatest.

select cohorts.name as cohort_name, count(students.id) as student_count
from students
join cohorts
on students.cohort_id = cohorts.id
group by cohorts.name
having count(students.id) >= 18
order by count(students.id), cohorts.name;

-- Total Assignment Submissions
-- Get the total number of assignment submissions for each cohort.

-- Select the cohort name and total submissions.
-- Order the results from greatest to least submissions.

select cohorts.name as cohort_name, count(assignment_submissions) as total_submissions
from cohorts
join students
on cohorts.id = students.cohort_id
join assignment_submissions
on assignment_submissions.student_id = students.id
group by cohorts.name
order by total_submissions DESC;

-- Average Completion Time
-- Get currently enrolled students' average assignment completion time.

-- Select the students name and average time from assignment submissions.
-- Order the results from greatest duration to least greatest duration.
-- A student will have a null end_date if they are currently enrolled

select students.name as student, avg(assignment_submissions.duration) as average_assignment_duration
from students
join assignment_submissions
on students.id = assignment_submissions.student_id
where students.end_date is null
group by student
order by average_assignment_duration DESC;

-- Low Average Completion Time
-- Get the students who's average time it takes to complete an assignment is less than the average estimated time it takes to complete an assignment.

-- Select the name of the student, their average completion time, and the average suggested completion time.
-- Order by average completion time from smallest to largest.
-- Only get currently enrolled students.
-- This will require data from students, assignment_submissions, and assignments.

select students.name as student, avg(assignment_submissions.duration) as average_assignment_duration, avg(assignments.duration) as average_estimated_duration
from students
join assignment_submissions
on students.id = assignment_submissions.student_id
join assignments
on assignments.id = assignment_submissions.assignment_id
where students.end_date is null
group by student
HAVING avg(assignment_submissions.duration) < avg(assignments.duration)
order by average_assignment_duration;