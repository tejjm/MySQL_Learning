-- Triggers
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
INSERT INTO employee_demographics(employee_id,first_name,last_name)
VALUES(NEW.employee_id,NEW.first_name,NEW.last_name);
END$$
DELIMITER ;
SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

INSERT INTO employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
VALUES(13,'Jean','Paul','Bank Busta',1000000,NULL);