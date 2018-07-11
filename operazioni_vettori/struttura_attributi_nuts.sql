CREATE TABLE public."attributeNuts"
(
  internal_id serial,
  cntr_code character varying(5),
  nuts_id character(2) ,
  name_latin character varying(255),
  name_ascii character varying(255)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."attributeNuts"
  OWNER TO postgres;