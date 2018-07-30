--Cambodia
select * from nasa_modis_ba.aggiungi_2007('Cambodia');

--Cameroon
select * from nasa_modis_ba.aggiungi_2007('Cameroon');

select * from nasa_modis_ba.aggiungi_2007('Canada');
select * from nasa_modis_ba.aggiungi_2007('Caspian Sea');
select * from nasa_modis_ba.aggiungi_2007('Central African Republic');
select * from nasa_modis_ba.aggiungi_2007('Chad');
select * from nasa_modis_ba.aggiungi_2007('Chile');
select * from nasa_modis_ba.aggiungi_2007('China');
select * from nasa_modis_ba.aggiungi_2007('Colombia');
select * from nasa_modis_ba.aggiungi_2007('Costa Rica');

--*************************************************************
select * from nasa_modis_ba.aggiungi_2007('Côte d''Ivoire');
--*************************************************************
--blocco comandi
--Albania
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Côte d''Ivoire'; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Côte d''Ivoire';
delete from nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Côte d''Ivoire';
insert into nasa_modis_ba.gwis_stats_last(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code)
SELECT country,year_stats,months_stats,number_of_fires,hectares_stats,country_code FROM nasa_modis_ba.gwis_stats_2007 WHERE country = 'Côte d''Ivoire';
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Côte d''Ivoire'; 

