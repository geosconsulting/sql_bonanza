************************* chiavi esterne livello 1
ALTER TABLE public. admin_level_1 ADD CONSTRAINT admin1_id_fk_admin0_id FOREIGN KEY (country_id)
      REFERENCES admin_level_0 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED

************************* chiavi esterne livello 2
ALTER TABLE public. admin_level_2 ADD CONSTRAINT admin2_id_fk_admin0_id FOREIGN KEY (country_id)
      REFERENCES admin_level_0 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED
	  
ALTER TABLE public. admin_level_2  ADD CONSTRAINT admin2_id_fk_admin1_id FOREIGN KEY (admin1_id)
      REFERENCES admin_level_1 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED	  	  

************************* chiavi esterne livello 3
ALTER TABLE public. admin_level_3  ADD CONSTRAINT admin3_id_fk_admin0_id FOREIGN KEY (country_id)
      REFERENCES admin_level_0 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED
	  
ALTER TABLE public. admin_level_3  ADD CONSTRAINT admin3_id_fk_admin1_id FOREIGN KEY (admin1_id)
      REFERENCES admin_level_1 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED

ALTER TABLE public. admin_level_3  ADD CONSTRAINT admin3_id_fk_admin2_id FOREIGN KEY (admin2_id)
      REFERENCES admin_level_2 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED

************************* chiavi esterne livello 4
ALTER TABLE public. admin_level_4 ADD CONSTRAINT admin4_id_fk_admin0_id FOREIGN KEY (country_id)
      REFERENCES admin_level_0 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED
	  
ALTER TABLE public. admin_level_4 ADD CONSTRAINT admin4_id_fk_admin1_id FOREIGN KEY (admin1_id)
      REFERENCES admin_level_1 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED

ALTER TABLE public. admin_level_4 ADD CONSTRAINT admin4_id_fk_admin2_id FOREIGN KEY (admin2_id)
      REFERENCES admin_level_2 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED

ALTER TABLE public. admin_level_4 ADD CONSTRAINT admin4_id_fk_admin3_id FOREIGN KEY (admin3_id)
      REFERENCES admin_level_3 (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED
 

