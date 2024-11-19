-- query 5 
SELECT 
    employees.name,
    departments.name AS department_name,
    employees.salary,
    -- CASE добавляем как отдельное поле
    CASE 
        WHEN employees.salary >= 10000 THEN 'High'
        WHEN employees.salary >= 5000 AND employees.salary < 10000 THEN 'Medium'
        ELSE 'Low' 
    END AS salary_level
FROM employees
-- JOIN отделяем от SELECT
LEFT JOIN departments ON employees.department_id = departments.id;

-- query 6
SELECT 
    employees.*,
    departments.name AS department_name,
    DENSE_RANK() OVER (PARTITION BY departments.name ORDER BY salary DESC) AS department_rank
FROM employees
LEFT JOIN departments ON employees.department_id = departments.id
ORDER BY departments.name, department_rank;

-- query 7 
SELECT 
    employees.name,
    departments.name AS department_name,
    employees.salary,
    SUM(employees.salary) OVER (PARTITION BY departments.name) AS total_department_salary,
    ROUND(AVG(employees.salary) OVER (PARTITION BY departments.name), 2) AS department_average_salary,
    ROUND(
        employees.salary * 100.0 / SUM(employees.salary) OVER (PARTITION BY departments.name), 
        2
    ) AS percentage_of_department_salary
FROM employees
LEFT JOIN departments ON employees.department_id = departments.id;
