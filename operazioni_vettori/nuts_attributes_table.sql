CREATE TABLE geo.attributes
(
  id serial NOT NULL,
  cntr_code character(2),
  nuts_id character varying(14),
  name_latin character(255),
  nuts_name character(255),
  name_ascii character(255),
  name_html character(255),
  CONSTRAINT nuts_attributes_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE geo.attributes
  OWNER TO postgres;