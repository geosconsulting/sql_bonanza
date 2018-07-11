--ALTER TABLE nasa_modis_ba.final_ba ADD PRIMARY KEY (id);

--DROP INDEX nasa_modis_ba.idx_nasa_modis_final_ba_initialdate;

CREATE INDEX idx_nasa_modis_final_ba_initialdate
ON nasa_modis_ba.final_ba
USING btree (initialdate);

--CREATE INDEX idx_nasa_modis_final_ba_initialdate
--ON nasa_modis_ba.final_ba_2000
--USING btree (initialdate);

DO $cazzarola$
DECLARE
 anno_inizio integer := 2000;
 anno_fine integer := 2017;
 nome_indice_corrente varchar;
 chiave_primaria varchar;
begin
   while anno_inizio < anno_fine loop
       anno_inizio := anno_inizio + 1;
       nome_indice_corrente := 'idx_nasa_modis_final_ba_initialdate_' || anno_inizio;
       chiave_primaria := 'ALTER TABLE nasa_modis_ba.final_ba_' || anno_inizio || ' ADD PRIMARY KEY (id)';
       raise notice '%', chiave_primaria;
       --raise notice '%', nome_indice_corrente;
           EXECUTE chiave_primaria;
   end loop;
end $cazzarola$;