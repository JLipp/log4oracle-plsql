drop user log4 cascade;
CREATE USER log4 IDENTIFIED BY log4;
GRANT CONNECT, RESOURCE, aq_administrator_role TO log4;
GRANT EXECUTE ON dbms_aq TO log4;
GRANT EXECUTE ON dbms_aqadm TO log4;

grant create type to log4;
grant create procedure to log4;
grant create table to log4;
