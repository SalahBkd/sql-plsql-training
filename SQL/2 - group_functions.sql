-- MAX/MIN you can use them with dates and cahracter
-- numbers
select max(salary), min(salary) from employees;

-- A to Z - character
select max(first_name), min(first_name) from employees;

-- date
select max(hire_date), min(hire_date) from employees;

-- N.B you can not use sum and avg with chars and dates, ONLY NUMBERS
select sum(first_name), avg(first_name) from emmployees;

-- the only function that doesn't ignore null and duplicate values
select count(*) from employees;
select count(1) from employees; -- same as count(*)

-- count(column) ignores null  values
select count(commission_pct) from employees;

select count(distinct department_id) from employees;

-- handling null values
select count(nvl(department_id, 0)) from employees;

-- count employees from departments 90
select count(employee_id) from employees where department_id = 90;

-- look up doc for more info

-- GROUP BY
select employee_id, sum(salary) from employees
group by employee_id; -- all the columns in the select should appear in GROUP BY

-- group by based on two columns
select department_id, job_id, sum(salary) from employees
group by department_id, job_id; -- all the columns in the select should appear in GROUP BY

-- "not a GROUP BY expression", error
select department_id, job_id, sum(salary) from employees
group by department_id; -- all the columns in the select should appear in GROUP BY

-- you cannot use aliases with group by
select department_id, sum(salary)
from employees group by d;

select department_id, sum(salary) 
from employees where department_id > 30
group by department_id
order by 1, 2;

-- WHERE with GROUP FUNCTIONS
select department_id, sum(salary) 
from employees 
having sum(salary) > 10000
group by department_id
order by 1, 2;

-- SOLUTION: use HAVING
select department_id, sum(salary) 
from employees 
having sum(salary) > 10000
group by department_id
order by 1, 2;

-- nested group functions
select max(sum(salary)) -- only 2 group functions can be nested
from employees
group by department_id;
