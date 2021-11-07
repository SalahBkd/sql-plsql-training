/*
Exercice 2:
  on considère un employé donné par son numéro
  et un numéro de commande, on veut vérifier si cet employé gère cette commande
  si oui en affiche le nombre total des commandes qui gére
  
  on doit gérer les exceptions suivantes:
  --l'employé n'existe pas 
  --la commande n'existe pas
  --si l'employé n'exsite pas vous devez afficher le message suivant: ERR EXC_EMP_INEXISTANT
    l'employé X n'exsiste pas
  --si la commande n'existe pas, vous devez afficher le message suivant ERR EXC_COM_INEXISTANTE
    la commande X n'existe pas
  -- si les deux n'existe pas, vous devez afficher les 2 messages ci dessous
*/
set serveroutput on;
DECLARE
  e_no e_employe.no% TYPE:=&e_no;
  c_no e_commande.no% TYPE:=&c_no;
  e_nom e_employe.nom%type;
  c_total e_commande.total%type;
  c_employe_no e_commande.employe_no%type;
  
  exc_emp_inex exception;
  pragma exception_init(exc_emp_inex, 100);
  
  exc_com_inex exception;
  pragma exception_init(exc_com_inex, 100);
BEGIN
  begin
    select nom into e_nom from e_employe where no=e_no;
    exception
      when exc_emp_inex then 
      dbms_output.put_line('lemploye avec le numero ' || e_no || ' nexiste pas');
  end;
  begin
    select total, employe_no into c_total, c_employe_no from e_commande where no=c_no;
    
    exception
      when exc_com_inex then 
      dbms_output.put_line('la commande avec le numero ' || c_no || ' nexiste pas');   
  end;
  
  if c_employe_no = e_no then
    dbms_output.put_line('lemploye avec id: ' || e_no || 'de la commande id: '|| c_no ||'gere: ' || c_total);
  end if;
END;


  
  