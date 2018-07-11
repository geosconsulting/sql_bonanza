DROP TABLE md_catalogs PURGE;
DROP TABLE md_columns PURGE;
DROP TABLE md_connections PURGE;

drop table "FABIO"."MD_CONSTRAINTS" cascade constraints PURGE;
drop table "FABIO"."MD_GROUP_MEMBERS" cascade constraints PURGE;
drop table "FABIO"."MD_GROUP_PRIVILEGES" cascade constraints PURGE;

drop table "FABIO"."MD_GROUPS" cascade constraints PURGE;


BEGIN
  FOR c IN ( SELECT table_name FROM user_tables WHERE table_name LIKE 'MD_%' )
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name;
  END LOOP;
END;

BEGIN
  FOR c IN ( SELECT view_name FROM user_views WHERE view_name LIKE 'MD_%' )
  LOOP
    EXECUTE IMMEDIATE 'DROP VIEW ' || c.view_name;
  END LOOP;
END;

drop table "FABIO"."MD_SCHEMAS" cascade constraints PURGE;
drop table "FABIO"."MD_SEQUENCES" cascade constraints PURGE;
drop table "FABIO"."MD_STORED_PROGRAMS" cascade constraints PURGE;

drop table "FABIO"."MD_SYNONYMS" cascade constraints PURGE;
drop table "FABIO"."MD_TABLES" cascade constraints PURGE;
drop table "FABIO"."MD_TRIGGERS" cascade constraints PURGE;

drop table "FABIO"."MD_USER_DEFINED_DATA_TYPES" cascade constraints PURGE;
drop table "FABIO"."MD_USERS" cascade constraints PURGE;
drop table "FABIO"."MD_VIEWS" cascade constraints PURGE;
drop table "FABIO"."MIGR_GENERATION_ORDER" cascade constraints PURGE;
drop table "FABIO"."MIGRLOG" cascade constraints PURGE;

drop table "FABIO"."MIGR_DATATYPE_TRANSFORM_MAP" cascade constraints PURGE;
drop table "FABIO"."MIGR_DATATYPE_TRANSFORM_RULE" cascade constraints PURGE;



