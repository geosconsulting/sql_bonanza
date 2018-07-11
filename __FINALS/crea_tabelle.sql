DROP TABLE effis.current_burntareaspoly;

CREATE TABLE effis.current_burntareaspoly
   (objectid serial PRIMARY KEY NOT NULL,
    id integer ,
    country character varying(2) ,
    countryful character varying(100) ,
    province character varying(60) ,
    commune character varying(50) ,
    firedate character varying(10) ,
    area_ha integer ,
    broadlea numeric(38,8) ,
    conifer numeric(38,8) ,
    mixed numeric(38,8) ,
    scleroph numeric(38,8) ,
    transit numeric(38,8) ,
    othernatlc numeric(38,8) ,
    agriareas numeric(38,8) ,
    artifsurf numeric(38,8) ,
    otherlc numeric(38,8) ,
    percna2k numeric(38,8) ,
    lastupdate character varying(10) ,
    class character varying(6) ,
    mic character varying(5) ,
    se_anno_cad_data bytea ,    
    critech character varying(3),
    shape geometry(Polygon,4326)    
    );

-- SELECT AddGeometryColumn('current_burntareaspoly', 'shape', 4326, 'POLYGON', 3);
    
ALTER TABLE effis.current_burntareaspoly
  OWNER TO postgres;

CREATE INDEX current_burntareaspoly_polygon_geom_idx
  ON effis.current_burntareaspoly USING gist(shape);

-- CREATE OR REPLACE FUNCTION effis.fn_search_fire()
-- RETURNS trigger AS $$
-- DECLARE 
--    messaggio text;
-- BEGIN
--     IF TG_OP = 'INSERT' THEN
-- 	messaggio = 'INSERIMENTO';	
--     ELSEIF TG_OP = 'UPDATE' THEN
-- 	messaggio =  'AGGIORNAMENTO';
--     ELSEIF TG_OP = 'DELETE' THEN
-- 	messaggio = 'CANCELLAZIONE';
--     END IF;
--     RAISE NOTICE 'L attivita corrente e % ', messaggio;    
--     RETURN NEW;    
-- END;
-- $$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION effis.fn_search_fire()
RETURNS trigger AS $$
DECLARE
  old_row json := NULL;
  new_row json := NULL;
BEGIN
    IF TG_OP = 'INSERT' THEN
	new_row = row_to_json(NEW); 	  	
    ELSEIF TG_OP IN ('UPDATE','DELETE') THEN
	new_row = row_to_json(NEW); 
        old_row = row_to_json(OLD);	    	
    END IF;

    RAISE NOTICE 'Current activity % ', TG_OP;
    
    INSERT INTO effis.burnt_area_registry(ba_id,activity,utente,time_activity,before_value,after_value) 
    VALUES(NEW.objectid,TG_OP,session_user,current_timestamp,old_row,new_row);

    RETURN NEW;    
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER tg_sample_label AFTER INSERT OR UPDATE OR DELETE
ON effis.current_burntareaspoly FOR EACH ROW
EXECUTE PROCEDURE effis.fn_search_fire();