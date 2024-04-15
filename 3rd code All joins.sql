SELECT * FROM employee_demographics;

SELECT * FROM employee_salary;

#INNER JOIN
SELECT *
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
    ;

#LEFT JOIN / RIGHT JOIN
SELECT *
FROM employee_demographics dem
RIGHT JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
    ;
    
#SELF JOIN
SELECT emp1.employee_id santa_id,
emp1.first_name santa_first_name,
emp1.last_name santa_last_name,
emp2.employee_id,
emp2.first_name,
emp2.last_name
FROM employee_demographics emp1
JOIN employee_demographics emp2
	ON emp1.employee_id+1 = emp2.employee_id
;

# MULTIPLE JOIN
SELECT *
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
    ;

