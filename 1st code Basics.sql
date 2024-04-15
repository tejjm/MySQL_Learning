SELECT * 
FROM parks_and_recreation.employee_demographics;

#PEMDAS

SELECT first_name, age, (age+10)*10
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT gender, first_name
FROM parks_and_recreation.employee_demographics;