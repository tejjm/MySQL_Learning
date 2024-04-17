-- Subqueries 
SELECT * 
FROM employee_demographics
WHERE employee_id IN (
					SELECT employee_id
                    FROM employee_salary
                    WHERE dept_id = 1
)
;
SELECT CONCAT(first_name, ' ',last_name) full_name,salary,
(SELECT AVG(salary) FROM employee_salary) average_salary
FROM employee_salary
;

SELECT gender,max_age
FROM
(SELECT gender,
AVG(age) avg_age,
MAX(age) max_age,
MIN(age) min_age,
COUNT(age) age_count
FROM employee_demographics
GROUP BY gender) AS agg_table
;