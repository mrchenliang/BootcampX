const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

// pool.query(`
// SELECT id, name, cohort_id
// FROM students
// LIMIT 5;
// `)
// .then(res => {
//   console.log(res.rows);
// })
// .catch(err => console.error('query error', err.stack));


pool.query(`
SELECT students.id as id, students.name as name, cohorts.name as cohort_name
FROM students
JOIN cohorts
ON cohorts.id = cohort_id
WHERE cohorts.name LIKE '${process.argv[2]}%'
LIMIT ${process.argv[3]}
`)
.then(res => {
  res.rows.forEach(user => {
    console.log(`${user.name} has an id of ${user.id} and was in the ${user.cohort_name} cohort`);
  })
})
.catch(err => console.error('query error', err.stack));
