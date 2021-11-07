-- Substitution variables
select first_name, last_name, email, phone_number from employees
where employee_id = &eid;

select first_name, last_name, email, phone_number 
from employees
where job_id = '&jtitle';

SELECT employee_id , last_name, &&prompt_col FROM employees
ORDER by &prompt_col;

DEFINE  eid = 117
SELECT employee_id, first_name, last_name
FROM employees 
WHERE employee_id = &eid;




