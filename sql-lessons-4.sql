-- query 11 a
WITH cte AS (
    SELECT 
        employees.id AS employee_id,
        ROUND(AVG(employees.salary) OVER (PARTITION BY departments.name), 2) AS department_average_salary
    FROM employees
    LEFT JOIN departments ON employees.department_id = departments.id
)
SELECT 
    employees.name,
    employees.position,
    employees.salary,
    EXTRACT(YEAR FROM AGE(employees.last_promotion_date)) AS years_since_last_promotion
FROM employees
LEFT JOIN departments ON employees.department_id = departments.id
JOIN cte ON employees.id = cte.employee_id
WHERE employees.salary > cte.department_average_salary;

-- query 11 b
SELECT 
    subquery.name,
    subquery.position,
    subquery.salary,
	subquery.years_since_last_promotion
FROM (
    SELECT 
        employees.id AS employee_id,
        employees.name,
        employees.position,
        employees.salary,
        ROUND(AVG(employees.salary) OVER (PARTITION BY departments.name), 2) AS department_average_salary,
		EXTRACT(YEAR FROM AGE(employees.last_promotion_date)) AS years_since_last_promotion
    FROM employees
    LEFT JOIN departments ON employees.department_id = departments.id
) subquery
WHERE subquery.salary > subquery.department_average_salary;

-- query 12
select   COUNT(*) AS employee_count,
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(employees.hire_date)) >= 10 THEN 'old but gold'
		WHEN EXTRACT(YEAR FROM AGE(employees.hire_date)) >= 3 AND EXTRACT(YEAR FROM AGE(employees.hire_date)) < 10 THEN 'old'
		WHEN EXTRACT(YEAR FROM AGE(employees.hire_date)) >= 1 AND EXTRACT(YEAR FROM AGE(employees.hire_date)) < 3 THEN 'trainee'
        ELSE 'noobs' 
    END as years_of_hire_date
FROM employees
GROUP BY years_of_hire_date; 
