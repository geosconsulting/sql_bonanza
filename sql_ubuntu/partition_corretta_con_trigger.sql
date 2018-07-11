CREATE TABLE modis_viirs.modis(
	modis_id serial,
	latitude  numeric,
	longitude numeric,
	brightness numeric,
	scan  numeric,
	track  numeric,
	acq_date  date,
	acq_time  time without time zone,
	satellite varchar(5),
	instrument varchar(6),
	confidence integer,
	version numeric,
	bright_t31 numeric,
	frp  numeric);

-- Add a spatial column to the table
SELECT AddGeometryColumn ('modis_viirs','modis','geom',4326,'POINT',2);

ALTER TABLE modis_viirs.modis ADD CONSTRAINT modis_pk PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis ADD CONSTRAINT enforce_dims_geom CHECK(st_ndims(geom) = 2);
ALTER TABLE modis_viirs.modis ADD CONSTRAINT enforce_geotype_geom CHECK(geometrytype(geom) = 'POINT'::text OR geom IS NULL);
ALTER TABLE modis_viirs.modis ADD CONSTRAINT enforce_srid_geom CHECK(st_srid(geom) = 4326);

CREATE TABLE modis_viirs.modis_2017() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2017 ADD CHECK(acq_date >= '2017-01-01' AND acq_date <= '2017-12-31');

CREATE TABLE modis_viirs.modis_2016() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2016 ADD CHECK(acq_date >= '2016-01-01' AND acq_date <= '2016-12-31');

CREATE TABLE modis_viirs.modis_2015() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2015 ADD CHECK(acq_date >= '2015-01-01' AND acq_date <= '2015-12-31');

create or replace function modis_viirs.on_hotspot_insert() returns trigger as $$
begin
    if ( new.acq_date >= date '2017-01-01' and new.acq_date <= date '2017-12-31') then
        insert into modis_viirs.modis_2017 values (new.*);
    elsif ( new.acq_date >= date '2016-01-01' and new.acq_date <= date '2016-12-31') then
        insert into modis_viirs.modis_2016 values (new.*);
    elsif ( new.acq_date >= date '2015-01-01' and new.acq_date <= date '2015-12-31') then
        insert into modis_viirs.modis_2015 values (new.*);
    elsif ( new.acq_date >= date '2014-01-01' and new.acq_date <= date '2014-12-31') then
        insert into modis_viirs.modis_2014 values (new.*);
    elsif ( new.acq_date >= date '2013-01-01' and new.acq_date <= date '2013-12-31') then
        insert into modis_viirs.modis_2013 values (new.*);
    elsif ( new.acq_date >= date '2012-01-01' and new.acq_date <= date '2012-12-31') then
        insert into modis_viirs.modis_2012 values (new.*);
    elsif ( new.acq_date >= date '2011-01-01' and new.acq_date <= date '2011-12-31') then
        insert into modis_viirs.modis_2011 values (new.*);
    elsif ( new.acq_date >= date '2010-01-01' and new.acq_date <= date '2010-12-31') then
        insert into modis_viirs.modis_2010 values (new.*);
    elsif ( new.acq_date >= date '2009-01-01' and new.acq_date <= date '2009-12-31') then
        insert into modis_viirs.modis_2009 values (new.*);
    elsif ( new.acq_date >= date '2008-01-01' and new.acq_date <= date '2008-12-31') then
        insert into modis_viirs.modis_2008 values (new.*);
    elsif ( new.acq_date >= date '2007-01-01' and new.acq_date <= date '2007-12-31') then
        insert into modis_viirs.modis_2007 values (new.*);
    elsif ( new.acq_date >= date '2006-01-01' and new.acq_date <= date '2006-12-31') then
        insert into modis_viirs.modis_2006 values (new.*);
    elsif ( new.acq_date >= date '2005-01-01' and new.acq_date <= date '2005-12-31') then
        insert into modis_viirs.modis_2005 values (new.*);
    elsif ( new.acq_date >= date '2004-01-01' and new.acq_date <= date '2004-12-31') then
        insert into modis_viirs.modis_2004 values (new.*);        
    elsif ( new.acq_date >= date '2003-01-01' and new.acq_date <= date '2003-12-31') then
        insert into modis_viirs.modis_2003 values (new.*);
    elsif ( new.acq_date >= date '2002-01-01' and new.acq_date <= date '2002-12-31') then
        insert into modis_viirs.modis_2002 values (new.*);   
    elsif ( new.acq_date >= date '2001-01-01' and new.acq_date <= date '2001-12-31') then
        insert into modis_viirs.modis_2001 values (new.*); 
    else
        raise exception 'created_at date out of range';
    end if;
    return null;
end;
$$ language plpgsql;

DROP trigger hotspots_insert ON modis_viirs.modis;

create trigger hotspots_insert
    before insert on modis_viirs.modis
    for each row execute procedure modis_viirs.on_hotspot_insert();


ALTER TABLE modis_viirs.modis_2017 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2016 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2015 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2014 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2013 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2012 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2011 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2010 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2009 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2008 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2007 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2006 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2005 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2004 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2003 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2002 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2001 ADD PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis_2000 ADD PRIMARY KEY(modis_id);


