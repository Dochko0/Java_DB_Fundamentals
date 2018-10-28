USE soft_uni;

#1
SELECT * FROM departments;

#2
SELECT name from departments;

#3
SELECT first_name, last_name, salary FROM employees;

#4
SELECT first_name, middle_name, last_name FROM employees;

#5
SELECT * FROM departments;

#6
SELECT concat(e.first_name, '.', e.last_name, '@', 'softuni.bg') AS 'full_mail_adress'
from employees as e;

#7
SELECT DISTINCT salary FROM employees
ORDER BY employee_id ASC;

#8
SELECT * FROM employees
WHERE job_title = 'Sales Representative';

#9
SELECT first_name, last_name, job_title FROM employees
WHERE salary BETWEEN 20000 AND 30000;

#10
SELECT concat(e.first_name, ' ', e.middle_name, ' ', e.last_name) as 'Full Name'
FROM employees AS e
WHERE salary=25000 OR salary=14000 OR salary=12500 OR salary=23600;

#11
SELECT first_name, last_name
FROM employees
WHERE `manager_id` Is NULL;

#12
SELECT first_name, last_name, salary
FROM employees
WHERE salary>50000
ORDER BY salary DESC;

#13
SELECT first_name, last_name
FROM employees
ORDER BY salary DESC
LIMIT 5;

#14
SELECT *
FROM employees
ORDER BY salary DESC, 
first_name ASC,
last_name DESC,
middle_name ASC;

#15
CREATE VIEW `v_employees_salaries` AS
SELECT first_name, last_name, salary FROM employees;

SELECT * FROM `v_employees_salaries`;

#16
UPDATE employees
	SET `middle_name` = ''
	WHERE `middle_name` is NULL;
CREATE VIEW `v_employees_job_titles` AS
SELECT concat( e.first_name, ' ', e.middle_name, ' ', e.last_name) AS 'full_name',
 job_title 
 FROM employees as e;

SELECT * FROM `v_employees_job_titles`;

#17
SELECT DISTINCT job_title
 FROM employees
 ORDER BY job_title ASC;
 
 #18
 SELECT project_id, name, description, start_date, end_date
 FROM projects
 ORDER BY start_date , name
 LIMIT 10;
 
#19
SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 7;

#20
UPDATE employees
	SET salary = salary*1.12
    WHERE department_id = 1 OR department_id = 2 OR department_id = 4 
    OR department_id = 11;
SELECT salary FROM employees;

USE geography;

#21
SELECT peak_name from peaks;

#22
SELECT country_name , population
from countries
WHERE continent_code = 'EU'
ORDER BY population DESC, country_name
LIMIT 30;

#23
SELECT country_name, country_code, if(currency_code = 'EUR', 'Euro', 'Not Euro')
FROM countries
ORDER BY country_name;  

USE diablo;

#24
SELECT name FROM characters
ORDER BY name;

    


