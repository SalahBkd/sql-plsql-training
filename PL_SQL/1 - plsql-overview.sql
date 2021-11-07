SET SERVEROUTPUT ON

-- Simple PS block
DECLARE
nom varchar(100) default 'salah';
age number default 20;
BEGIN
dbms_output.put_line(nom);
dbms_output.put_line(age);
END;