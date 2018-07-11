SELECT * FROM information_schema.role_table_grants WHERE grantee = 'viewer';

CREATE FUNCTION effis.role_has_table_privilege(g NAME, tn NAME, pt NAME) 
RETURNS boolean AS 
 'SELECT EXISTS (SELECT 1 FROM information_schema.role_table_grants WHERE (grantee, table_name, privilege_type) IN (($1, $2, $3)));' 
LANGUAGE sql;

--DROP ROLE editor;
-- CREATE ROLE editor;
--CREATE ROLE editor WITH LOGIN PASSWORD 'editor';
ALTER ROLE editor WITH LOGIN;

GRANT USAGE ON SCHEMA effis TO effis_editor;
GRANT SELECT,UPDATE,DELETE ON ALL TABLES IN SCHEMA effis TO effis_editor;
GRANT USAGE, SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA effis TO effis_editor;

GRANT CONNECT ON DATABASE test TO effis_editor;
GRANT CREATE ON DATABASE test TO editor;

GRANT effis_editor TO editor;
--REVOKE effis_editor FROM nome_utente;

ALTER USER editor WITH PASSWORD 'editor';