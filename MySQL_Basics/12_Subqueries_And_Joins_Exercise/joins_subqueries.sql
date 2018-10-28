#7
SELECT e.employee_id, e.first_name, p.name
FROM employees e
JOIN employees_projects ep
ON e.employee_id=ep.employee_id
JOIN projects p
on ep.project_id = p.project_id
WHERE date(p.start_date) > '2002-08-13'  AND p.end_date Is NULL
ORDER BY e.first_name, p.name
Limit 5;

#8
SELECT 
	e.employee_id, 
    e.first_name, 
    (CASE
		WHEN p.start_date > '2004-12-31' THEN NULL
        ELSE p.name    
    END) as `project_name`
FROM employees e
JOIN employees_projects ep
ON e.employee_id=ep.employee_id
JOIN projects p
on ep.project_id=p.project_id
WHERE e.employee_id=24
ORDER BY project_name;

#16
#
SELECT count(cq.country_name)
FROM(
SELECT 
	c.country_code,
    c.country_name,
    mc.mountain_id
FROM countries c
LEFT JOIN mountains_countries mc
ON c.country_code = mc.country_code
WHERE mc.mountain_id IS NULL
) as cq;



