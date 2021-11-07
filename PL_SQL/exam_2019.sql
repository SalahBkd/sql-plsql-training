--q1
create sequence numLig;

--q2
create table TabEtatMvt (
	numLig number(7) primary key,
	numProd	stock.idProd%type,
	DtCalcul	date,
	QtStock	sortie.qtprod%type,
	TotalEntree	number,
	TotalSort	number,
	etat varchar(3) check(etat in ('oui', 'non')
);

--q3

create or replace EtatMvt()
as
	cursor mvms is 
		select idProd, qstockProd, sum(qtprod) as totalEntree, sum(qtprod) as totalSortie
		from stock, entree, sortie
		where stock.idprod = entree.idprod
		and stock.idprod = sortie.idprod
		group by stock.idProd, stock.qstockProd;
	
	v_etatCoh TabEtatMvt.etat%type := 'NON';

begin
	for mvm in mvms loop
	
		if(mvms.qstockProd = totalEntree - totalSortie) then
			v_etatCoh := 'OUI';
		end if;
		
		insert into TabEtatMvt values(numLig.nextval, mvm.idProd, sysdate, mvm.qstockProd, mvm.totalEntree, mvm.totalSortie, v_etatCoh);
		
	end loop;
	
end EtatMvt;

--q4
--after insert on entree update qtstockprod with qtprod
create or replace trigger maj_qte
after insert of qtprod on entree
begin
	update stock set qtstockprod = qtstockprod + :new.qtprod where idProd = :new.idprod;
end;

insert into entree(qtprod) values(1000);

--q5
--reg1: qtprod of sortie < qtstockprod of stock
--reg2: prixventeprod of sortie > prixachatprod of entree
--update qtstockprod of stock after insert on sortie 

create or replace trigger maj_qte_stock
before insert on sortie 
for each row
declare
	v_qtstockprod 	stock.qtstockprod%type;
	v_prixachatentree entree.prixachatprod%type;
begin

	select qtstockprod into v_qtstockprod from stock where idprod = :new.idprod;
	select prixachatprod into v_prixachatentree from entree where idprod = :new.idprod;
	
	if :new.qtprod > v_qtstockprod then
		raise_application_error(-20010, 'insufficiant stock!!!');
	end if;
	
	if :new.prixventeprod < v_prixachatentree then
		raise_application_error(-20020, 'incoherant price!!!');
	end if;
	
	update stock set qtstockprod = qtstockprod - :new.qtprod where idprod = :new.idprod;
	
end;

























