GRANT ALL ON t_person TO viewer;

SELECT * FROM aclexplode('{viewer=arwdDxt/postgres}');

DROP ROLE viewer;

REASSIGN OWNED BY viewer TO postgres;

DROP ROLE viewer;

