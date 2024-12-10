SELECT * FROM public.sales
ORDER BY id ASC 


select employee_id,
	count(*) as total_sales, 
	avg(amount) as avg_quantity,
	sum(amount) as total_revenue
from sales
group by employee_id; 

explain analyze select employee_id,
	count(*) as total_sales, 
	avg(amount) as avg_quantity,
	sum(amount) as total_revenue
from sales
group by employee_id; 

SET max_parallel_workers_per_gather = 4;  -- Например, разрешить до 4 рабочих процессов
SET max_worker_processes = 8;
SET parallel_setup_cost = 100;
SET parallel_tuple_cost = 0.1;

create table logs(
	message varchar,
	user_id uuid default uuid_generate_v1()
)

INSERT INTO logs (message, user_id)
SELECT
    'Log message ' || gs,
    uuid_generate_v1()
FROM generate_series(1, 10000) AS gs;


SELECT COUNT(*) FROM logs;


SELECT * FROM pg_stat_activity;


select message, count(user_id) from logs group by message;

select * from logs

explain analyze select message, count(user_id) from logs group by message;


EXPLAIN ANALYZE
SELECT
    user_id,
    COUNT(*) AS total_logs,
    AVG(length(message)) AS avg_message_length
FROM logs
GROUP BY user_id;

SELECT
    user_id,
    COUNT(*) AS total_logs,
    AVG(LENGTH(message)) AS avg_message_length,
    SUM(LENGTH(message)) AS total_revenue  -- Предположим, что 'revenue' связано с длиной сообщения
FROM logs
GROUP BY user_id;


EXPLAIN ANALYZE
SELECT
    user_id,
    COUNT(*) AS total_logs,
    AVG(LENGTH(message)) AS avg_message_length,
    SUM(LENGTH(message)) AS total_revenue
FROM logs
GROUP BY user_id;

