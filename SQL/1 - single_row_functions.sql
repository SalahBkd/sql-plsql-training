-- UPPER / LOWER
select * from jobs;
desc jobs;
select INITCAP(job_id),UPPER(job_title), lower(job_title) from jobs;

desc dual;

-- USER / SYSDATE / LENGTH built in functions
select user from dual;
select sysdate from dual;
select LENGTH('Hello World') AS length from dual;
-- look up the documentations for more details

-- SUBSTR
select job_title, substr(job_title, 1, 10) from jobs;

-- INSTR
select job_title, INSTR(job_title, 'Sales') AS Sales_Occur from jobs 
ORDER BY Sales_occur DESC;

-- CONCATINATION
select concat(first_name, last_name) AS FullName from employees;

-- CONCAT CHARACTERS || 
select first_name || ', ' || last_name from employees;

-- ROUND / TRUNC
select 314.1414,
ROUND(314.1414),
ROUND(314.1414, 2), 
TRUNC(314.1414)
from dual;

-- Type Casting
select TO_CHAR(1456.421, '$9,999.00') from dual;

select TO_DATE('2019/10/14', 'yyyy/mm/dd') from dual;

-- NVL
select employee_id, commission_pct, NVL(NULL, 0.2) 
from employees where commission_pct is null;

-- MONTHS_BETWEEN
select months_between('15-MAR-90' , '22-MAY-70') from dual;









