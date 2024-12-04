-- CREATE TABLE employees (
--     id UUID PRIMARY KEY,
--     name VARCHAR,
--     position VARCHAR,
--     salary INT,
--     department_id UUID NOT NULL,
--     FOREIGN KEY (department_id) REFERENCES departments(id)
-- );

create table projects_v2 (
	id uuid primary key,
	name varchar
);

CREATE TYPE status_task_v2 AS ENUM('Pending', 'Completed');

ALTER TABLE tasks ALTER COLUMN status TYPE status_task_v2 USING status::text::status_task_v2;

DROP TYPE status_task;

ALTER TYPE status_task_v2 RENAME TO status_task;



create table tasks (
	id uuid primary key,
	name varchar,
	deadline timestamp with time zone,
	status status_task,
	employee_id UUID NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
	project_id UUID NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects_v2(id)
);

INSERT INTO projects_v2 (id, name) VALUES
    ('72a5c88e-5c85-4656-bc1b-6a67f13ef7c0', 'Project Alpha'),
    ('a4e5b79f-34f8-4bc9-b27b-0cd3a45ef6b0', 'Project Beta'),
    ('b3f7d89c-5a2e-43e4-a328-263f5f3a4fa3', 'Project Gamma');

INSERT INTO tasks (id, name, deadline, status, employee_id, project_id) VALUES
    ('f7e5f27b-963a-45a4-9c88-d3d6d9ac2449', 'Task 1: Sales Report', '2024-12-10 09:00:00+00', 'Pending', 'e032b13a-c769-4ff2-9a5f-df3bb624c145', '72a5c88e-5c85-4656-bc1b-6a67f13ef7c0'),
    ('e30e55d4-4c8d-44ac-b8de-f4a54c443d63', 'Task 2: Marketing Campaign', '2024-12-15 17:00:00+00', 'Completed', '9dcfc14f-5832-4f85-a47c-cd3a01c792d5', 'a4e5b79f-34f8-4bc9-b27b-0cd3a45ef6b0'),
    ('8b3a33b5-2a5b-4a89-b8de-76c8395b7431', 'Task 3: HR Training', '2024-12-20 14:00:00+00', 'Pending', 'a3df174b-13d3-4b4b-9ff4-8a34a9a7e3af', 'b3f7d89c-5a2e-43e4-a328-263f5f3a4fa3'),
    ('a1c57b9e-cbd4-44e9-9b0d-2c2bda09d3a5', 'Task 4: Engineering Design', '2024-12-25 12:00:00+00', 'Pending', '1a01b8b6-b6ec-4d9c-80cf-9a8e1a6b3e89', '72a5c88e-5c85-4656-bc1b-6a67f13ef7c0'),
    ('4f5a4f56-e7a9-4239-b4fa-690469d90e0b', 'Task 5: Project Documentation', '2024-12-30 10:00:00+00', 'Completed', 'ef0b8d61-872d-439a-bd4c-1e34f7957a69', 'a4e5b79f-34f8-4bc9-b27b-0cd3a45ef6b0');


-- query 1
select 
tasks.name,
projects_v2.name,
count(*)
from tasks
left join projects_v2 on tasks.project_id = projects_v2.id
where tasks.deadline < now()
and tasks.status = 'Pending'
group by 
tasks.name,
projects_v2.name;

-- query 2
SELECT 
    projects_v2.name AS project_name,
    COUNT(tasks.id) AS total_tasks,
    COUNT(CASE WHEN tasks.status = 'Completed' THEN 1 END) AS completed_tasks,
    ROUND(
        COUNT(CASE WHEN tasks.status = 'Completed' THEN 1 END) * 100.0 / COUNT(tasks.id),
        2
    ) AS completion_percentage
FROM tasks
LEFT JOIN projects_v2 ON tasks.project_id = projects_v2.id
GROUP BY projects_v2.name;


-- query 3
WITH RECURSIVE manager_hierarchy AS (
    SELECT 
        o.id AS employee_id,
        o.name AS employee_name,
        o.manager_id,
        o.name AS path
    FROM organization o
    WHERE o.manager_id IS NULL

    UNION ALL

    SELECT 
        o.id AS employee_id,
        o.name AS employee_name,
        o.manager_id,
        CONCAT(mh.path, ' -> ', o.name) AS path
    FROM organization o
    INNER JOIN manager_hierarchy mh ON o.manager_id = mh.employee_id
)
SELECT * FROM manager_hierarchy;

