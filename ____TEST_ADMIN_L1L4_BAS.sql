select * from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,2,36351);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,2978);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2001,2001,1,2978);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,2747);

select sum(area_ha) from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,2747);

select adm_name,sum(number_of_fires) numero_incendi from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,2747) group by adm_name;

select sum(area_ha) from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,2747);

select sum(area_ha) from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,2754);

select adm_name,sum(number_of_fires) numero_incendi from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,2754) group by adm_name;

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,3,78243);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,4,55611);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2000,2018,1,3027);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2001,2002,1,3290);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2001,2001,1,3290);

select * from nasa_modis_ba.stats_modis_ba_l1_l4(2012,2018,1,5334);