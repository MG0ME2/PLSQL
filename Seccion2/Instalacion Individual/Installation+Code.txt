sqlplus sys/123@localhost:1521/orclpdb as sysdba;
alter pluggable database open;
alter pluggable database orclpdb save state;
create or replace directory import_dir as 'C:\SAMPLE_SCHEMAS';
exit
impdp system/123@localhost:1521/orclpdb schemas=hr directory=import_dir dumpfile=EXPORTED_SAMPLE_SCHEMAS.dmp logfile=import.log remap_tablespace=EXAMPLE:USERS
impdp system/123@localhost:1521/orclpdb schemas=sh directory=import_dir dumpfile=EXPORTED_SAMPLE_SCHEMAS.dmp logfile=import.log remap_tablespace=EXAMPLE:USERS
impdp system/123@localhost:1521/orclpdb schemas=oe directory=import_dir dumpfile=EXPORTED_SAMPLE_SCHEMAS.dmp logfile=import.log remap_tablespace=EXAMPLE:USERS
impdp system/123@localhost:1521/orclpdb schemas=pm directory=import_dir dumpfile=EXPORTED_SAMPLE_SCHEMAS.dmp logfile=import.log remap_tablespace=EXAMPLE:USERS
impdp system/123@localhost:1521/orclpdb schemas=ix directory=import_dir dumpfile=EXPORTED_SAMPLE_SCHEMAS.dmp logfile=import.log remap_tablespace=EXAMPLE:USERS
sqlplus sys/123@localhost:1521/orclpdb as sysdba;
alter user hr identified by hr account unlock;
alter user sh identified by 123 account unlock;
alter user oe identified by 123 account unlock;
alter user pm identified by 123 account unlock;
alter user ix identified by 123 account unlock;
/
