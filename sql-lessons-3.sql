-- query 8 
ALTER TABLE employees ADD COLUMN hire_date DATE;

ALTER TABLE employees DROP COLUMN hire_date;

SELECT name, hire_date, AGE(hire_date)
FROM employees;

SELECT 
    name, 
    hire_date, 
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM hire_date) AS years_worked
FROM employees;

SELECT 
    name, 
    hire_date, 
    DATE_PART('year', AGE(hire_date)) AS years_worked
FROM employees;


-- query 9
SELECT 
    EXTRACT(YEAR FROM hire_date) AS year, 
    EXTRACT(QUARTER FROM hire_date) AS quarter, 
    COUNT(*) AS employee_count
FROM employees
GROUP BY 
    EXTRACT(YEAR FROM hire_date), 
    EXTRACT(QUARTER FROM hire_date)
ORDER BY year, quarter;

-- query 10 
ALTER TABLE employees ADD COLUMN last_promotion_date DATE;

SELECT 
    employees.name,
    employees.last_promotion_date,
    EXTRACT(YEAR FROM AGE(last_promotion_date)) AS years_since_last_promotion
FROM employees
WHERE EXTRACT(YEAR FROM AGE(last_promotion_date)) > 3;