CREATE SEQUENCE public."attributenuts_internal_id_seq"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE public.attributenuts
(
  internal_id integer NOT NULL DEFAULT nextval('"attributenuts_internal_id_seq"'::regclass),
  cntr_code character varying(3),
  nut_id character(5),
  name_latin character varying(255),
  name_ascii character varying(255),
  CONSTRAINT "internal_id_pk" PRIMARY KEY (internal_id)
)
WITH (
  OIDS=FALSE
);