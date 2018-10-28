#1
SELECT first_name, last_name FROM employees
WHERE lower(left(first_name,2)) IN ('sa');

#2
SELECT first_name, last_name FROM employees
WHERE lower(last_name) LIKE '%ei%';

#3
SELECT first_name FROM employees
WHERE (department_id=3 OR department_id=10) AND (year(hire_date) BETWEEN 1995 AND 2005);

#4
SELECT first_name, last_name FROM employees
WHERE Not lower(job_title) LIKE '%engineer%';

#5
SELECT name FROM towns
WHERE char_length(name) = 5 or char_length(name)=6
ORDER BY name;

#6
SELECT town_id, name FROM towns
WHERE lower(name) LIKE 'e%' OR lower(name) LIKE 'm%' or lower(name) LIKE 'k%' or lower(name) LIKE 'b%'
ORDER BY name;

#7
use soft_uni;

SELECT t.town_id, t.name 
FROM towns AS t
WHERE lower(left(t.name,1)) not IN ('r','b','d')
ORDER BY t.name;

#8
CREATE VIEW `v_employees_hired_after_2000` AS
SELECT first_name, last_name FROM employees
WHERE year(hire_date)>2000;

SELECT *FROM v_employees_hired_after_2000;

#9
SELECT first_name, last_name 
FROM employees
WHERE char_length(last_name)=5;

#10
USE geography;

SELECT country_name, iso_code FROM countries
WHERE lower(country_name) LIKE '%a%a%a%'
ORDER BY iso_code;

#11
USE geography;

SELECT p.peak_name , r.river_name, 
lower(concat(p.peak_name, substr(r.river_name, 2))) AS `mix`
FROM peaks AS p, rivers AS r
WHERE right(p.peak_name,1)=left(r.river_name,1)
ORDER BY mix;

#12
use diablo;

SELECT name, date_format(start, '%Y-%m-%d' ) as start FROM games
WHERE year(start)=2011 OR year(start)=2012
ORDER BY start
LIMIT 50; 

#13
USE diablo;

SELECT u.user_name, substr(u.email, position('@' IN u.email)+1) as `Email Provider`
FROM users AS u
ORDER BY `Email Provider`, u.user_name;

#14
SELECT user_name, ip_address FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

#15
SELECT name, 
CASE WHEN hour(start) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN hour(start) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN hour(start) BETWEEN 18 AND 23 THEN 'Evening'
END as `Part of the Day`,
CASE WHEN duration<=3 THEN 'Extra Short'
	WHEN duration BETWEEN 4 AND 6 THEN 'Short'
    WHEN duration BETWEEN 7 AND 10 THEN 'Long'
    ELSE 'Extra Long' END AS `Duration`
FROM games;

#16
USE orders;

SELECT product_name, order_date,
date_add(order_date, interval 3 Day) as pay_due,
date_add(order_date, interval 1 month) as deliver_due
FROM orders;
 





