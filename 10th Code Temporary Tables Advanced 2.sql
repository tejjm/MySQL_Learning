-- Temporary Tables 
CREATE TEMPORARY TABLE temp_table
(
first_name varchar(50),
last_name varchar(50),
favorite_song varchar(70)
);

INSERT INTO temp_table
VALUES ('Uttej','Madhusudhan','Bing Bang Bom')
;
SELECT * FROM temp_table
;

CREATE TEMPORARY TABLE salary_over_50k
(
SELECT * FROM employee_salary
WHERE salary >= 50000
)