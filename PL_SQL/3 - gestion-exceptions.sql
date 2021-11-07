/*what is an exception ?*/
/*
  c'est une erreur pl/sql qui est généré a l'execution du program
  
   -can be raised:
    implicitly: by oracle
    explicitl: by the program
    
   -can be handeled:
    with a handler
    propagating it to the calling environement
*/

/*Execeptions Types
  - Predefined
  - Non-predefined
  - User defined error
*/



/*Exercice 1:*:
/*Gestion des exceptions utilisant le nom d'exception: PREDEFINED: NO_DATA_FOUND*/
set serveroutput on;
DECLARE
  p_nom e_client.nom% TYPE;
  p_ville e_client.ville% TYPE;
BEGIN
  select nom, ville into p_nom, p_ville from e_client where no=103;
  EXCEPTION
    when NO_DATA_FOUND then dbms_output.put_line('Err Personnalisée: aucune donnée trouvée');
  dbms_output.put_line('err capturee: le program a continuer');
end;

/*Gestion des exceptions utilisant le code sql d'exception: PREDEFINED-SQLCODE: -01403*/
set serveroutput on; 
DECLARE
  p_nom e_client.nom% TYPE;
  p_ville e_client.ville% TYPE;
BEGIN
  select nom, ville into p_nom, p_ville from e_client where no=103;
  EXCEPTION
    when others then 
      if sqlcode=100 then dbms_output.put_line('Err Personnalisée: aucune donnée trouvée');
      end if;
  dbms_output.put_line('err capturee: le program a continuer');
end;

/*Gestion des exceptions utilisant le code pragma exception_init: NON-PREDEFINED: -01403*/
set serveroutput on; 
DECLARE
  p_nom e_client.nom% TYPE;
  p_ville e_client.ville% TYPE;
  exc_cl_inex exception;
  pragma exception_init(exc_cl_inex, 100);
BEGIN
  select nom, ville into p_nom, p_ville from e_client where no=103;
  EXCEPTION
    when exc_cl_inex then dbms_output.put_line('Err Personnalisée: aucune donnée trouvée !');
  dbms_output.put_line('err capturee: le program a continuer...');
	END;

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

/*Exercice 09/12/2019*/
set serveroutput on;
declare
  v_id e_client.no% TYPE := &v_id;
  v_name e_client.nom% TYPE;
  v_allCommandes e_commande.total%type;
  v_clientCommandes e_commande.total%type;
  v_rapport number(11,2);
  v_date date;
  client_ex exception;
  pragma exception_init(client_ex, 100);
  
begin
  --get the name of the client
  select nom into v_name from e_client where no = v_id;
  --total de commande d'un seul client
  select sum(total) into v_clientCommandes from e_commande where client_no = v_id;
  --total de commande des clients
  select sum(total) into v_allCommandes from e_commande;
  --calculer le rapport
  v_rapport := v_allCommandes / v_clientCommandes;
  --la date de saisir
  v_date := sysdate;
  --archiver la résultat dans la table e_resultat
  insert into resultats(id, id_client, nom_client, rapport, date_saisir) 
  values(res_seq.nextval, v_id, v_name, v_rapport, v_date);
  
  Exception
  when client_ex then dbms_output.put_line('le client avec le numero ' || v_id || ' nexiste pas');
end;

--Exercice 1: CHECK EXCEPTION DIRECTORY / FILE TP
set serveroutput on;
declare
  v_num_prod e_produit.no%type := &v_num_prod;
  v_nom_prod e_produit.nom%type;
  v_num_stock e_stock.no%type := &num_stock;
  v_qte_stock e_stock.qte_stock%type;
  v_stock_securite e_stock.stock_securite%type;
  v_produit_no e_stock.produit_no%type;
  
  exc_prod_inex exception;
  pragma exception_init(exc_prod_inex, 100);
  
  exc_stock_inex exception;
  pragma exception_init(exc_stock_inex, 100);  
  
  exc_zero exception;
  exc_infer exception;
  exc_pasutilise exception;

begin
  ------------------------------ PRODUIT ------------------------
  begin
    select no, nom into v_num_prod, v_nom_prod from e_produit where no = v_num_prod;
    dbms_output.put_line(v_num_prod || v_nom_prod);
    
    exception
    when exc_prod_inex then dbms_output.put_line('le produit nexiste pas');
  end;
  
  ------------------------------ STOCK ------------------------
  begin
    select no, qte_stock, stock_securite, produit_no into v_num_stock, v_qte_stock, v_stock_securite,
    v_produit_no
    from e_stock where no = v_num_stock;  
    
    if v_qte_stock = 0 then
      raise exc_zero;
    elsif v_qte_stock < v_stock_securite then
      raise exc_infer;
    elsif v_produit_no = null then
      raise exc_pasutilise;
    end if;
    
    exception
    when exc_stock_inex then dbms_output.put_line('le stock nexiste pas');
    when exc_zero then dbms_output.put_line('le stock est 0');
    when exc_infer then dbms_output.put_line('le stock est inferieur a seuil de securite');
    when exc_pasutilise then dbms_output.put_line('le stock nest pas utilise');
  end;
  
end;





