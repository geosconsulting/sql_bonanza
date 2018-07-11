ALTER TABLE effis.burnt_areas ALTER COLUMN global_id TYPE varchar;


ALTER TABLE effis.burnt_areas ALTER COLUMN firedate TYPE DATE 
using to_date(firedate, 'YYYY-MM-DD');


ALTER TABLE effis.burnt_areas ALTER COLUMN lastupdate TYPE DATE 
using to_date(lastupdate, 'YYYY-MM-DD');

grant usage on schema effis to e1gwis;
grant usage on schema effis to e1gwisro;

grant all on all tables in schema effis to e1gwis;
grant all on all sequences in schema effis to e1gwis;
grant all on all functions in schema effis to e1gwis;

grant SELECT on all tables in schema effis to e1gwisro;
grant SELECT on all sequences in schema effis to e1gwisro;
grant execute on all functions in schema effis to e1gwisro;

