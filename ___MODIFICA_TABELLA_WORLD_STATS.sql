alter table nasa_modis_ba.gwis_stats 
add constraint country_code_fk foreign key (country_code) 
references public.admin_level_0(id) MATCH FULL;

alter table nasa_modis_ba.gwis_stats drop column country_iso;

alter table nasa_modis_ba.gwis_stats add column country_iso varchar(3);

alter table nasa_modis_ba.gwis_stats 
add constraint country_iso_fk 
foreign key (country_iso) 
references public.admin_level_0(iso) MATCH FULL;

update nasa_modis_ba.gwis_stats w
SET country_code = a.id,
    country_iso = a.iso
from public.admin_level_0 a
where w.country = a.name_en;

alter table nasa_modis_ba.gwis_stats drop constraint worldstats_pkey;

alter table nasa_modis_ba.gwis_stats add primary key(year_stats,months_stats,country_code);

drop index gwis_stats_idx;

CREATE INDEX gwis_stats_idx
  ON nasa_modis_ba.gwis_stats
  USING btree
  (year_stats,months_stats,country_code);

