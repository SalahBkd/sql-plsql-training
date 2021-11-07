/*Notes  TRIGGERS :
  - triggers are stored programs, which are automatically invoked when a specified 
    event occurs
    
  - Triggers are not explicitly invoked
  
  - Triggers are defined on the items: table, view, schema ot the database
  
  - The timing when the trigger fires: BEFORE or AFTER the triggering event
  
  - Types of triggers:
    DML triggers:
      INSERT, UPDATE, DELETE
      subtypes:
        statemen-level trigger
        row-level trigger: using (for each row) & WHEN (condition)
        instead of triggers (for views)
    System triggers:
      DDL: CREATE, ALTER, DROP
      system events: STARTUP, SHUTDOWN, SERVERERROR
      
  - Triggers use cases:
    . auditing
    . security
    . prevent invalid transactions
    . restrict DML operations on tables to regular business hours
    . referential integrity
  
  - all database activity is done within a single transaction
  - Never put a transaction statement inside triggers (ROLLBACK, COMMIT, SAVEPOINT)
  - N.B there are application level triggers (consider Oracle Forms)
  - oracle is limited 32 levels of triggers
  - if your trigger is going to call a stored procedure, don't include a transaction 
    statment in the stored procedure
    
  - qualifying events with the implementations
    UPDATING
    INSERTING
    DELETING
    UPDATING('SALAIRE')
  - using raise_applicatio_error
    when we raise an exception
      if it is handled, it goes to the handling block
      if not it goes back the savepoint where the plsql begins 
      

*/

/*Demonstrations*/
-- version 1: update employe salaire & trace it in TRAUGSAL table
create or replace trigger sal_trace
after update on e_employe
for each row
begin
  insert into traugsal(no, nemp, oldsal, newsal, oper, dtoper) 
  values(seqTrAugSal.nextval, :old.no, :old.salaire, :new.salaire, USER, sysdate);
end;
--update e_employe set salaire = 10 where no = 1;

-- version 2: checking if we are updating only the salaire column but we get into the trigger body every time an update
-- has occured
create or replace trigger sal_trace
after update on e_employe
for each row
begin
  if updating('SALAIRE') then
    insert into traugsal(no, nemp, oldsal, newsal, oper, dtoper) 
    values(seqTrAugSal.nextval, :old.no, :old.salaire, :new.salaire, USER, sysdate);
  end if;
end;

-- version 3 (most optimized solution): checking if we are updating salaire column before we get into the body 
--of the trigger
create or replace trigger sal_trace
after update of salaire on e_employe
for each row
begin
  insert into traugsal(no, nemp, oldsal, newsal, oper, dtoper) 
  values(seqTrAugSal.nextval, :old.no, :old.salaire, :new.salaire, USER, sysdate);
end;

--NEW vs :NEW
--Don't put :NEW inside when()
create or replace trigger ins_dt_entree
before insert on e_employe
for each row when(NEW.dt_entree is null)
begin
  :NEW.dt_entree := sysdate;
end;
/*insert into e_employe(no, nom, prenom) values(100, 'test', 'test');
select dt_entree from e_employe where no = 100;*/

-- archive all deleted employees
create or replace trigger arch_del_emps
after delete on e_employe
for each row
begin
  if DELETING then
    insert into trace_emps values(emps_trace.nextval, sysdate, user, :old.no, :old.nom, :old.prenom, :old.dt_entree, 
    :old.titre, :old.service_no, :old.commentaire, :old.salaire, :old.PCT_COMMISSION);
  end if;
end;
--delete from e_employe where no = 100;














