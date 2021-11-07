--PROBLEM
-- Cartesian product
select
employees.employee_id,
employee.firstname,
departments.department_id,
departments.department_name
from employees, departments
order by employee_id;

-- N.B: the minimum join clauses must be n-1

-- TYPES OF JOINS: 
		----Equiijoin: inner join
		
		----Nonequiijoin: uses comparison operator instead of the equal sign like >, <, >=, <= along with 		conditions.
		
		----Outerjoin: 
			/*LEFT OUTER JOIN or LEFT JOIN
			RIGHT OUTER JOIN or RIGHT JOIN
			FULL OUTER JOIN or FULL JOIN*/
		
		----SelfJoin

-- Equiijoin - Inner Join - Simple Join
-- katrad lna data mn two tables, khas ykon column dyal one table fi lakhra
select 
employees.employee_id,
employee.first_name,
departments.department_id,
departments.department_name
from employees, departments
where employees.employee_id = departments.employee_id
order by employee_id;

-- inner join plus conditions
select 
employees.employee_id,
employees.first_name,
departments.department_id,
departments.department_name
from employees, departments
where employees.employee_id = departments.department_id
and employee.department_id > 40 --the condition
order by employee_id;

-- table names as aliases
select 
emp.employee_id,
emp.first_name,
emp.department_id,
depts.department_name
from employees emp, departments depts -- Aliases
where emp.employee_id = depts.department_id
order by employee_id;

-- joining more than two tables -- 3 --
-- ta9dar joini ktar mn 2 tables, chuf exemple
select 
emp.employee_id,
emp.first_name,
emp.department_id,
depts.department_name,
depts.location_id,
loc.city
from employees emp, departments depts, locations loc
where emp.employee_id = depts.employee_id
and depts.location_id = loc.location_id
order by employee_id;

--Nonequiijoin
-- Is a join condition containing something other than an equality operator
-- kat9dar tcomparer w tzid les conditions more customized bla = operator
select
emp.employee_id,
emp.first_name,
emp.salary,
grades.grade_level
from employees emp, job_grades grades
where emp.salary between grades.lowest_sal and grades.highest_sal;

-- Outer Join
/*What is outer join ?
  An outer join returns a set of records (or rows) that include what an inner join would 
  return but also includes other rows for which no corresponding match is found in the 
  other table. There are three types of outer joins: Left Outer Join (or Left Join) 
  Right Outer Join (or Right Join) Full Outer Join (or Full Join)
*/
/*
  EMP - DEPT
    if we used simple join:
    employee.department_id = departments.depatment_id;
    If a dept_id of an employee is null, then the query will result in null.
*/
/*OUTER JOIN bhal inner join, katrad rows, plus katrad ta rows li ma3ndhomch corresponding
  match.*/
  
-- RULE OF THUMB
 /*
  Khas dima ta3raf achman table li MAIN li 4adi tjib mno data.
  Ila kan 3andi FK fi la table dyali li hwa PK fi table tanya, OUTER aykon fi tanya
 */
  
-- example1: outerjoin
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees, departments
where
employees.department_id(+) = departments.department_id
 -- my main table is employee, so this will return all the unsigned dept names
 -- jib ga3 les employes w ga3 les departements li ma3ndhomch employee 
order by employee_id;

--example1: using ANSI syntax
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees
right join departments on (employees.department_id = departments.department_id)
 -- my main table is employee, so this will return all the unsigned dept names
  -- jib ga3 les employes w ga3 les departements li ma3ndhomch employee 
order by employee_id;

-- example2: outerjoin
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees, departments
where
employees.department_id = departments.department_id(+)
 -- my main table is employee, this will return the admired result
  -- jib ga3 les emmployes w 7ta hadok li ma3ndhumch departement endhom (null)
order by employee_id;

--example2: using ANSI syntax
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees
left join departments on (employees.department_id = departments.department_id)
 -- jib ga3 les emmployes w 7ta hadok li ma3ndhumch departement endhom (null)
order by employee_id;

-- to know how many rows should be retrieved
select count(1) from employees where employees.salary > 2500;

-- example of outer join
select 
employees.employee_id,
employees.first_name,
employees.department_id,
departments.department_name,
departments.location_id,
locations.city,
countries.country_name
from
employees, departments, locations, countries
where employees.department_id = departments.department_id(+)
and departments.location_id = locations.location_id(+)
and locations.country_id = countries.country_id(+)
and employees.salary > 2500;

--full outer join: A full outer join performs a join between two tables that returns the results of an INNER join as well as the results of a left and right outer join.
-- example1: 
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees, departments
where
employees.department_id(+) = departments.department_id(+)
 -- jib ga3 les employes w ga3 les departements li ma3ndhomch employee 
order by employee_id;

-- example1: using ANSI syntax
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees
full outer join departments
on (employees.department_id = departments.department_id)
 -- my main table is employee, so this will return all the unsigned dept names
 -- jib ga3 les employes w ga3 les departements li ma3ndhomch employee 
order by employee_id;

-- Self join
/*
  A self join is a join in which a table is joined with itself (which is also called
  Unary relationships), especially when the table has a FOREIGN KEY which references 
  its own PRIMARY KEY. To join a table itself means that each row of the table is 
  combined with itself and with every other row of the table.
*/
-- Self join example: 
SELECT e1.last_name||' works for '||e2.last_name
"Employees and Their Managers"
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id;





















