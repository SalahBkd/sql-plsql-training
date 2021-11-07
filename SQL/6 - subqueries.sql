/*
A Subquery or Inner query or a Nested query is a query within another SQL query and embedded 
within the WHERE clause.

Types of subqueries:
  - Single row sub-query:
    Has special operators
    =, <>..etc
    
  - Multiple-row subquery
    Has special operators
    IN, ALL, ANY
  - you can use group functions within subqueries
  - you can use subqueries in Having clause
  - If there is no row is returned from the subquery, then the whole query is considered 
    to be NULL
  
*/

/*Normal subquery: chkon 3ndo salaire kbar mn Abel*/
-- best practice: run the query first, then make as a subquery
select salary from employees where last_name = 'Abel';

select employee_id, first_name, last_name, salary
from employees
where salary > (select salary from employees where last_name = 'Abel');

  
-- Single row sub-query
/* when using single row operator , the query should also return single row, if it returns
   more than one row, it throws an error*/
-- single row operators: (<, >, <= , >=, <>, != )
select * 
from employees
where job_id = (select job_id from employees where last_name = 'Abel');

-- Using group function in subqueries
/*b4it employee li 3ando le max salaire*/
select * 
from employees
where salary = (select MAX(salary) from employees);

-- Using subqueries in HAVING clause
select department_id, count(employee_id)
from employees
group by department_id
having count(employee_id) > (select count(1) from employees where department_id = 90);

-- No row is returned, all the select return null
select employee_id, first_name, last_name, salary
from employees
where salary > (select salary from employees where last_name='TOTO');

-- Multiple rows subquery
-- Used with (IN, ANY, ALL)
select salary from employees where department_id=90;
-- IN ---
select employee_id, first_name, last_name, salary 
from employees 
where salary in (select salary from employees where department_id=90);

-- ANY (ay employee kataba9 3lih salary kbar ou = () ---
select employee_id, first_name, last_name, salary 
from employees 
where salary >=any (select salary from employees where department_id=90);

-- ALL ---
select employee_id, first_name, last_name, salary 
from employees 
where salary >=all (select salary from employees where department_id=90);







