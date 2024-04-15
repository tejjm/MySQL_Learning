-- String Functions
SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2
;
SELECT first_name, UPPER(first_name)
FROM employee_demographics
;

SELECT first_name, 
LEFT(first_name,4),
RIGHT(first_name,4),
SUBSTRING(birth_date,6,2) birth_month
FROM employee_demographics
;
SELECT first_name, REPLACE(first_name, 'a','z')
FROM employee_demographics
;

SELECT first_name, LOCATE('AN',first_name)
FROM employee_demographics
;

SELECT CONCAT(first_name,' ',last_name) full_name,age
FROM employee_demographics
;