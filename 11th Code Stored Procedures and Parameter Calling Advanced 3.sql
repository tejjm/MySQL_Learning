-- Stored Procedures 
DELIMITER $$
CREATE PROCEDURE age_staff()
BEGIN 
	SELECT *
	FROM employee_demographics
	WHERE age > 40; 
	SELECT *
	FROM employee_demographics
	WHERE age < 40;
END $$
DELIMITER ;
CALL age_staff();


DELIMITER $$
CREATE PROCEDURE salary_check(p_employee_id INT)
BEGIN
	SELECT salary
    FROM employee_salary
    WHERE employee_id = p_employee_id
    ;
END $$
DELIMITER ;
CALL salary_check(1)
    
