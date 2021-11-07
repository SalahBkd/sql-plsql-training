/*What is SET operator*/
-- Set operator combines two or more queries into one result
-- queries containing set operators called compound queries

-- UNION: rows from both queries after eliminating duplicates
-- UNION ALL: rows from both queries including all duplications
-- INTERSECT: rows that are commons to both queries
-- MINUS: rows in the first query that are not present in the second query

-- UNION
/* GUIDLINES
  1 - the number of columns should be match
  2 - the columns data type should be match
  3 - eleminates duplicates
  4 - the query order is ASC for all columns
*/
-- Should return 3 job roles, SR MAN, SR REP, SR REP, but it returns only SR MAN, SR REP
select employee_id, job_id 
from employees
union
select employee_id, job_id 
from job_history;

-- UNION ALL
/* GUIDLINES
  1 - the number of columns should be match
  2 - the columns data type should be match
  3 - doesn't eleminates duplicates
  4 - the query order is not ASC for all columns by default
*/
select employee_id, job_id 
from employees
union all
select employee_id, job_id 
from job_history;

-- INTERSECT
-- common things btw query 1 and 2
select employee_id, job_id 
from employees
intersect
select employee_id, job_id 
from job_history;

-- MINUX
-- things that exists in query 1 and not in query 2
select employee_id
from employees
minus
select employee_id
from job_history;




