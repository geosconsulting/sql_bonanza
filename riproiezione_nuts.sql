CREATE TABLE nuts.nuts_rg_01m_2013_wgs84 AS 
SELECT id,nuts_id,stat_levl_,ST_Transform(geom,4326) as geom
FROM nuts.nuts_rg_01m_2013;


CREATE TABLE nuts.nuts_rg_03m_2013_wgs84 AS 
SELECT id,nuts_id,stat_levl_,ST_Transform(geom,4326) as geom
FROM nuts.nuts_rg_03m_2013;


CREATE TABLE nuts.nuts_rg_10m_2013_wgs84 AS 
SELECT id,nuts_id,stat_levl_,ST_Transform(geom,4326) as geom
FROM nuts.nuts_rg_10m_2013;


CREATE TABLE nuts.nuts_rg_20m_2013_wgs84 AS 
SELECT id,nuts_id,stat_levl_,ST_Transform(geom,4326) as geom
FROM nuts.nuts_rg_20m_2013;

CREATE TABLE nuts.nuts_rg_60m_2013_wgs84 AS 
SELECT id,nuts_id,stat_levl_,ST_Transform(geom,4326) as geom
FROM nuts.nuts_rg_60m_2013;

--************************ LOW RESOLUTION
CREATE MATERIALIZED view nuts.adm_level_0_low_res As
select l0.id,attr.cntr_code,l0.nuts_id,l0.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l0.geom 
from nuts.nuts_rg_60m_2013_wgs84 l0, nuts.nuts_at_2013 attr 
WHERE stat_levl_=0
AND attr.nuts_id = l0.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_1_low_res As
select l1.id,attr.cntr_code,l1.nuts_id,l1.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l1.geom 
from nuts.nuts_rg_60m_2013_wgs84 l1, nuts.nuts_at_2013 attr 
WHERE stat_levl_=1
AND attr.nuts_id = l1.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_2_low_res As
select l2.id,attr.cntr_code,l2.nuts_id,l2.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l2.geom 
from nuts.nuts_rg_60m_2013_wgs84 l2, nuts.nuts_at_2013 attr 
WHERE stat_levl_=2
AND attr.nuts_id = l2.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_3_low_res As
select l3.id,attr.cntr_code,l3.nuts_id,l3.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l3.geom 
from nuts.nuts_rg_60m_2013_wgs84 l3, nuts.nuts_at_2013 attr 
WHERE stat_levl_=3
AND attr.nuts_id = l3.nuts_id;

--************************ MEDIUM RESOLUTION
CREATE MATERIALIZED view nuts.adm_level_0_medium_res AS
select l0.id,attr.cntr_code,l0.nuts_id,l0.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l0.geom 
from nuts.nuts_rg_10m_2013_wgs84 l0, nuts.nuts_at_2013 attr 
WHERE stat_levl_=0
AND attr.nuts_id = l0.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_1_medium_res AS
select l1.id,attr.cntr_code,l1.nuts_id,l1.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l1.geom 
from nuts.nuts_rg_10m_2013_wgs84 l1, nuts.nuts_at_2013 attr 
WHERE stat_levl_=1
AND attr.nuts_id = l1.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_2_medium_res AS
select l2.id,attr.cntr_code,l2.nuts_id,l2.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l2.geom 
from nuts.nuts_rg_10m_2013_wgs84 l2, nuts.nuts_at_2013 attr 
WHERE stat_levl_=2
AND attr.nuts_id = l2.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_3_medium_res AS
select l3.id,attr.cntr_code,l3.nuts_id,l3.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l3.geom 
from nuts.nuts_rg_10m_2013_wgs84 l3, nuts.nuts_at_2013 attr 
WHERE stat_levl_=3
AND attr.nuts_id = l3.nuts_id;

--************************ HIGH RESOLUTION
CREATE MATERIALIZED view nuts.adm_level_0_high_res AS
select l0.id,attr.cntr_code,l0.nuts_id,l0.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l0.geom 
from nuts.nuts_rg_01m_2013_wgs84 l0, nuts.nuts_at_2013 attr 
WHERE stat_levl_=0
AND attr.nuts_id = l0.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_1_high_res AS
select l1.id,attr.cntr_code,l1.nuts_id,l1.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l1.geom 
from nuts.nuts_rg_01m_2013_wgs84 l1, nuts.nuts_at_2013 attr 
WHERE stat_levl_=1
AND attr.nuts_id = l1.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_2_high_res AS
select l2.id,attr.cntr_code,l2.nuts_id,l2.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l2.geom 
from nuts.nuts_rg_01m_2013_wgs84 l2, nuts.nuts_at_2013 attr 
WHERE stat_levl_=2
AND attr.nuts_id = l2.nuts_id;

CREATE MATERIALIZED view nuts.adm_level_3_high_res AS
select l3.id,attr.cntr_code,l3.nuts_id,l3.stat_levl_,attr.name_latn,attr.nuts_name,attr.name_ascii,l3.geom 
from nuts.nuts_rg_01m_2013_wgs84 l3, nuts.nuts_at_2013 attr 
WHERE stat_levl_=3
AND attr.nuts_id = l3.nuts_id;

