select ba_id,area_ha from effis.current_burnt_area where ba_id=6086;

select * from effis.bas_by_admin(4,50025);

select * from effis.ba_by_adm_code(3,96987);
select * from effis.ba_by_adm_code(3,88700);

select * from ba_adm.associate_ba_adm(2);

select * from effis.ba_by_adm_code(2,56493);
select * from effis.ba_by_adm_code(2,33831);

select * from ba_adm.associate_ba_adm(1);
select * from ba_adm.associate_ba_adm(2);
select * from ba_adm.associate_ba_adm(3);
select * from ba_adm.associate_ba_adm(4);
select * from effis.associate_ba_adm_where(4);

select * from ba_adm.associate_ba_adm(1);

select * from effis.ba_by_adm_code(1,3492);

select * from ba_adm.associate_ba_adm(0);

select count(*) from effis.ba_by_adm_code(0,112); -- Italia
select count(*) from effis.ba_by_adm_code(0,215); -- Spagna
select * from effis.ba_by_adm_code(0,182); -- Portogallo

select * from ba_adm.admns_by_fireid(8049,3);
select * from ba_adm.admns_by_fireid(642,3);
select * from ba_adm.admns_by_fireid(2,3);
select * from ba_adm.admns_by_fireid(2,4);

select * from ba_adm.admns_by_fireid(3534,4);
select * from ba_adm.admns_by_fireid(3534,3);
select * from ba_adm.admns_by_fireid(3534,2);
select * from ba_adm.admns_by_fireid(3534,1);
select * from ba_adm.admns_by_fireid(3534,0);

select * from ba_adm.adm3_by_fireid_with_areas(3846);

select * from ba_adm.admns_by_fireid_with_areas(3846,3);
select * from ba_adm.admns_by_fireid_with_areas(3846,2);

select * from ba_adm.admns_by_fireid_with_areas(3846,4);
select * from ba_adm.admns_by_fireid_with_areas(3846,3);
select * from ba_adm.admns_by_fireid_with_areas(3846,2);
select * from ba_adm.admns_by_fireid_with_areas(3846,1);

select * from effis.stats_poly_on_landcover(3846,'effis','glc');
select * from effis.stats_poly_on_landcover(3846,'effis','clc');

select * from ba_adm.admns_by_fireid(3846,2);

select * from ba_adm.admns_by_fireid(70,2);

select * from ba_adm.admns_by_fireid(670,2);

select * from ba_adm.admns_by_fireid(3850,2);
select * from ba_adm.admns_by_fireid(3850,3);

select * from ba_adm.admns_by_fireid(672,2);

select * from ba_adm.admns_by_fireid(70,1);
select * from ba_adm.admns_by_fireid(70,2);
select * from ba_adm.admns_by_fireid(70,3);

select * from ba_adm.admns_by_fireid(1295,2);

select * from effis.stats_poly_on_landcover(70,'effis','glc');
select * from effis.stats_poly_on_landcover(70,'effis','clc');

select * from effis.stats_poly_on_landcover(1295,'effis','glc');

select * from effis.bas_by_iso2('PT');

select count(name_adm),sum(area_ha) from effis.bas_by_iso2('PT');

select * from effis.burnt_areas where ba_id = 3846;
select * from effis.current_burnt_area where ba_id = 3846;
select * from rdaprd_esposito.current_burntareaspoly where id = 3846;
select * from rdaprd.rob_burntareas where id = 3846;

CREATE TABLE modis_viirs.viirs_2012 (
	CONSTRAINT enforce_dims_geom CHECK ((st_ndims(geom) = 2)),
	CONSTRAINT enforce_geotype_geom CHECK (((geometrytype(geom) = 'POINT'::text) OR (geom IS NULL))),
	CONSTRAINT enforce_srid_geom CHECK ((st_srid(geom) = 4326)),
	CONSTRAINT viirs_2012_acq_date_check CHECK (((acq_date >= '2012-01-01'::date) AND (acq_date <= '2012-12-31'::date)))
)
INHERITS (modis_viirs.viirs)
WITH (
	OIDS=FALSE
);