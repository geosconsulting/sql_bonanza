--da doppi
select * from effis.archived_burnt_area ou
where (select count(*) from effis.archived_burnt_area inr
where inr.id_source = ou.id_source) > 1;

--non da doppi
select * from effis.archived_burnt_area ou
where (select count(*) from effis.archived_burnt_area inr
where inr.year_id = ou.year_id) > 1;

--non da doppi
select * from effis.archived_burnt_area ou
where (select count(*) from effis.archived_burnt_area inr
where inr.ba_id = ou.ba_id) > 1;


--non da doppi
select * from effis.burnt_areas ou
where (select count(*) from effis.burnt_areas inr
where inr.ba_id = ou.ba_id) > 1;