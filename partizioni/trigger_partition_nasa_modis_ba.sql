-- Function: nasa_modis_ba.on_ba_insert()

-- DROP FUNCTION nasa_modis_ba.on_ba_insert();

CREATE OR REPLACE FUNCTION nasa_modis_ba.on_ba_insert()
  RETURNS trigger AS
$BODY$
begin
    if ( new.initialdate >= date '2018-01-01' and new.initialdate <= date '2018-12-31') then
        insert into nasa_modis_ba.final_ba_2018 values (new.*);
    elsif ( new.initialdate >= date '2017-01-01' and new.initialdate <= date '2017-12-31') then
        insert into nasa_modis_ba.final_ba_2017 values (new.*);
    elsif ( new.initialdate >= date '2016-01-01' and new.initialdate <= date '2016-12-31') then
        insert into nasa_modis_ba.final_ba_2016 values (new.*);
    elsif ( new.initialdate >= date '2015-01-01' and new.initialdate <= date '2015-12-31') then
        insert into nasa_modis_ba.final_ba_2015 values (new.*);
    elsif ( new.initialdate >= date '2014-01-01' and new.initialdate <= date '2014-12-31') then
        insert into nasa_modis_ba.final_ba_2014 values (new.*);
    elsif ( new.initialdate >= date '2013-01-01' and new.initialdate <= date '2013-12-31') then
        insert into nasa_modis_ba.final_ba_2013 values (new.*);
    elsif ( new.initialdate >= date '2012-01-01' and new.initialdate <= date '2012-12-31') then
        insert into nasa_modis_ba.final_ba_2012 values (new.*);
    elsif ( new.initialdate >= date '2011-01-01' and new.initialdate <= date '2011-12-31') then
        insert into nasa_modis_ba.final_ba_2011 values (new.*);
    elsif ( new.initialdate >= date '2010-01-01' and new.initialdate <= date '2010-12-31') then
        insert into nasa_modis_ba.final_ba_2010 values (new.*);
    elsif ( new.initialdate >= date '2009-01-01' and new.initialdate <= date '2009-12-31') then
        insert into nasa_modis_ba.final_ba_2009 values (new.*);
    elsif ( new.initialdate >= date '2008-01-01' and new.initialdate <= date '2008-12-31') then
        insert into nasa_modis_ba.final_ba_2008 values (new.*);
    elsif ( new.initialdate >= date '2007-01-01' and new.initialdate <= date '2007-12-31') then
        insert into nasa_modis_ba.final_ba_2007 values (new.*);
    elsif ( new.initialdate >= date '2006-01-01' and new.initialdate <= date '2006-12-31') then
        insert into nasa_modis_ba.final_ba_2006 values (new.*);
    elsif ( new.initialdate >= date '2005-01-01' and new.initialdate <= date '2005-12-31') then
        insert into nasa_modis_ba.final_ba_2005 values (new.*);
    elsif ( new.initialdate >= date '2004-01-01' and new.initialdate <= date '2004-12-31') then
        insert into nasa_modis_ba.final_ba_2004 values (new.*);        
    elsif ( new.initialdate >= date '2003-01-01' and new.initialdate <= date '2003-12-31') then
        insert into nasa_modis_ba.final_ba_2003 values (new.*);
    elsif ( new.initialdate >= date '2002-01-01' and new.initialdate <= date '2002-12-31') then
        insert into nasa_modis_ba.final_ba_2002 values (new.*);   
    elsif ( new.initialdate >= date '2001-01-01' and new.initialdate <= date '2001-12-31') then
        insert into nasa_modis_ba.final_ba_2001 values (new.*); 
    elsif ( new.initialdate >= date '2000-01-01' and new.initialdate <= date '2000-12-31') then
        insert into nasa_modis_ba.final_ba_2000 values (new.*); 
    else
        raise exception 'created_at date out of range';
    end if;
    return null;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION nasa_modis_ba.on_ba_insert()
  OWNER TO postgres;

GRANT EXECUTE ON FUNCTION nasa_modis_ba.on_ba_insert() TO postgres;
