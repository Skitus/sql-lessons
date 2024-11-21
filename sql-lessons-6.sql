-- query 17
SELECT *
FROM employees 
WHERE employees.name LIKE 'E%'
ORDER BY employees.salary DESC
LIMIT 5 OFFSET 1;

-- query 18 a
SELECT *
FROM employees 
WHERE employees.salary > 10000
UNION
SELECT * from employees
WHERE employees.name LIKE '%son';

-- query 18 b
SELECT *
FROM employees 
WHERE employees.salary > 10000
UNION ALL
SELECT * from employees
WHERE employees.name LIKE '%son';

-- query 19 a
SELECT *
FROM employees 
WHERE employees.salary > 10000
INTERSECT
SELECT * from employees
WHERE employees.name LIKE '%son';

-- query 19 b
SELECT *
FROM employees 
WHERE employees.salary > 10000
INTERSECT ALL
SELECT * from employees
WHERE employees.name LIKE '%son';

-- query 20 
SELECT *
FROM employees 
WHERE employees.salary > 10000
EXCEPT
SELECT * from employees
WHERE employees.name LIKE '%son';
