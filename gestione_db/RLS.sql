SELECT * FROM t_person;

GRANT USAGE ON SCHEMA public TO viewer;

REVOKE USAGE ON SCHEMA public FROM viewer;

GRANT ALL ON t_person TO viewer;

ALTER TABLE t_person ENABLE ROW LEVEL SECURITY;

CREATE POLICY viewer_pol_1
	ON t_person 
	FOR SELECT TO viewer
	USING (gender = 'male');

ALTER POLICY viewer_pol_1
      ON t_person 
      TO viewer
      USING (gender IS null);

CREATE POLICY viewer_pol_2
	ON t_person 
	FOR SELECT TO viewer
	USING (gender = 'female');

CREATE POLICY viewer_pol_3
	ON t_person
	FOR INSERT TO viewer
	WITH CHECK (gender IN('male','female'));


--INSERT INTO t_person(gender,name) VALUES('female','anna') RETURNING *; gender | name 
--------+------
-- female | anna
--INSERT 0 1


--INSERT INTO t_person(gender,name) VALUES('female','gen');
--INSERT 0 1

--INSERT INTO t_person(gender,name) VALUES('female','pen') RETURNING name;
-- name 
------
-- pen


