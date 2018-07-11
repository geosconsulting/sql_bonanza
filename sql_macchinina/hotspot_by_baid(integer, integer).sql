-- Function: effis.hotspot_by_baid(integer, integer)

-- DROP FUNCTION effis.hotspot_by_baid(integer, integer);

CREATE OR REPLACE FUNCTION effis.hotspot_by_baid(
    integer,
    integer)
  RETURNS SETOF modis_viirs.hotspots_type AS
$BODY$
declare 
  -- parameters
  anno ALIAS for $1;
  id_area_bruciata ALIAS FOR $2;
  tipo modis_viirs.modis;
  in_date date;
  out_date date;
  riga record;  
begin
   in_date := (anno::text || '-1-1')::date;
   out_date := (anno::text || '-12-31')::date;
   for riga in 
     SELECT hs.* 
     FROM modis_viirs.modis hs, effis.archived_burnt_area ba
     WHERE ba.ba_id = id_area_bruciata 
     AND hs.acq_date BETWEEN in_date AND out_date
     AND ST_Within(hs.geom, ba.geom)   
    loop
     return next riga;
   end loop;   
   return;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.hotspot_by_baid(integer, integer)
  OWNER TO postgres;