select * from nasa_modis_ba.aggiungi_2007('Croatia');
select * from nasa_modis_ba.aggiungi_2007('Cuba');
select * from nasa_modis_ba.aggiungi_2007('Cyprus');
select * from nasa_modis_ba.aggiungi_2007('Czech Republic');
select * from nasa_modis_ba.aggiungi_2007('Democratic Republic of the Congo');
select * from nasa_modis_ba.aggiungi_2007('Denmark');
select * from nasa_modis_ba.aggiungi_2007('Dominican Republic');
select * from nasa_modis_ba.aggiungi_2007('East Timor');
select * from nasa_modis_ba.aggiungi_2007('Ecuador');
select * from nasa_modis_ba.aggiungi_2007('Egypt');
select * from nasa_modis_ba.aggiungi_2007('El Salvador');
select * from nasa_modis_ba.aggiungi_2007('Equatorial Guinea');
select * from nasa_modis_ba.aggiungi_2007('Eritrea');
select * from nasa_modis_ba.aggiungi_2007('Ethiopia');
select * from nasa_modis_ba.aggiungi_2007('Finland');
select * from nasa_modis_ba.aggiungi_2007('France');
select * from nasa_modis_ba.aggiungi_2007('French Guiana');
select * from nasa_modis_ba.aggiungi_2007('Gabon');
select * from nasa_modis_ba.aggiungi_2007('Georgia');
select * from nasa_modis_ba.aggiungi_2007('Germany');
select * from nasa_modis_ba.aggiungi_2007('Ghana');
select * from nasa_modis_ba.aggiungi_2007('Greece');
select * from nasa_modis_ba.aggiungi_2007('Guatemala');
select * from nasa_modis_ba.aggiungi_2007('Guinea');
select * from nasa_modis_ba.aggiungi_2007('Guinea-Bissau');
select * from nasa_modis_ba.aggiungi_2007('Guyana');
select * from nasa_modis_ba.aggiungi_2007('Haiti');
select * from nasa_modis_ba.aggiungi_2007('Honduras');
select * from nasa_modis_ba.aggiungi_2007('Hong Kong');
select * from nasa_modis_ba.aggiungi_2007('Hungary');
select * from nasa_modis_ba.aggiungi_2007('India');
select * from nasa_modis_ba.aggiungi_2007('Indonesia');
select * from nasa_modis_ba.aggiungi_2007('Iran');
select * from nasa_modis_ba.aggiungi_2007('Iraq');
select * from nasa_modis_ba.aggiungi_2007('Ireland');
select * from nasa_modis_ba.aggiungi_2007('Israel');
select * from nasa_modis_ba.aggiungi_2007('Italy');
select * from nasa_modis_ba.aggiungi_2007('Jamaica');
select * from nasa_modis_ba.aggiungi_2007('Japan');
select * from nasa_modis_ba.aggiungi_2007('Jordan');
select * from nasa_modis_ba.aggiungi_2007('Kazakhstan');
select * from nasa_modis_ba.aggiungi_2007('Kenya');
select * from nasa_modis_ba.aggiungi_2007('Kosovo');
select * from nasa_modis_ba.aggiungi_2007('Kuwait');
select * from nasa_modis_ba.aggiungi_2007('Kyrgyzstan');
select * from nasa_modis_ba.aggiungi_2007('Laos');
select * from nasa_modis_ba.aggiungi_2007('Latvia');
select * from nasa_modis_ba.aggiungi_2007('Lebanon');
select * from nasa_modis_ba.aggiungi_2007('Lesotho');
select * from nasa_modis_ba.aggiungi_2007('Liberia');
select * from nasa_modis_ba.aggiungi_2007('Libya');
select * from nasa_modis_ba.aggiungi_2007('Lithuania');
select * from nasa_modis_ba.aggiungi_2007('Macedonia');
select * from nasa_modis_ba.aggiungi_2007('Madagascar');
select * from nasa_modis_ba.aggiungi_2007('Malawi');
select * from nasa_modis_ba.aggiungi_2007('Mali');
select * from nasa_modis_ba.aggiungi_2007('Mauritania');
select * from nasa_modis_ba.aggiungi_2007('Mexico');
select * from nasa_modis_ba.aggiungi_2007('Moldova');
select * from nasa_modis_ba.aggiungi_2007('Mongolia');
select * from nasa_modis_ba.aggiungi_2007('Montenegro');
select * from nasa_modis_ba.aggiungi_2007('Morocco');
select * from nasa_modis_ba.aggiungi_2007('Mozambique');
select * from nasa_modis_ba.aggiungi_2007('Myanmar');
select * from nasa_modis_ba.aggiungi_2007('Namibia');
select * from nasa_modis_ba.aggiungi_2007('Nepal');
select * from nasa_modis_ba.aggiungi_2007('Netherlands');
select * from nasa_modis_ba.aggiungi_2007('Nicaragua');
select * from nasa_modis_ba.aggiungi_2007('Niger');
select * from nasa_modis_ba.aggiungi_2007('Nigeria');
select * from nasa_modis_ba.aggiungi_2007('North Korea');
select * from nasa_modis_ba.aggiungi_2007('Norway');
select * from nasa_modis_ba.aggiungi_2007('Oman');
select * from nasa_modis_ba.aggiungi_2007('Pakistan');
select * from nasa_modis_ba.aggiungi_2007('Palestina');
select * from nasa_modis_ba.aggiungi_2007('Panama');
select * from nasa_modis_ba.aggiungi_2007('Papua New Guinea');
select * from nasa_modis_ba.aggiungi_2007('Paraguay');
select * from nasa_modis_ba.aggiungi_2007('Peru');
select * from nasa_modis_ba.aggiungi_2007('Philippines');
select * from nasa_modis_ba.aggiungi_2007('Poland');
select * from nasa_modis_ba.aggiungi_2007('Portugal');
select * from nasa_modis_ba.aggiungi_2007('Puerto Rico');
select * from nasa_modis_ba.aggiungi_2007('Qatar');
select * from nasa_modis_ba.aggiungi_2007('Republic of Congo');
select * from nasa_modis_ba.aggiungi_2007('Romania');
select * from nasa_modis_ba.aggiungi_2007('Russia');
select * from nasa_modis_ba.aggiungi_2007('Rwanda');
select * from nasa_modis_ba.aggiungi_2007('Saudi Arabia');
select * from nasa_modis_ba.aggiungi_2007('Senegal');
select * from nasa_modis_ba.aggiungi_2007('Serbia');
select * from nasa_modis_ba.aggiungi_2007('Sierra Leone');
select * from nasa_modis_ba.aggiungi_2007('Slovakia');
select * from nasa_modis_ba.aggiungi_2007('Slovenia');
select * from nasa_modis_ba.aggiungi_2007('Somalia');
select * from nasa_modis_ba.aggiungi_2007('South Africa');
select * from nasa_modis_ba.aggiungi_2007('South Korea');
select * from nasa_modis_ba.aggiungi_2007('South Sudan');
select * from nasa_modis_ba.aggiungi_2007('Spain');
select * from nasa_modis_ba.aggiungi_2007('Sri Lanka');
select * from nasa_modis_ba.aggiungi_2007('Sudan');
select * from nasa_modis_ba.aggiungi_2007('Suriname');
select * from nasa_modis_ba.aggiungi_2007('Swaziland');
select * from nasa_modis_ba.aggiungi_2007('Sweden');
select * from nasa_modis_ba.aggiungi_2007('Switzerland');
select * from nasa_modis_ba.aggiungi_2007('Syria');
select * from nasa_modis_ba.aggiungi_2007('Tajikistan');
select * from nasa_modis_ba.aggiungi_2007('Tanzania');
select * from nasa_modis_ba.aggiungi_2007('Thailand');
select * from nasa_modis_ba.aggiungi_2007('Togo');
select * from nasa_modis_ba.aggiungi_2007('Trinidad and Tobago');
select * from nasa_modis_ba.aggiungi_2007('Tunisia');
select * from nasa_modis_ba.aggiungi_2007('Turkey');
select * from nasa_modis_ba.aggiungi_2007('Turkmenistan');
select * from nasa_modis_ba.aggiungi_2007('Uganda');
select * from nasa_modis_ba.aggiungi_2007('Ukraine');
select * from nasa_modis_ba.aggiungi_2007('United Arab Emirates');
select * from nasa_modis_ba.aggiungi_2007('United Kingdom');
select * from nasa_modis_ba.aggiungi_2007('United States');
select * from nasa_modis_ba.aggiungi_2007('Uruguay');
select * from nasa_modis_ba.aggiungi_2007('Uzbekistan');
select * from nasa_modis_ba.aggiungi_2007('Venezuela');
select * from nasa_modis_ba.aggiungi_2007('Vietnam');
select * from nasa_modis_ba.aggiungi_2007('Yemen');
select * from nasa_modis_ba.aggiungi_2007('Zambia');
select * from nasa_modis_ba.aggiungi_2007('Zimbabwe');

select * from nasa_modis_ba.stats_modis_ba_ha_paese(2005,'New Zealand');

insert into nasa_modis_ba.gwis_stats
select * from nasa_modis_ba.gwis_stats_last;









