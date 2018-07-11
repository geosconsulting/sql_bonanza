CREATE TRIGGER new_ba_inserted
AFTER INSERT
ON egeos.temp_ba
FOR EACH ROW
EXECUTE PROCEDURE egeos.update_ba();