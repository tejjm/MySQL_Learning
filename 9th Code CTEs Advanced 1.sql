-- CTEs
WITH CTE_example AS
(
SELECT employee_id,gender,birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_example2 AS
(
SELECT employee_id,salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_example
JOIN CTE_example2
	ON CTE_example.employee_id = CTE_example2.employee_id
;
