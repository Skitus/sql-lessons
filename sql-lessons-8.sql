-- query 25
alter table employees drop column last_updated;

alter table employees add column last_updated  timestamp without time zone default now();

CREATE OR REPLACE FUNCTION f_last_update_employees()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.last_updated = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER last_update_employees
BEFORE UPDATE ON employees
FOR EACH ROW
EXECUTE PROCEDURE f_last_update_employees();


CREATE OR REPLACE PROCEDURE update_salaries()
LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE employees SET salary = salary * 1.1;
END;
$$;

CALL update_salaries();

-- query 26
create index employees_name on employees(name);

create index employee_comp_salary_department_id on employees(salary, department_id);

explain select * from employees where name='Alice';

explain analyze select * from employees where name='Alice';