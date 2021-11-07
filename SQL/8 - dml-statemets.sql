/*Data Manupilation Language DML*/
-- Insert
-- Update
-- Delete / TRUNCATE (DDL), delete can be rolled back, truncate cannot 

--Transaction: a set of DML statements that form a logical unit
/*INSERT STATEMENT*/
-- Notes: you should know the STRUCTURE of tabel and the CONSTRAINTS before inserting.
desc departments;
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (28, marketing, 100, 1700)
COMMIT;

-- Null can be inserted explicitly
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (28, marketing, null, null)
COMMIT;
--OR IMPLICITLY
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (28, marketing)
COMMIT;

-- Special values can be inserted like SYSDATE..etc
desc employees;
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, 
hire_date, job_id)
VALUES (2, 'salah', 'boukadi', 'salah@gmail.com', 0637163, SYSDATE, 'IT_PROG');

/*Common insert errors*/
  --Mendatory value missing for a NOT null column
  --Duplicate value violating any unique or primary key constraint (PK can't be null, UQ can be null)
  --any value violating a CHECK constraint
  --referential integrity maintained for FK constraint
  --data type mismatch or values too wide to fit in.
  -- B.P: use column list when inserting
  
/*Creating scripts*/
desc departments; 
insert into departments (department_id, department_name, location_id)
values (&department_id, '&department_name', &location);

/*Insert with subquery*/
insert into xx_emp (empno, fname, salary)
select employee_id, first_name, salary from employees;
select * from xx_emp;

/*UPDATE statement*/
-- B.P: using primary key in where
update employees
set salary = 24100
where employee_id = 100; 
commit;

-- not B.P: it could be more than one emp with name steven
update employees
set salary = 24100
where first_name = 'Steven'; 
commit;

-- if we use update with set only it will update all the columns
update employees
set salary = 0;
commit;

-- Copy table
create table copy_emp
as select * from employees;

--Updating multiple columns at the same time
update copy_emp
set first_name = 'Salah', salary = 5000
where employee_id = 100;
select * from copy_emp where employee_id = 100;

--Subquery in update
--make salary of emp 100 like the salary of emp 200
select * from copy_emp where employee_id in (100, 200);
update copy_emp
set salary = (select salary from copy_emp where employee_id = 200);
where employee_id = 100;
commit;

--Returning data from other tables
update copy_emp
set salary = 0;
select * from copy_emp;

-- if it runs without where it will insert NULL value in every addition rows
update copy_emp ce
set salary = (select salary from employees e where ce.employee_id = e.employee_id)
where exists(select 1 from employees e where ce.employee_id = e.employee_id);





















                                                                                                                                                                                 
