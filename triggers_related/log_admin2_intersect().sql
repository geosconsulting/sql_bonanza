-- Function: mm.log_admin2_intersect()

-- DROP FUNCTION mm.log_admin2_intersect();

CREATE OR REPLACE FUNCTION mm.log_admin2_intersect()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO mm.ca_adm2(fire_id,adm2_id)
	  SELECT ca.id,ad.id
	  FROM effis.current_burntareaspoly ca
	  LEFT JOIN effis_ext_public.countries_adminsublevel2 ad 
	       ON ST_Intersects(ca.shape,ad.geom)
	  WHERE ca.id = NEW.id;
	  RAISE NOTICE 'new id %',NEW.id;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mm.log_admin2_intersect()
  OWNER TO postgres;
