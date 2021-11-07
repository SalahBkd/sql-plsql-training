/*2.1. Ecrire un trigger qui vérifie lors de la mise à jour du prix de vente 
	d’un produit que le prix de vente ne dépasse pas la marge correspondant à 
	la catégorie du produit, sinon, un message d’erreur doit être retourné 
	et la mise à jour avortée. 

-- version 1:
-- REGLE: le prix de vente d'un produit ne doit jamais être supérieur
-- au prix d'achat du produit plus la marge fixée selon la catégorie
-- exemple:
-- on achete un produit de catégorie 1 au prix 90 DH 
-- (prods.prixachat=90 et catprod.margemax=10%)
-- le prix max de vente est prods.prixachat*(1+catprod.margemax/10)
-- 90*(1+10/10)=90*1.1=99*/

--Exercice: version 1:
create or replace trigger PRIX_TRIG
before update of prixvente on prods
for each row
declare
  prixMaxVente number(5,2);
  margeMax catprod.margemax%type;
begin
  select margemax into margeMax from catprod where numcat = :old.catprod;
  prixMaxVente := :old.prixachat * (1 + margeMax/10);
  
  if :new.prixvente > :old.prixachat or :new.prixvente > prixMaxVente then
    raise_application_error(-20100, 'transaction abortee');
  end if;
  
end;
/

--Exercice: version 2
create or replace trigger PRIX_TRIG
before update of prixvente on prods
for each row
declare
  prixMaxVente number(5,2);
  margeMax catprod.margemax%type;
begin
  select margemax into margeMax from catprod where numcat = :old.catprod;
  prixMaxVente := :old.prixachat * (1 + margeMax/10);
  
  if :new.prixvente > :old.prixachat or :new.prixvente > prixMaxVente then
    raise_application_error(-20100, 'transaction abortee');
  else
    insert into trace_prixvente values(seqtrpv.nextval, sysdate, user, :old.numprod, :old.catprod,
    :old.prixvente, :new.prixvente);
  end if;
  
end;
/

--Exercice: version 3
create or replace trigger PRIX_TRIG
before update of prixvente on prods
for each row
declare
  prixMaxVente number(5,2);
  margeMax catprod.margemax%type;
  prixAchatMax catprod.prixachatmax%type;
begin
  select margemax into margeMax from catprod where numcat = :old.catprod;
  prixMaxVente := :old.prixachat * (1 + margeMax/10);
  
  if :new.prixvente > :old.prixachat or :new.prixvente > prixMaxVente then
    raise_application_error(-20100, 'transaction abortee');
    
  elsif margeMax < 10 then  /*if there is a promotion*/
    select prixachatmax into prixAchatMax from catprod where numcat = :old.catprod;
	
   elsif :new.prixvente < :old.prixachat or :old.prixachat > prixAchatMax then
      raise_application_error(-20200, 'transaction abortee marge maxe sgharr mn 10');
  else
    insert into trace_prixvente values(seqtrpv.nextval, sysdate, user, :old.numprod, :old.catprod,
    :old.prixvente, :new.prixvente);
  end if;
end;
/



/*For testing purpose*/
update prods set prixvente = 90 where numprod = 1;
--create sequence seqtrpv;



