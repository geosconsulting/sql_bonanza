CREATE TABLE fire (
gid serial NOT NULL,
geom geometry(point, 4326),
label_sample varchar(255),
CONSTRAINT label_point_pkey PRIMARY KEY (gid));

CREATE TABLE burnt_area (
gid serial NOT NULL,
geom geometry(polygon, 4326),
label varchar(255),
CONSTRAINT soil_pkey PRIMARY KEY (gid));

CREATE OR REPLACE FUNCTION sample_label()
RETURNS trigger AS $body$
    BEGIN
    IF GeometryType(NEW.geom) = 'POINT' THEN
        EXECUTE 'SELECT label FROM burnt_area WHERE ST_Within($1, burnt_area.geom) LIMIT 1'
        USING NEW.geom 
        INTO NEW.label_sample;
        RETURN NEW;
    ELSEIF GeometryType(NEW.geom) = 'POLYGON' THEN
        EXECUTE 'UPDATE fire SET label_sample = NULL WHERE ST_Within(fire.geom, $1)'
        USING NEW.geom;
        RETURN NEW;
    END IF;
    END;
$body$ LANGUAGE plpgsql;

CREATE TRIGGER tg_sample_label BEFORE INSERT OR UPDATE
ON fire FOR EACH ROW
EXECUTE PROCEDURE sample_label();


CREATE TRIGGER tg_sample_label AFTER INSERT OR UPDATE
ON burnt_area FOR EACH ROW
EXECUTE PROCEDURE sample_label();