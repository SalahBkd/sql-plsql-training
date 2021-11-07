/*
  Procedures: used to perform some task
  Functions: used to fetch or return some desired result
  
  Both are created using DDL statment: CREATE FUNCTION/PROCEDURE
  
  Procedure syntax:
    CREATE [OR REPLACE] PROCEDURE procedure_name 
    [(parameter_name [IN | OUT | IN OUT] type [, ...])] 
    {IS | AS} 
      -- program declarations
    BEGIN 
      < procedure_body > 
    END procedure_name; 
    
  Function syntax:
    CREATE [OR REPLACE] FUNCTION function_name 
    [(parameter_name [IN | OUT | IN OUT] type [, ...])] 
    RETURN return_datatype 
    {IS | AS} 
    -- program declarations
    BEGIN 
       < function_body > 
    END [function_name];
*/

-- procedure that deletes an employe, if he manages commandes don't delete him
create or replace procedure sup_emp(emp_num IN e_employe.no%type)
is
  excep_emp_comd exception;
  pragma exception_init(excep_emp_comd, -2292);
begin
  delete from e_employe where no = emp_num;
  
  exception
  when excep_emp_comd then raise_application_error(-20010, 'ERR CIR');
end sup_emp;
/

--procedure test
declare
  exc_emp_com exception;
  pragma exception_init(exc_emp_com, -20010);
begin
  sup_emp(4);
  exception
  when exc_emp_com then dbms_output.put_line('errer: violation de contraint lemploye gere des commandes');
end;
/

--function: calculates ratio of client commandes
create or replace function calcul_ratio_cmds(cln IN e_client.no%type)
return e_commande.total%type
is
  totalCmdDesClient e_commande.total%type;
  totalDesCmds e_commande.total%type;

begin
  select sum(total) into totalCmdDesClient from e_commande where client_no = cln;
  select sum(total) into totalDesCmds from e_commande;
  
  if totalCmdDesClient is null then
    return 0;
  else 
     return totaldescmds / totalcmddesclient; 
  end if;
end calcul_ratio_cmds;
/

-- function test
begin
  dbms_output.put_line('ratio is: ' || calcul_ratio_cmds(&numclient));
end;
/

