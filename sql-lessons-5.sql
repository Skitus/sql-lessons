-- query 13
SELECT 
    COUNT(*) AS employee_count,
    departments.name AS department_name,
    MIN(employees.salary) AS min_salary,
    MAX(employees.salary) AS max_salary,
    CASE 	
        WHEN employees.salary >= 10000 THEN 'High'
        WHEN employees.salary >= 5000 AND employees.salary < 10000 THEN 'Medium'
        ELSE 'Low' 
    END AS salary_level
FROM employees
LEFT JOIN departments ON employees.department_id = departments.id
GROUP BY departments.name, 
         CASE 	
            WHEN employees.salary >= 10000 THEN 'High'
            WHEN employees.salary >= 5000 AND employees.salary < 10000 THEN 'Medium'
            ELSE 'Low' 
         END
ORDER BY departments.name, salary_level;


-- query 14
SELECT * FROM employees 
WHERE employees.name LIKE 'A%'
AND employees.name LIKE '%son%'
AND NOT employees.name LIKE '%y';

-- query 15
select 
UPPER(employees.name), 
LOWER(employees.name), 
SUBSTRING(employees.name, 1, 3), 
CONCAT(employees.name, '- Employee') from employees;

-- query 16
SELECT *
FROM employees
WHERE employees.name ILIKE '%an%'
ORDER BY employees.name, employees.salary DESC;

