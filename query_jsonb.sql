select jsonb_each_text(ba_problem) from egeos.ba_problems;

select ba_id from egeos.ba_problems WHERE ba_id=400;

select ba_problem->>'date_last' as "Last Date",ba_problem->>'date_previous' as "Initial Date" from egeos.ba_problems WHERE ba_id=400;
select ba_problem->>'area_last' as "Last Area" from egeos.ba_problems WHERE ba_id=400;

SELECT * FROM egeos.ba_problems WHERE ba_problem ?& array['date_last', 'area_last']; --all
SELECT * FROM egeos.ba_problems WHERE ba_problem ?| array['date_last', 'area_last']; --only

SELECT * FROM egeos.ba_problems WHERE ba_problem ?| array['date_last'] and ba_id=400; --only

SELECT * FROM egeos.ba_problems WHERE ba_problem = '{"area_last":4}';

--In this case, containment means “is a subset of”.
SELECT * FROM egeos.ba_problems WHERE ba_problem @> '{"area_last":4}';
SELECT * FROM egeos.ba_problems WHERE ba_problem <@ '{"area_last":4}';

SELECT * FROM egeos.ba_problems WHERE ba_problem ? 'area_last';

SELECT * FROM egeos.ba_problems WHERE ba_problem ->> 'area_last' > '10'::varchar;