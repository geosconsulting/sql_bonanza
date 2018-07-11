select count(*) from rdaprd.emissions_fires;
select count(*) from rdaprd.current_burntareaspoly;

alter table effis.fire_emission_statistic RENAME COLUMN "fireEmissionStatistic_id" to fes_id;
alter table effis.fire_emission_statistic RENAME COLUMN fire to ba_id;
alter table effis.fire_environmental_damage_statistic RENAME COLUMN burnt_area to ba_id;

ALTER TABLE effis.fire_emission_statistic  ADD CONSTRAINT fireemission_currentba_fk FOREIGN KEY (ba_id) REFERENCES effis.current_burnt_area (ba_id);
ALTER TABLE effis.fire_environmental_damage_statistic ADD CONSTRAINT fireenvironmentaldamage_currentba_fk FOREIGN KEY (ba_id) REFERENCES effis.current_burnt_area (ba_id);
ALTER TABLE effis.fire_emission_statistic  ADD CONSTRAINT fireemission_currentba_fk FOREIGN KEY (ba_id) REFERENCES effis.current_burnt_area (ba_id);
ALTER TABLE effis.fire_environmental_damage_statistic ADD CONSTRAINT fireenvironmentaldamage_currentba_fk FOREIGN KEY (ba_id) REFERENCES effis.current_burnt_area (ba_id);

--*********************************ESPOSITO**********************************************
TRUNCATE effis.fire_environmental_damage_statistic;
ALTER SEQUENCE effis.fire_environmental_damage_statistic_id_seq RESTART WITH 1;
INSERT INTO effis.fire_environmental_damage_statistic(ba_id,agricultural_area,artificial_surface,broad_leaved_forest,
                                                      coniferous,mixed,other_land_cover,other_natural_landcover,
                                                      percentage_natura2k,sclerophyllous,transitional)
SELECT id,agriareas,artifsurf,broadlea,conifer,mixed,otherlc,othernatlc,percna2k,scleroph,transit FROM  rdaprd.current_burntareaspoly;

--ALTER TABLE effis.fire_emission_statistic  drop CONSTRAINT fire_emission_statistics_fire_fk;
TRUNCATE effis.fire_emission_statistic;
ALTER TABLE effis.fire_emission_statistic  ADD CONSTRAINT fireemission_currentba_fk FOREIGN KEY (ba_id) REFERENCES effis.current_burnt_area (ba_id);
ALTER SEQUENCE effis.fire_emission_statistic_id_seq RESTART WITH 1;
INSERT INTO effis.fire_emission_statistic(ba_id,biomass,ch4,co,co2,ec,nmhc,nox,oc,pm,pm10,pm2_5,voc)
SELECT id,biomass,ch4,co,co2,ec,nmhc,nox,oc,pm,pm10,pm2_5,voc from rdaprd.emissions_fires;

--*********************************DEA**********************************************
--*******************************DA FARE********************************************