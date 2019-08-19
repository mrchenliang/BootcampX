-- SELECT id, name
-- FROM students
-- where cohort_id = 1
-- ORDER BY name;

-- SELECT count(id)
-- FROM students
-- where cohort_id in (1,2,3);

-- SELECT name, id
-- FROM students
-- WHERE email is null or phone is null 
-- ORDER BY name;

-- SELECT name, id, email, cohort_id
-- FROM students
-- WHERE email not like '%gmail.com' or phone is null
-- ORDER BY name;

-- SELECT name, id, cohort_id
-- FROM students
-- WHERE end_date is null
-- ORDER BY cohort_id;

SELECT name, email, phone
FROM students
WHERE github is null and end_date is null
ORDER BY name;

