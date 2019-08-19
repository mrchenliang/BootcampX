select sum(assignment_submissions.duration) as total_duration
from assignment_submissions
join students
on assignment_submissions.student_id = students.id
where students.name = 'Ibrahim Schimmel';

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

