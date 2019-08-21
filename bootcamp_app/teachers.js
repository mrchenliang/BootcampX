const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

const queryString = `
SELECT DISTINCT cohorts.name as cohort, teachers.name as name
FROM cohorts
JOIN students
ON cohorts.id = cohort_id
JOIN assistance_requests
ON students.id = student_id
JOIN teachers
ON teachers.id = teacher_id
WHERE cohorts.name LIKE $1
ORDER BY name;
  `

const cohortName = process.argv[2];
const value = [`%${cohortName}%`];

pool.query(queryString, value)
.then(res => {
  res.rows.forEach(row => {
    console.log(`${row.cohort}: ${row.name}`);
  })
})
.catch(err => console.error('query error', err.stack));
