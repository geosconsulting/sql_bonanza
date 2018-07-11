-- Materialized View: effis.modis_burnt_areas

DROP MATERIALIZED VIEW effis.modis_burnt_areas;

CREATE MATERIALIZED VIEW effis.modis_burnt_areas AS (
                    select 
                      row_number() OVER(ORDER BY archived_and_current.ba_id DESC) AS global_id,                      
                      archived_and_current.ba_id as ba_id,
		      archived_and_current.area_ha as area_ha,
		      archived_and_current.firedate as firedate,
		      archived_and_current.lastupdate as lastupdate,
		      archived_and_current.geom as geom
                    from (
                    SELECT current_burnt_area.ba_id,
			   current_burnt_area.area_ha,
			   current_burnt_area.firedate,
			   current_burnt_area.lastupdate,
			   current_burnt_area.geom
		    FROM effis.current_burnt_area
		    UNION
		    SELECT archived_burnt_area.ba_id,
		       archived_burnt_area.area_ha,
		       archived_burnt_area.firedate,
		       archived_burnt_area.lastupdate,
		       archived_burnt_area.geom
		    FROM effis.archived_burnt_area) archived_and_current);

DROP VIEW effis.modis_burnt_areas;

CREATE VIEW effis.modis_burnt_areas AS (
                    select 
                      extract(year from archived_and_current.firedate::date) || '_' || ba_id AS global_id,                      
                      archived_and_current.ba_id as ba_id,
		      archived_and_current.area_ha as area_ha,
		      archived_and_current.firedate as firedate,
		      archived_and_current.lastupdate as lastupdate,
		      archived_and_current.geom as geom
                    from (
			 SELECT ba_id,
			        area_ha,
				firedate,
				lastupdate,
				geom
			 FROM effis.current_burnt_area
			 UNION
			 SELECT ba_id,
			        area_ha,
			        firedate,
			        lastupdate,
			        geom
			 FROM effis.archived_burnt_area
			 ) as archived_and_current);

ALTER TABLE effis.all_burnt_areas
  OWNER TO postgres;

grant select on all tables in schema effis to e1gwisro;
GRANT SELECT ON effis.modis_burnt_areas TO e1gwisro;

create table effis.burnt_areas as select * from effis.modis_burnt_areas;

select ba_id from effis.archived_burnt_area where firedate::date between '2017-01-01'::date and '2017-12-31'::date;

SELECT ba_id,
       area_ha,
       firedate,
       case 
            when extract(year from firedate::date) is null then 9999
            else extract(year from firedate::date)
       end,
       lastupdate,
       geom
FROM effis.archived_burnt_area;

DROP VIEW if exists effis.modis_burnt_areas cascade ;

CREATE VIEW effis.modis_burnt_areas AS (
                    select 
                      case 
			when extract(year from firedate::date) is null then '9999_' || archived_and_current.ba_id
			else extract(year from firedate::date) || '_' || archived_and_current.ba_id
		      end as global_id,                      
                      archived_and_current.ba_id as ba_id,
		      archived_and_current.area_ha as area_ha,
		      archived_and_current.firedate as firedate,
		      archived_and_current.lastupdate as lastupdate,
		      archived_and_current.geom as geom
                    from (
			 SELECT ba_id,
			        area_ha,
				firedate,
				lastupdate,
				geom
			 FROM effis.current_burnt_area
			 UNION
			 SELECT ba_id,
			        area_ha,
			        firedate,
			        lastupdate,
			        geom
			 FROM effis.archived_burnt_area
			 ) as archived_and_current);

drop table if exists effis.burnt_areas cascade;

create table effis.burnt_areas as select * from effis.modis_burnt_areas;

alter table effis.burnt_areas add primary key(global_id);

CREATE INDEX sidx_burnt_areas
  ON effis.burnt_areas
  USING gist
  (geom);

CREATE INDEX idx_burnt_areas_firedate
  ON effis.burnt_areas
  USING btree
  (firedate);

CREATE INDEX idx_burnt_areas_lastupdate
  ON effis.burnt_areas
  USING btree
  (lastupdate);

select global_id, area_ha, (st_area(geom::geography)*0.0001)::int from effis.burnt_areas;