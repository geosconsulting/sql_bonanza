-- Trigger: new_ca_inserted_calculate_adm2 on effis.current_burntareaspoly

-- DROP TRIGGER new_ca_inserted_calculate_adm2 ON effis.current_burntareaspoly;

CREATE TRIGGER new_ca_inserted_calculate_adm2
  AFTER INSERT
  ON effis.current_burntareaspoly
  FOR EACH ROW
  EXECUTE PROCEDURE mm.log_admin2_intersect();

-- Trigger: new_ca_inserted_calculate_adm3 on effis.current_burntareaspoly

-- DROP TRIGGER new_ca_inserted_calculate_adm3 ON effis.current_burntareaspoly;

CREATE TRIGGER new_ca_inserted_calculate_adm3
  AFTER INSERT
  ON effis.current_burntareaspoly
  FOR EACH ROW
  EXECUTE PROCEDURE mm.log_admin3_intersect();

-- Trigger: tg_ba_changes_registry on effis.current_burntareaspoly

-- DROP TRIGGER tg_ba_changes_registry ON effis.current_burntareaspoly;

CREATE TRIGGER tg_ba_changes_registry
  AFTER INSERT OR UPDATE OR DELETE
  ON effis.current_burntareaspoly
  FOR EACH ROW
  EXECUTE PROCEDURE effis.fn_register_ba_change();

