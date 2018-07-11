CREATE TABLE nasa_modis_ba.final_ba (LIKE nasa_modis_ba.final_burnt_areas_2001);

CREATE TABLE nasa_modis_ba.final_ba_2017() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2017 ADD CHECK(initialdate >= '2017-01-01' AND initialdate < '2018-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2016() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2016 ADD CHECK(initialdate >= '2016-01-01' AND initialdate < '2017-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2015() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2015 ADD CHECK(initialdate >= '2015-01-01' AND initialdate < '2016-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2014() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2014 ADD CHECK(initialdate >= '2014-01-01' AND initialdate < '2015-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2013() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2013 ADD CHECK(initialdate >= '2013-01-01' AND initialdate < '2014-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2012() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2012 ADD CHECK(initialdate >= '2012-01-01' AND initialdate < '2013-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2011() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2011 ADD CHECK(initialdate >= '2011-01-01' AND initialdate < '2012-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2010() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2010 ADD CHECK(initialdate >= '2010-01-01' AND initialdate < '2011-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2009() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2009 ADD CHECK(initialdate >= '2009-01-01' AND initialdate < '2010-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2008() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2008 ADD CHECK(initialdate >= '2008-01-01' AND initialdate < '2009-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2007() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2007 ADD CHECK(initialdate >= '2007-01-01' AND initialdate < '2008-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2006() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2006 ADD CHECK(initialdate >= '2006-01-01' AND initialdate < '2007-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2005() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2005 ADD CHECK(initialdate >= '2005-01-01' AND initialdate < '2006-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2004() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2004 ADD CHECK(initialdate >= '2004-01-01' AND initialdate < '2005-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2003() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2003 ADD CHECK(initialdate >= '2003-01-01' AND initialdate < '2004-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2002() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2002 ADD CHECK(initialdate >= '2002-01-01' AND initialdate < '2003-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2001() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2001 ADD CHECK(initialdate >= '2001-01-01' AND initialdate < '2002-01-01');

CREATE TABLE nasa_modis_ba.final_ba_2000() INHERITS(nasa_modis_ba.final_ba);
ALTER TABLE nasa_modis_ba.final_ba_2000 ADD CHECK(initialdate >= '2000-01-01' AND initialdate < '2001-01-01');

DO $cazzarola$
DECLARE
 anno_inizio integer := 2000;
 anno_fine integer := 2017;
 nome_tabella_corrente varchar;
begin
   while anno_inizio < anno_fine loop
       anno_inizio := anno_inizio +1;
       nome_tabella_corrente := 'nasa_modis_ba.final_burnt_areas_' || anno_inizio;
       raise notice '%', nome_tabella_corrente;
           EXECUTE 'INSERT INTO nasa_modis_ba.final_ba SELECT * FROM ' || nome_tabella_corrente;
   end loop;
end $cazzarola$;

INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2001;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2002;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2003;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2004;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2005;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2006;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2007;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2008;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2009;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2010;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2011;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2012;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2013;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2014;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2015;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2016;
INSERT INTO nasa_modis_ba.final_ba SELECT * FROM nasa_modis_ba.final_burnt_areas_2017;

SELECT count(id) FROM nasa_modis_ba.final_burnt_areas_2001 WHERE initialdate <= '2000-12-31';





