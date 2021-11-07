 --a package is a schema object that contains definitions for a group of related functionalities

--SPECIFICATION
create or replace package gere_emp as
  procedure maj_commiss(emp_num e_employe.no%type, newPct e_employe.pct_commission%type);
  function calcul_ratio(emp_num e_employe.no%type) return e_commande.total%type;
end gere_emp;

--IMPLEMENTATION
create or replace package body gere_emp as

--PROCEDURE
  procedure maj_commiss(emp_num IN e_employe.no%type, newPct IN e_employe.pct_commission%type)
    as
    begin
      update e_employe set pct_commission = newPct where no = emp_num;
    end maj_commiss;
 --FUNCTION
  function calcul_ratio(emp_num IN e_employe.no%type) return e_commande.total%type
    is
      totalEmployes e_commande.total%type;
      totalDesCmds e_commande.total%type;
    begin
    select sum(total) into totalEmployes from e_commande where employe_no = emp_num;
    select sum(total) into totalDesCmds from e_commande;
    
    if totalEmployes is null then
      return 0;
    else 
       return totalEmployes / totaldescmds; 
    end if;
  end calcul_ratio;
  
end gere_emp; --end of package

begin
  gere_emp.maj_commiss(6,5);
  dbms_output.put_line(gere_emp.calcul_ratio(2));
end;