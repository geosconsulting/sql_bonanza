CREATE VIEW geo.countries AS SELECT * FROM geo.nuts WHERE LENGTH(geo.nuts.nuts_id)=2;

CREATE VIEW geo.macro_regions AS SELECT * FROM geo.nuts WHERE LENGTH(geo.nuts.nuts_id)=3;

CREATE VIEW geo.regions AS SELECT * FROM geo.nuts WHERE LENGTH(geo.nuts.nuts_id)=4;

CREATE VIEW geo.provinces AS SELECT * FROM geo.nuts WHERE LENGTH(geo.nuts.nuts_id)=5;