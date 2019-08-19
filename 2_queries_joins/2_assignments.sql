-- Student's Total Assignment Duration
-- Get the total amount of time that a student has spent on all assignments.

-- This should work for any student but use 'Ibrahim Schimmel' for now.
-- Select only the total amount of time as a single column.

select sum(assignment_submissions.duration) as total_duration
from assignment_submissions
join students
on assignment_submissions.student_id = students.id
where students.name = 'Ibrahim Schimmel';

-- Cohort's Total Assignment Duration
-- Get the total amount of time that all students from a specific cohort have spent on all assignments.

-- This should work for any cohort but use FEB12 for now.
-- Select only the total amount of time as a single column.
-- You can write as many JOIN statements as you need in a single query. Expected Result:

select sum(assignment_submissions.duration) as total_duration
from assignment_submissions
join students
on assignment_submissions.student_id = students.id
where students.start_date = '2018-02-12T08:00:00.000Z';

SELECT sum(assignment_submissions.duration) as total_duration
FROM assignment_submissions
JOIN students ON students.id = assignment_submissions.student_id
JOIN cohorts ON cohorts.id = students.cohort_id
WHERE cohorts.name = 'FEB12';

