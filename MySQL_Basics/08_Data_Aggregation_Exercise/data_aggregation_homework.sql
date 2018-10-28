#1
USE gringotts;

SELECT COUNT(id) as count 
from wizzard_deposits;

#2
SELECT MAX(magic_wand_size) as `longest magic wand`
FROM wizzard_deposits;

#3
SELECT 
deposit_group,
MAX(magic_wand_size) as `longest magic wand`
FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY `longest magic wand`, deposit_group;

#4
SELECT deposit_group
FROM (
	SELECT deposit_group, avg(magic_wand_size)
    FROM wizzard_deposits
	ORDER BY magic_wand_size) AS t1
Limit 1;

#5
SELECT deposit_group, SUM(deposit_amount) as total_sum
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum ASC;

#6
SELECT deposit_group, SUM(w.deposit_amount) as total_sum
FROM wizzard_deposits as w
WHERE w.magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;

#7
SELECT deposit_group, SUM(w.deposit_amount) as `total_sum`
FROM wizzard_deposits as w
WHERE w.magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING total_sum<150000
ORDER BY `total_sum` DESC;

#8
SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) as min_seposit_charge
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator, deposit_group;

#9
SELECT 
	(CASE
		WHEN wd.age BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN wd.age BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN wd.age BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN wd.age BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN wd.age BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN wd.age BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    end) as `age_group`, 
    count(wd.id) as `wizzard_count`
FROM wizzard_deposits wd
GROUP BY age_group
ORDER BY wizzard_count;

#10
#11
#12
SELECT sum(diff_between_curr_next) as `sum_difference`
FROM(
	SELECT 
		(wd1.deposit_amount -
			(
				SELECT wd2.deposit_amount
				FROM wizzard_deposits wd2
				WHERE wd2.id = wd1.id+1
			)
		) as `diff_between_curr_next`
	from wizzard_deposits wd1
) as cq;










#13
#14
CREATE TABLE highest_paid_employees AS
SELECT *
FROM employees e
WHERE e.salary>30000;

DELETE FROM highest_paid_employees
WHERE `manager_id` = 42;

UPDATE highest_paid_employees
SET salary = salary+5000
where department_id =1;

SELECT hpe.department_id, avg(hpe.salary) as `avg_salary`
FROM highest_paid_employees as hpe
GROUP BY hpe.department_id
ORDER BY hpe.department_id;


#15
#16


#17
use soft_uni;
#first
SELECT e.department_id, max(e.salary)
FROM employees e
GROUP BY e.department_id;

#second nest
SELECT e.department_id, max(e.salary)
FROM employees e
JOIN (
	SELECT e.department_id, max(e.salary) as `first_salary`
	FROM employees e
	GROUP BY e.department_id
) as `first_max_salary`
ON e.department_id = first_max_salary.department_id
WHERE e.salary<first_max_salary.first_salary
GROUP BY e.department_id;

#final_nest
SELECT e.department_id, max(e.salary) as `third_highest_salary`
FROM employees e
JOIN(
	SELECT e.department_id, max(e.salary) as `second_salary`
	FROM employees e
		JOIN (
			SELECT e.department_id, max(e.salary) as `first_salary`
			FROM employees e
			GROUP BY e.department_id
	) as `first_max_salary`
	ON e.department_id = first_max_salary.department_id
	WHERE e.salary<first_max_salary.first_salary
	GROUP BY e.department_id
) as `second_max_salary`
ON e.department_id = second_max_salary.department_id
WHERE e.salary<second_max_salary.second_salary
GROUP BY e.department_id;





