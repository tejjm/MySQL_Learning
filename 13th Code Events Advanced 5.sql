-- Events
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age>=60;
END $$
DELIMITER ;

SELECT * FROM employee_demographics
ORDER BY age DESC;

SHOW VARIABLES LIKE 'event%';