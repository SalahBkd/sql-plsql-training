-- The cross joins
/*the cross join returns a Cartesian product of rows from both tables*/
/*We replace , between tables with CROSS JOIN*/
/*Useful CROSS JOIN example: ila b4it nsalaj student fi 4 matieres obigatoire*/
select
employees.employee_id,
employees.first_name,
departments.department_id,
departments.department_name
from employees
CROSS JOIN departments
order by employee_id;

-- Natural Join
/*A NATURAL JOIN is a JOIN operation that creates an implicit join clause for you 
based on the common columns in the two tables being joined. Common columns are columns 
that have the same name in both tables. A NATURAL JOIN can be an INNER join, a LEFT OUTER 
join, or a RIGHT OUTER join.*/
select
departments.department_id,
departments.department_name,
location_id, -- cannot prefix table name in the match column
locations.city
from departments
NATURAL JOIN locations;

-- N.B: NATURAL JOIN  =  EQUEJOIN
-- N.B: natural join rarely used in real life

-- Joins with USING
select
employees.employee_id,
employees.first_name,
department_id, -- cannot prefix table name in the match column
departments.department_name
from employees
JOIN departments USING (department_id)
order by employee_id;


-- Joins with ON
/*The same as equejoin in the normal syntax*/ 
select
employees.employee_id,
employees.first_name,
departments.department_id, -- cannot prefix table name in the match column
departments.department_name
from employees
JOIN departments ON (employees.department_id = departments.department_id)
order by employee_id;

-- ON with nonequjoin
select
emp.employee_id,
emp.first_name,
emp.salary,
grades.grade_level
from employees emp
JOIN job_grades grades on emp.salary between grades.lowest_sal
and grades.highest_sal;


-- On with self join
select
worker.employee_id,
worker.first_name,
worker.manager_id,
manager.first_name
from 
employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

-- Creating three-way JOINS
-- n-1 joins
select
employee_id, city, department_name
from employee emp
join departments d
on (d.department_id = e.department_id)
join locations l
on (d.location_id = l.location_id)

-- Left Outer JOin
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees
left outer join departments
on (employees.department_id = departments.department_id)
 -- my main table is employee, so this will return all the unsigned dept names
order by employee_id;

--Right Outer Join
select
employees.employee_id,
employees.first_name,
employees.last_name,
departments.department_id,
departments.department_name
from employees
right outer join departments
on (employees.department_id = departments.department_id)
 -- my main table is employee, so this will return all the unsigned dept names
order by employee_id;


--Full Outer Join
/*Has no corresponds to the old syntax*/
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
order by employee_id;










































































