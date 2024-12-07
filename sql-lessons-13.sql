SELECT 
    e.name,
    e.salary,
    e.department_id,
    dept_avg.avg_salary_department,
    company_avg.avg_salary_company
FROM 
    employees e
JOIN (
    -- Вычисляем среднюю зарплату по каждому отделу
    SELECT 
        department_id,
        AVG(salary) AS avg_salary_department
    FROM 
        employees
    GROUP BY 
        department_id
) dept_avg ON e.department_id = dept_avg.department_id
JOIN (
    -- Вычисляем среднюю зарплату по всей компании
    SELECT 
        AVG(salary) AS avg_salary_company
    FROM 
        employees
) company_avg ON TRUE
WHERE 
    e.salary > dept_avg.avg_salary_department -- зарплата больше средней по отделу
    AND e.salary < company_avg.avg_salary_company -- зарплата меньше средней по компании
ORDER BY 
    e.salary;


WITH 
    dept_avg AS (
        -- Вычисляем среднюю зарплату по каждому отделу
        SELECT 
            department_id,
            AVG(salary) AS avg_salary_department
        FROM 
            employees
        GROUP BY 
            department_id
    ),
    company_avg AS (
        -- Вычисляем среднюю зарплату по всей компании
        SELECT 
            AVG(salary) AS avg_salary_company
        FROM 
            employees
    )
SELECT 
    e.name,
    e.salary,
    e.department_id,
    dept_avg.avg_salary_department,
    company_avg.avg_salary_company
FROM 
    employees e
JOIN dept_avg ON e.department_id = dept_avg.department_id
JOIN company_avg ON TRUE  -- Мы используем ON TRUE, потому что company_avg содержит одну строку для всех сотрудников
WHERE 
    e.salary > dept_avg.avg_salary_department  -- зарплата больше средней по отделу
    AND e.salary < company_avg.avg_salary_company  -- зарплата меньше средней по компании
ORDER BY 
    e.salary;




SELECT 
    employees.name,
    employees.salary,
    company_avg.avg_salary_company
FROM 
    employees
JOIN (
    SELECT 
        AVG(salary) AS avg_salary_company
    FROM 
        employees
) company_avg ON employees.salary > company_avg.avg_salary_company;


select * from employees;