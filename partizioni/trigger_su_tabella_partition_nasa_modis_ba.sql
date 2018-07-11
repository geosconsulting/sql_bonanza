CREATE TRIGGER final_ba_insert
BEFORE INSERT
ON nasa_modis_ba.final_ba
FOR EACH ROW
EXECUTE PROCEDURE nasa_modis_ba.on_ba_insert();