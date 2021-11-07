/*Notes*/
-- memory area, known as the context area used for processing an SQL statement.
-- A cursor is a pointer to this context area.
-- A cursor holds the rows (one or more) returned by a SQL statement.

 --types of cursors
	--Implicit: constructed and managed by PLSQL , PLSQL automatically opens an implicit cursor when A DML or     SELECT statement is run from within a PL/SQL block.
	--Explicit: constructed and managed by the user code.


/*Demonstrations*/
--Exercice: find employees in the years 1995, 1996, 1997 depends on the year ajouter une augmentation et archiver les augmentations réalisé.
/*Version 1: FOR LOOP*/
--select no, nom, salaire, extract(year from dt_entree) from e_employe where extract(year from dt_entree) in (1995,1996,1997);
set serverouput on;
declare

  cursor empList is select no, salaire, extract(year from dt_entree)annee from e_employe;
  
  montantAug e_employe.salaire%TYPE;
  factAug number(4,2);
begin
  for emp in empList loop
    if(emp.annee = 1995) then
        factAug := 1.50;
      elsif (emp.annee = 1996) then
        factAug := emp.salaire*0.25;
      else
        factAug := emp.salaire*0.1;
    end if;
     montantAug := emp.salaire* factAug;
     update e_employe set salaire = montantAug where no = emp.no;
     insert into e_aug(no, aug, dt_aug, emp_no) values (seqaug.nextval, montantAug-emp.salaire, sysdate, emp.no);
  end loop;
  commit;
end;

/*Version 2: WHILE*/
set serverouput on;
declare
  cursor empList is select no, salaire, extract(year from dt_entree)annee from e_employe;
  emp  empList%rowtype;
  montantAug e_employe.salaire%TYPE;
  factAug number(4,2);
begin
  open empList;
  fetch empList into emp;
  while (empList%found) loop
    if(emp.annee = 1995) then
        factAug := 1.50;
      elsif (emp.annee = 1996) then
        factAug := emp.salaire*0.25;
      else
        factAug := emp.salaire*0.1;
    end if;
     montantAug := cl.salaire* factAug;
     update e_employe set salaire = montantAug where no = emp.no;
     insert into e_aug(no, aug, dt_aug, emp_no) values (seqaug.nextval, montantAug-emp.salaire, sysdate, emp.no);
     fetch empList into emp;
  end loop;
  close empList;
  commit;
end;

/*Parametered Cursors*/
-- WITH FOR
--Exercice: total des commandes des clients ont le meme prenom
/*select cl.no, cl.prenom, SUM(c.total)
from e_client cl, e_commande c 
where cl.no = c.client_no
group by cl.no, cl.prenom
order by cl.no; */

set serveroutput on;
declare
  v_name e_client.prenom%type := '&PRENOM_A_SAISIR';
  cursor totalClients(arg_prenom IN e_client.prenom%type) is 
    select cl.no, cl.prenom, SUM(c.total) TotalClient
    from e_client cl, e_commande c 
    where cl.no = c.client_no and cl.prenom = arg_prenom
    group by cl.no, cl.prenom
    order by cl.no;
begin
  for cl in totalClients(v_name) loop
    dbms_output.put_line(cl.no || ' ' ||  cl.prenom || ' ' || cl.TotalClient);
  end loop;
end;













