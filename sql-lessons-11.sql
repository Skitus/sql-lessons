SELECT indexname AS index_name,
       tablename AS table_name
FROM pg_indexes
WHERE schemaname = 'public';

create index employees_hire_date on employees (hire_date);

explain analyze select name, hire_date from employees 
where extract(year from hire_date) = 2024
and extract(month from hire_date) = 12;

explain analyze select name, hire_date from employees 
where hire_date >= '2024-12-01' AND hire_date < '2025-01-01';


create table salary_history(
	id uuid primary key,
	old_salary int,
	new_salary int, 
	change_date timestamp with time zone,
	employee_id uuid not null,
	FOREIGN KEY (employee_id) REFERENCES employees(id)
)

-- Вставка данных в таблицу salary_history
INSERT INTO salary_history (id, employee_id, old_salary, new_salary, change_date) VALUES
    ('1a01b8b6-b6ec-4d9c-80cf-9a8e1a6b3e87', '1a01b8b6-b6ec-4d9c-80cf-9a8e1a6b3e89', 9500, 9900, '2000-01-08'),
    ('1db947b4-6e3f-4bd0-a77b-51a89a9a1b7b', '1db947b4-6e3f-4bd0-a77b-51a89a9a1b7b', 50000, 55000, '2015-06-15'),
    ('9dcfc14f-5832-4f85-a47c-cd3a01c792d5', '9dcfc14f-5832-4f85-a47c-cd3a01c792d5', 6200, 6600, '2005-03-25'),
    ('a3df174b-13d3-4b4b-9ff4-8a34a9a7e3af', 'a3df174b-13d3-4b4b-9ff4-8a34a9a7e3af', 7200, 7700, '2021-02-10'),
    ('be5bfe67-a2d4-4f24-8c3e-ec8af695c733', 'be5bfe67-a2d4-4f24-8c3e-ec8af695c733', 8500, 8800, '2024-12-10'),
    ('e032b13a-c769-4ff2-9a5f-df3bb624c145', 'e032b13a-c769-4ff2-9a5f-df3bb624c145', 12500, 13200, '2013-12-12'),
    ('ef0b8d61-872d-439a-bd4c-1e34f7957a69', 'ef0b8d61-872d-439a-bd4c-1e34f7957a69', 16000, 16500, '2023-08-11');


select * from salary_history 
where employee_id = '1a01b8b6-b6ec-4d9c-80cf-9a8e1a6b3e89';


select * from information_schema.tables where table_schema='public';