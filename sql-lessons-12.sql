create table sales(
	id  UUID NOT NULL DEFAULT uuid_generate_v1() PRIMARY KEY, 
	sale_date timestamp with time zone default now(), 
	amount int,
	employee_id uuid not null,
	FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SELECT uuid_generate_v1();


insert into sales(amount, employee_id) VALUES
	(1300, 'e032b13a-c769-4ff2-9a5f-df3bb624c145'),
	(1500, 'be5bfe67-a2d4-4f24-8c3e-ec8af695c733'),
	(5000, '9dcfc14f-5832-4f85-a47c-cd3a01c792d5'),
	(7000, 'a3df174b-13d3-4b4b-9ff4-8a34a9a7e3af'),
	(200, '1a01b8b6-b6ec-4d9c-80cf-9a8e1a6b3e89'),
	(9000, 'ef0b8d61-872d-439a-bd4c-1e34f7957a69')

insert into sales(amount, employee_id, sale_date) values
	(1300, 'e032b13a-c769-4ff2-9a5f-df3bb624c145', '2024-11-07 00:22:31.75764+02'),
	(1500, 'be5bfe67-a2d4-4f24-8c3e-ec8af695c733', '2024-11-07 00:22:31.75764+02'),
	(5000, '9dcfc14f-5832-4f85-a47c-cd3a01c792d5', '2024-11-07 00:22:31.75764+02'),
	(7000, 'a3df174b-13d3-4b4b-9ff4-8a34a9a7e3af', '2024-11-07 00:22:31.75764+02'),
	(200, '1a01b8b6-b6ec-4d9c-80cf-9a8e1a6b3e89', '2024-11-07 00:22:31.75764+02'),
	(9000, 'ef0b8d61-872d-439a-bd4c-1e34f7957a69', '2024-11-07 00:22:31.75764+02')


select * from sales;

WITH cte AS (
    -- Агрегируем данные по месяцам для каждого сотрудника
    SELECT 
        DATE_TRUNC('month', sale_date) AS month,  -- Приводим дату к началу месяца
        employee_id,
        SUM(amount) AS amount  -- Суммируем продажи за месяц
    FROM sales
    GROUP BY month, employee_id
),
cte_with_lag AS (
    -- Вычисляем прирост за месяц по отношению к предыдущему
    SELECT 
        employee_id,
        month,
        amount,
        LAG(amount, 1) OVER (PARTITION BY employee_id ORDER BY month) AS last_month_sales,  -- Доход предыдущего месяца
        amount - LAG(amount, 1, 0) OVER (PARTITION BY employee_id ORDER BY month) AS growth  -- Прирост (текущий месяц - предыдущий)
    FROM cte
)
SELECT 
    employee_id,
    month,
    amount,
    last_month_sales,
    growth
FROM cte_with_lag
ORDER BY growth DESC  -- Сортируем по приросту, чтобы найти наибольший