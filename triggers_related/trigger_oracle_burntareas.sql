CREATE TRIGGER tg_ba_changes_registry
  AFTER INSERT OR UPDATE OR DELETE
  ON rdaprd.current_burntareaspoly
  FOR EACH ROW
  EXECUTE PROCEDURE effis.fn_register_ba_change();