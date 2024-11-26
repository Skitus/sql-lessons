-- query 24
create table employee_data(
	id uuid primary key,
	details jsonb
)

INSERT INTO employee_data (id, details) values('73e45caf-afd1-4cff-81e5-7fd54b90228e', '{  
	"name": "John",
  "position": "Manager",
  "skills": ["Leadership", "Communication"],
  "salary": 12000}');

select * from employee_data where (details-> 'salary')::int > 10000 and details @> '{"skills":"Leadership"}';

select * from employee_data
where (details-> 'salary')::int > 100000 
  and details::jsonb @> '{"skills":"Leadership"}';