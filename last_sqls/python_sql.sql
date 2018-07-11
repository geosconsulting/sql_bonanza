CREATE FUNCTION hello(name text)
   RETURNS text
AS $$
   return 'hello %s !' % name
$$ LANGUAGE plpythonu;

CREATE FUNCTION conta_lettere(nome text)
  RETURNS int AS $$
return len(nome)
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION userinfo(
		INOUT username name,
		OUT user_id oid,
		OUT is_superuser boolean)
AS $$
    class PGUser:  
	def __init__(self,username,user_id,is_superuser):
	    self.username = username
	    self.user_id = user_id
	    self.is_superuser = is_superuser

    u = plpy.execute("""\
	select usename,usesysid,usesuper
	from pg_user
	where usename = '%s'""" % username)[0]    

    user = PGUser(u['usename'], u['usesysid'], u['usesuper'])
    return user
$$ LANGUAGe plpythonu;	   	    


CREATE OR REPLACE FUNCTION userinfo_dict(
	INOUT username name,
	OUT user_id oid,
	OUT is_superuser boolean)
AS $$
    u = plpy.execute("""\
	select usename,usesysid,usesuper
	from pg_user
	where usename = '%s'""" % username)[0]
    return {'username':u['usename'], 'user_id':u['usesysid'], 'is_superuser':u['usesuper']}
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION userinfo_list(
	INOUT username name,
	OUT user_id oid,
	OUT is_superuser boolean)
AS $$
    u = plpy.execute("""\
	select usename,usesysid,usesuper
	from pg_user
	where usename = '%s'""" % username)[0]
    plpy.notice(u)
    return (u['usename'], u['usesysid'],u['usesuper'])
$$ LANGUAGE plpythonu;


CREATE OR REPLACE FUNCTION even_numbers_from_list(up_to int)
   RETURNS SETOF int
AS $$
    return range(0,up_to,2)
$$ LANGUAGE plpythonu;

CREATE FUNCTION even_numbers_from_generator(up_to int)
RETURNS TABLE (even int, odd int)
AS $$
   return ((i,i+1) for i in xrange(0,up_to,2))
$$ LANGUAGE plpythonu;


CREATE FUNCTION even_numbers_with_yield(
	up_to int,
	OUT even int,
	OUT odd int)
RETURNS SETOF RECORD
AS $$
    for i in xrange(0,up_to,2):
        yield i, i+1
$$ LANGUAGE plpythonu;
 

CREATE FUNCTION birthdates(OUT name text, OUT birthdate date)
RETURNS SETOF RECORD
AS $$
return (
{'name': 'bob', 'birthdate': '1980-10-10'},
{'name': 'mary', 'birthdate': '1983-02-17'},
['jill', '2010-01-15'],
)
$$ LANGUAGE plpythonu;

DROP FUNCTION rfr();

DROP FUNCTION rfr(int,text);

CREATE OR REPLACE FUNCTION rfr(	
	OUT id int,
	OUT data text) 
RETURNS SETOF RECORD
AS $$
    res = plpy.execute('select * from fiverows;',2)
    return res
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION rfr_una_colonna(		
	OUT data text) 
RETURNS SETOF TEXT
AS $$
    res = plpy.execute('select data from fiverows;')
    return res
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION notify_on_call()
  RETURNS TRIGGER
  AS $$
  plpy.notice('Sono stato chiamato')
$$ LANGUAGE plpythonu;

CREATE TABLE ttable(id int);

CREATE TRIGGER ttable_notify BEFORE INSERT ON ttable EXECUTE PROCEDURE notify_on_call()

INSERT INTO ttable VALUES(100);

CREATE OR REPLACE FUNCTION explore_trigger()
RETURNS TRIGGER
AS $$
import pprint
nice_data = pprint.pformat(
(
('TD["table_schema"]' , TD["table_schema"] ),
('TD["event"]' , TD["event"] ),
('TD["when"]' , TD["when"] ),
('TD["level"]' , TD["level"] ),
('TD["old"]' , TD["old"] ),
('TD["new"]' , TD["new"] ),
('TD["name"]' , TD["name"] ),
('TD["table_name"]' , TD["table_name"] ),
('TD["relid"]' , TD["relid"] ),
('TD["args"]' , TD["args"] ),
)
)
plpy.notice('explore_trigger:\n' + nice_data)
$$ LANGUAGE plpythonu;

CREATE TABLE test(
id serial PRIMARY KEY,
data text,
ts timestamp DEFAULT clock_timestamp()
);
CREATE TRIGGER test_explore_trigger
AFTER INSERT OR UPDATE OR DELETE ON test
FOR EACH ROW
EXECUTE PROCEDURE explore_trigger('one', 2, null);

INSERT INTO test(id,data) VALUES(1, 'firstrowdata');
INSERT INTO test(id,data) VALUES(2, 'secondrowdata');

UPDATE test
SET id = 11,
    data = 'primaerasecond'
WHERE id = 2;