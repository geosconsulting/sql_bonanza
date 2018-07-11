SELECT hs.*
FROM modis_viirs.modis hs, effis.archived_burnt_area ba
WHERE ba.ba_id=16921 
AND hs.acq_date BETWEEN '2002-1-1'::date AND '2002-12-31'::date
AND ST_Within(hs.geom, ba.geom);

SELECT hs.*
FROM modis_viirs.modis hs, effis.archived_burnt_area ba
WHERE ba.ba_id=19139 
AND hs.acq_date BETWEEN '2017-1-1'::date AND '2017-12-31'::date
AND ST_Within(hs.geom, ba.geom);

SELECT count(ba_id) from effis.archived_burnt_area ba WHERE firedate is NULL;

SELECT ba_id from effis.archived_burnt_area ba WHERE firedate is NULL;

DROP TYPE modis_viirs.return_hotspots CASCADE;

CREATE TYPE modis_viirs.hotspots_type as 
(
  modis_id INTEGER,
  latitude numeric,
  longitude numeric,
  brightness numeric,
  scan numeric,
  track numeric,
  acq_date date,
  acq_time time without time zone,
  satellite character varying(5),
  instrument character varying(6),
  confidence integer,
  version numeric,
  bright_t31 numeric,
  frp numeric,
  geom geometry(Point,4326));

DROP function effis.hotspot_by_baid(varchar,integer);

create or replace function modis_viirs.hotspot_by_baid(yr varchar,id integer) 
RETURNS setof RECORD as 
$$
declare 
  -- parameters
  r record;
  query_hs varchar;
begin
   query_hs := 'SELECT hs.* FROM modis_viirs.modis hs, effis.archived_burnt_area ba
   WHERE ba.ba_id=' || id || ' AND hs.acq_date BETWEEN ''' || yr || '-1-1''::date AND ''' || yr || '-12-31''::date
   AND ST_Within(hs.geom, ba.geom)' INTO r;   
   for r in EXECUTE query loop
     return next r;
   end loop;   
   return;
end
$$ language 'plpgsql';

DROP function effis.hotspot_by_baid(integer,integer);

create or replace function modis_viirs.hotspot_by_baid(integer) 
RETURNS setof modis_viirs.hotspots_type as $$
declare 
  id_area_bruciata ALIAS FOR $1;
  tipo modis_viirs.hotspots_type;
  in_date date;
  out_date date;
  riga record;  
begin
   in_date := '2001-10-1'::date;
   out_date := '2017-12-31'::date;
   for riga in 
     SELECT hs.* 
     FROM effis.modis_hotspots hs, effis.archived_burnt_area ba
     WHERE ba.ba_id = id_area_bruciata 
     AND hs.acq_date BETWEEN in_date AND out_date
     AND ST_Within(hs.geom, ba.geom)   
    loop
     return next riga;
   end loop;   
   return;
end;
$$ language 'plpgsql';

create or replace function effis.hotspot_by_baid(integer,integer) 
RETURNS setof modis_viirs.hotspots_type as $$
declare 
  -- parameters
  anno ALIAS for $1;
  id_area_bruciata ALIAS FOR $2;
  tipo modis_viirs.hotspots_type;
  in_date date;
  out_date date;
  riga record;  
begin
   in_date := (anno::text || '-1-1')::date;
   out_date := (anno::text || '-12-31')::date;
   for riga in 
     SELECT hs.* 
     FROM effis.modis_hotspots hs, effis.archived_burnt_area ba
     WHERE ba.ba_id = id_area_bruciata 
     AND hs.acq_date BETWEEN in_date AND out_date
     AND ST_Within(hs.geom, ba.geom)   
    loop
     return next riga;
   end loop;   
   return;
end;
$$ language 'plpgsql';


DO $$
DECLARE
   yr integer;
   id  integer;
   query varchar;
begin

   yr := 2012;
   id := 16921;

   query := 'SELECT hs.* FROM modis_viirs.modis hs, effis.archived_burnt_area ba
   WHERE ba.ba_id=' || id || ' AND hs.acq_date BETWEEN ''' || yr || '-1-1''::date AND ''' || yr || '-12-31''::date
   AND ST_Within(hs.geom, ba.geom)';

   raise NOTICE '%', query;   
end;
$$
language 'plpgsql';


  