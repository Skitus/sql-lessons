-- query 27 
create table customer(
	id uuid primary key,
	name varchar
);

create table orders(
	id uuid primary key,
	customer_id uuid not null, 
	order_date date,
	amount decimal,
	status varchar,
	foreign key (customer_id) references customer(id)
);

insert into customer(id, name) values('73e45caf-afd1-4cff-81e5-7fd54b90228e', 'artur'),
									 ('72a5c88e-5c85-4656-bc1b-6a67f13ef7c0', 'maksim'),
									 ('72a5c88e-5c85-4656-bc1b-6a67f13ef7c1', 'luka'),
									 ('72a5c88e-5c85-4656-bc1b-6a67f13ef7c2', 'igor'),
									 ('72a5c88e-5c85-4656-bc1b-6a67f13ef7c3', 'skitus');

delete from customer;

select * from customer;

INSERT INTO orders(id, customer_id, order_date, amount, status) 
VALUES
('e9b5f417-1436-48c5-8b6e-93ab872f90b6', '73e45caf-afd1-4cff-81e5-7fd54b90228e', '2024-11-01', 150.50, 'Shipped'),
('32bdf60a-62ed-4a13-826b-e57f4b44f89e', '72a5c88e-5c85-4656-bc1b-6a67f13ef7c0', '2024-11-03', 250.00, 'Pending'),
('51a6c384-d50a-47b2-bf0f-593b81a57c09', '72a5c88e-5c85-4656-bc1b-6a67f13ef7c1', '2024-11-05', 300.75, 'Shipped'),
('ab202dfb-9d97-4d98-9d2f-5e9418505f67', '72a5c88e-5c85-4656-bc1b-6a67f13ef7c2', '2024-11-06', 125.00, 'Delivered'),
('0c1b8f44-fdf7-4265-b799-7b1f77d19da4', '72a5c88e-5c85-4656-bc1b-6a67f13ef7c3', '2024-11-08', 99.99, 'Canceled');

select * from orders;

select status, count(*) as total_count from orders 
left join customer on orders.customer_id = customer.id
group by status;

select *, RANK() OVER( order by order_date) from orders;


-- query 28 

create table manager(
	id uuid not null primary key,
	name varchar
);

create table organization(
	id uuid not null primary key,
	name varchar,
	manager_id uuid,
	foreign key (manager_id) references manager(id)
);

INSERT INTO manager (id, name) VALUES
('11111111-1111-1111-1111-111111111111', 'Alice'), -- CEO
('22222222-2222-2222-2222-222222222222', 'Bob'),   -- Senior Manager
('33333333-3333-3333-3333-333333333333', 'Carol'); -- Manager


select * from manager;

INSERT INTO organization (id, name, manager_id) VALUES
('44444444-4444-4444-4444-444444444444', 'David', '22222222-2222-2222-2222-222222222222'), -- Bob's subordinate
('55555555-5555-5555-5555-555555555555', 'Eve', '22222222-2222-2222-2222-222222222222'),   -- Bob's subordinate
('66666666-6666-6666-6666-666666666666', 'Frank', '33333333-3333-3333-3333-333333333333'), -- Carol's subordinate
('77777777-7777-7777-7777-777777777777', 'Grace', '33333333-3333-3333-3333-333333333333'); -- Carol's subordinate

select * from organization;

WITH RECURSIVE manager_hierarchy AS (
    -- Начальный уровень (руководители без менеджеров)
    SELECT 
        o.id AS employee_id,
        o.name AS employee_name,
        o.manager_id,
        o.name AS path
    FROM organization o
    WHERE o.manager_id IS NULL

    UNION ALL

    -- Рекурсивный запрос для подчинённых
    SELECT 
        o.id AS employee_id,
        o.name AS employee_name,
        o.manager_id,
        CONCAT(mh.path, ' -> ', o.name) AS path
    FROM organization o
    INNER JOIN manager_hierarchy mh ON o.manager_id = mh.employee_id
)
-- Итоговый выбор
SELECT * FROM manager_hierarchy;


