select * from nasa_modis_ba.gwis_stats where year_stats = 2007 and country in ('Honduras','El Salvador','Mexico');

select * from nasa_modis_ba.gwis_stats_last where year_stats = 2007 and country in ('Honduras','El Salvador','Mexico');

select * 
from nasa_modis_ba.gwis_stats s
  inner join tmp.centralamerica_20070101_20071231 v on s.country = v.country 
                                                   and s.year_stats=v.year_stats
                                                   and s.months_stats=v.months_stats
where s.year_stats = 2007; 
--and s.country in ('Honduras','El Salvador','Mexico');

create table nasa_modis_ba.gwis_stats_last (Like nasa_modis_ba.gwis_stats including constraints including indexes);

insert into nasa_modis_ba.gwis_stats_last
select * from nasa_modis_ba.gwis_stats;

select * from nasa_modis_ba.gwis_stats_last where year_stats = 2007 and country = 'Cuba';

update nasa_modis_ba.gwis_stats_last l
set number_of_fires = s.number_of_fires,
    hectares_stats = s.hectares_stats
from nasa_modis_ba.gwis_stats s
  inner join tmp.centralamerica_20070101_20071231 v on s.country = v.country 
                                                   and s.year_stats=v.year_stats
                                                   and s.months_stats=v.months_stats;
select *
from nasa_modis_ba.gwis_stats s
  inner join tmp.centralamerica_20070101_20071231 v on s.country = v.country 
                                                   and s.year_stats=v.year_stats
                                                   and s.months_stats=v.months_stats;
--caribbean
update nasa_modis_ba.gwis_stats_last l
set number_of_fires = v.number_of_fires,
    hectares_stats = v.hectares_stats
from tmp.caribbean_20070101_20071231 v 
where l.country = v.country 
and l.year_stats=v.year_stats
and l.months_stats=v.months_stats;     

select * from nasa_modis_ba.gwis_stats_last where year_stats = 2007 and country in ('Cuba','Haiti','Trinidad and Tobago');

--central america
update nasa_modis_ba.gwis_stats_last l
set number_of_fires = v.number_of_fires,
    hectares_stats = v.hectares_stats
from tmp.centralamerica_20070101_20071231 v 
where l.country = v.country 
and l.year_stats=v.year_stats
and l.months_stats=v.months_stats;   

select * from nasa_modis_ba.gwis_stats_last where year_stats = 2007 and country in ('Honduras','El Salvador','Mexico');

--creazione tabella 2007
insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.australianewzealand_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.caribbean_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.centralamerica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.centralasia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.easternafrica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.easternasia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.easterneurope_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.easternasia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.gambia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.indonesia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.japan_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.malaysia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.malta_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.melanesia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.micronesia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.middleafrica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.northernafrica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.northernamerica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.northerneurope_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.philippines_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.polynesia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.russia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.southamerica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.southeasternasia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.southernafrica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.southernasia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.southerneurope_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.unitedkingdom_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.westernafrica_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.westernasia_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.westerneurope_20070101_20071231;

insert into nasa_modis_ba.gwis_stats_2007
select * from tmp.westernsahara_20070101_20071231;
