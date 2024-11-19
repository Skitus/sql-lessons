CREATE TABLE departments (
    id UUID PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE employees (
    id UUID PRIMARY KEY,
    name VARCHAR,
    position VARCHAR,
    salary INT,
    department_id UUID NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, name) VALUES
    ('8d12e001-64a3-4e19-8312-dbb0e1d6a1a7', 'Sales'),
    ('9f3a5319-24a7-49a8-8eb0-8d3a6e2f7e90', 'Marketing'),
    ('2d92a5d9-facb-4c3a-a8ea-3cb6e8e9cb6b', 'HR'),
    ('6a96e11d-dc4e-4c9c-bb36-f3e9a5e45b36', 'Engineering');

INSERT INTO employees (id, name, position, salary, department_id) VALUES
    ('e032b13a-c769-4ff2-9a5f-df3bb624c145', 'Alice', 'Manager', 12000, '8d12e001-64a3-4e19-8312-dbb0e1d6a1a7'), -- Sales
    ('be5bfe67-a2d4-4f24-8c3e-ec8af695c733', 'Bob', 'Sales Representative', 8000, '8d12e001-64a3-4e19-8312-dbb0e1d6a1a7'), -- Sales
    ('9dcfc14f-5832-4f85-a47c-cd3a01c792d5', 'Carol', 'Marketing Specialist', 6000, '9f3a5319-24a7-49a8-8eb0-8d3a6e2f7e90'), -- Marketing
    ('a3df174b-13d3-4b4b-9ff4-8a34a9a7e3af', 'Dave', 'HR Manager', 7000, '2d92a5d9-facb-4c3a-a8ea-3cb6e8e9cb6b'), -- HR
    ('1a01b8b6-b6ec-4d9c-80cf-9a8e1a6b3e89', 'Eve', 'Engineer', 9000, '6a96e11d-dc4e-4c9c-bb36-f3e9a5e45b36'), -- Engineering
    ('ef0b8d61-872d-439a-bd4c-1e34f7957a69', 'Frank', 'Senior Engineer', 15000, '6a96e11d-dc4e-4c9c-bb36-f3e9a5e45b36'); -- Engineering

-- query 1
SELECT * 
FROM public.employees 
WHERE salary > 5000;


-- query 2
SELECT 
    employees.name,
    employees.position,
    employees.salary,
    departments.name AS department_name
FROM public.employees 
LEFT JOIN departments ON employees.department_id = departments.id 
WHERE salary > 5000 AND departments.name = 'Sales';

-- query 3
SELECT 
    departments.name, 
    SUM(employees.salary) AS total_salary
FROM employees
LEFT JOIN departments ON employees.department_id = departments.id
GROUP BY departments.name
HAVING SUM(employees.salary) > 20000;

-- query 4
SELECT *
FROM employees
WHERE employees.salary > (
    SELECT AVG(employees.salary) AS avarage_salary
    FROM employees
);
