-- View: nasa_modis_ba.caribbean

-- DROP MATERIALIZED VIEW nasa_modis_ba.caribbean;

CREATE MATERIALIZED VIEW nasa_modis_ba.caribbean
TABLESPACE pg_default
AS
 SELECT * FROM nasa_modis_ba.caribbean_20000101_20001231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20010101_20011231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20020101_20021231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20030101_20031231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20040101_20041231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20050101_20051231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20060101_20061231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20060101_20061231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20080101_20081231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20090101_20091231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20100101_20101231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20110101_20111231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20120101_20121231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20130101_20131231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20140101_20141231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20150101_20151231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20160101_20161231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20170101_20171231
UNION
 SELECT * FROM nasa_modis_ba.caribbean_20180101_20181231
WITH DATA;

ALTER TABLE nasa_modis_ba.caribbean
    OWNER TO postgres;