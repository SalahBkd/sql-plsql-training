/*Exercice 1*/

/*after insert on identification update solde to 0*/
-- question 1
create or replace trigger trig_init
after insert on s_identification
begin
  insert into s_total(solde) values(0);
end;

--question 2
/*after update on operation update solde with montant*/
create or replace trigger trig_maj
after update on s_operation
begin
  insert into s_total(solde) values(:new.montant);
end;

--question 3
/*procedure sup_compt deletes record in IDENTIFICATION with a parameter(numCompte)
  exceptions: no data found | fk constraint 
*/
create or replace procedure sup_compt(cmpt_num IN s_identification.numCompte%type)
is
  numeroCmpt_exc exception;
  pragma exception_init(numeroCmpt_exc, -100);
  
  cir_exc exception;
  pragma exception_init(cir_exc, -2292);
  
begin
  delete from s_identification where numcompte = cmpt_num;
  exception 
    when numeroCmpt_exc then raise_application_error('MY ERROR NO DATA FOUND', -20010);
    when cir_exc then raise_application_error('MY ERROR CIR', -20020);
end sup_compt;


-- Exercice 2
--question 1
declare
  v_numHotel hotel.numHotel%type := &NUMHOTEL;
  v_cat hotel.categorie%type;
begin
  select numHotel, categorie into v_numHotel, v_cat where numHotel = v_numHotel;
  if(v_cat = 3) then
    update chambre set tarif = tarif * 0.2;
  elsif(v_cat = 4 or v_cat = 5) then
    update chambre set tarif = tarif * 0.35;
  end if;
end;

--question 2
insert into hotel values(1, '4starsHotel', 2, 4);

--question 3
create or replace procedure Affiche_Nb_chambres(numeroHotel IN hotel.numhotel%type)
as
  v_numHotel hotel.numhotel%type;
  nbrChambre_exc exception;
  pragma exception_init(nbrChambre_exc, -100);
begin
  select count(NumHotel) into v_numHotel from chambre where NumHotel = numeroHotel;
  dbms_output.put_line('Nbr de chambres: ' || v_numHotel);
  exception
  when nbrChambre_exc then
   raise_application_error('numero de chambre not found', -20030);
end Affiche_Nb_chambres;

--question 4
create or replace function recettes(numeroHotel IN hotel.numHotel%type,
annee IN reservation.dateDebut%type)
is
  v_NombrePersonnes reservation.NombrePersonnes%type;
  v_tarif chambre.tarif%type;
begin

  select numHotel, dateDebut, NombrePersonnes 
  into v_numHotel, v_dateDebut, v_NombrePersonnes
  from reservation 
  where extract(year from dateDebut) = annee;
  
  select tarif into v_tarif from chambre where numHotel = numeroHotel;
  
  return v_NombrePersonnes * v_tarif;
  
end recettes;





















