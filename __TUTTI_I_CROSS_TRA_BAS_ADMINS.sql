CREATE SEQUENCE egeos.ba_adm0_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 16
  CACHE 1;
ALTER TABLE egeos.ba_adm0_seq
  OWNER TO postgres;

CREATE SEQUENCE egeos.ba_adm1_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 16
  CACHE 1;
ALTER TABLE egeos.ba_adm1_seq
  OWNER TO postgres;

CREATE SEQUENCE egeos.ba_adm2_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 16
  CACHE 1;
ALTER TABLE egeos.ba_adm2_seq
  OWNER TO postgres;

CREATE SEQUENCE egeos.ba_adm3_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 16
  CACHE 1;
ALTER TABLE egeos.ba_adm3_seq
  OWNER TO postgres;

drop table egeos.ba_adm3;

CREATE TABLE egeos.ba_adm3
(
  id_adm3_ba integer NOT NULL DEFAULT nextval('egeos.ba_adm3_seq'::regclass),
  fire_id integer,
  admin_id integer,
  CONSTRAINT ba_adm3_pkey PRIMARY KEY (id_adm3_ba)
  --,CONSTRAINT adm3_fkey FOREIGN KEY (admin_id)
  --    REFERENCES public.admin_level_3 (id) MATCH SIMPLE
  --    ON UPDATE NO ACTION ON DELETE NO ACTION --,
  --CONSTRAINT ba_fkey FOREIGN KEY (admin_id)
  --    REFERENCES egeos.current_ba (id) MATCH SIMPLE
  --    ON DELETE cascade
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.ba_adm3
  OWNER TO postgres;

ALTER TABLE egeos.ba_adm3 
add CONSTRAINT adm3_fkey FOREIGN KEY (admin_id)
REFERENCES public.admin_level_3 (id) ON DELETE NO ACTION;

ALTER TABLE egeos.ba_adm3 
add CONSTRAINT ba_adm3_fkey FOREIGN KEY (fire_id)
REFERENCES egeos.current_ba(id) 
ON UPDATE cascade
ON DELETE cascade;

drop table egeos.ba_adm2;

CREATE TABLE egeos.ba_adm2
(
  id_adm2_ba integer NOT NULL DEFAULT nextval('egeos.ba_adm2_seq'::regclass),
  fire_id integer,
  admin_id integer,
  CONSTRAINT ba_adm2_pkey PRIMARY KEY (id_adm2_ba),
  CONSTRAINT adm2_fkey FOREIGN KEY (admin_id)
      REFERENCES public.admin_level_2 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION --,
  --CONSTRAINT ba_fkey FOREIGN KEY (admin_id)
  --    REFERENCES egeos.current_ba (id) MATCH SIMPLE
  --    ON DELETE cascade
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.ba_adm2
  OWNER TO postgres;

ALTER TABLE egeos.ba_adm2 
add CONSTRAINT adm2_fkey 
FOREIGN KEY (admin_id) REFERENCES public.admin_level_2 (id) 
ON DELETE NO ACTION;

ALTER TABLE egeos.ba_adm2
add CONSTRAINT ba_adm2_fkey FOREIGN KEY (fire_id)
REFERENCES egeos.current_ba(id) 
ON UPDATE cascade
ON DELETE cascade;

drop table egeos.ba_adm1;

CREATE TABLE egeos.ba_adm1
(
  id_adm1_ba integer NOT NULL DEFAULT nextval('egeos.ba_adm1_seq'::regclass),
  fire_id integer,
  admin_id integer,
  CONSTRAINT ba_adm1_pkey PRIMARY KEY (id_adm1_ba)
  --,CONSTRAINT adm1_fkey FOREIGN KEY (admin_id)
  --    REFERENCES public.admin_level_1 (id) MATCH SIMPLE
  --    ON UPDATE NO ACTION ON DELETE NO ACTION --,
  --CONSTRAINT ba_fkey FOREIGN KEY (admin_id)
  --    REFERENCES egeos.current_ba (id) MATCH SIMPLE
  --    ON DELETE cascade
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.ba_adm1
  OWNER TO postgres;

ALTER TABLE egeos.ba_adm1 
add CONSTRAINT adm1_fkey FOREIGN KEY (admin_id)
REFERENCES public.admin_level_1 (id) 
ON DELETE NO ACTION;

ALTER TABLE egeos.ba_adm1 
add CONSTRAINT ba_adm1_fkey 
FOREIGN KEY (fire_id) REFERENCES egeos.current_ba(id) 
ON UPDATE cascade
ON DELETE cascade;

drop table egeos.ba_adm0;

CREATE TABLE egeos.ba_adm0
(
  id_adm0_ba integer NOT NULL DEFAULT nextval('egeos.ba_adm0_seq'::regclass),
  fire_id integer,
  admin_id integer,
  CONSTRAINT ba_adm0_pkey PRIMARY KEY (id_adm0_ba)
  --,CONSTRAINT adm0_fkey FOREIGN KEY (admin_id)
  --    REFERENCES public.admin_level_0 (id) MATCH SIMPLE
  --    ON UPDATE NO ACTION ON DELETE NO ACTION --,
  --CONSTRAINT ba_fkey FOREIGN KEY (admin_id)
  --    REFERENCES egeos.current_ba (id) MATCH SIMPLE
  --    ON DELETE cascade
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.ba_adm0
  OWNER TO postgres;

ALTER TABLE egeos.ba_adm0 
add CONSTRAINT adm0_fkey FOREIGN KEY (admin_id)
REFERENCES public.admin_level_0 (id) ON DELETE NO ACTION;

ALTER TABLE egeos.ba_adm0 
add CONSTRAINT ba_adm0_fkey FOREIGN KEY (fire_id)
REFERENCES egeos.current_ba(id) 
ON UPDATE cascade
ON DELETE cascade;

CREATE OR REPLACE FUNCTION egeos.log_admin0_intersect()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO egeos.ba_adm0(fire_id,admin_id)
	  SELECT ba.id,ad.id
	  FROM egeos.current_ba ba
	  LEFT JOIN public.admin_level_0 ad 
	       ON ST_Intersects(ba.geom,ad.geom)
	  WHERE ba.id = NEW.id;
	  RAISE NOTICE 'new id %',NEW.id;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION egeos.log_admin0_intersect()
  OWNER TO postgres;
  
CREATE TRIGGER new_ba_inserted_calculate_adm0
  AFTER INSERT
  ON egeos.current_ba
  FOR EACH ROW
  EXECUTE PROCEDURE egeos.log_admin0_intersect();

CREATE TRIGGER new_ba_inserted_calculate_adm1
  AFTER INSERT
  ON egeos.current_ba
  FOR EACH ROW
  EXECUTE PROCEDURE egeos.log_admin1_intersect();

CREATE TRIGGER new_ba_inserted_calculate_adm2
  AFTER INSERT
  ON egeos.current_ba
  FOR EACH ROW
  EXECUTE PROCEDURE egeos.log_admin2_intersect();

CREATE TRIGGER new_ba_inserted_calculate_adm3
  AFTER INSERT
  ON egeos.current_ba
  FOR EACH ROW
  EXECUTE PROCEDURE egeos.log_admin3_intersect();

select * from egeos.ba_adm0 badm
    left join public.admin_level_0 adm on badm.admin_id = adm.id
where badm.fire_id = 100;

select badm.*,adm.name_en,adm.iso
from egeos.ba_adm0 badm, public.admin_level_0 adm 
where badm.admin_id = adm.id
and badm.fire_id = 100;

select badm.*,adm.name_en
from egeos.ba_adm3 badm, public.admin_level_3 adm 
where badm.admin_id = adm.id
and badm.fire_id = 100;
