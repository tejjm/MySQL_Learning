-- Windows Functions 
SELECT CONCAT(dem.first_name,' ',dem.last_name) name,dem.gender,AVG(sal.salary) OVER(PARTITION BY gender) avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;
SELECT CONCAT(dem.first_name,' ',dem.last_name) name,dem.gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;