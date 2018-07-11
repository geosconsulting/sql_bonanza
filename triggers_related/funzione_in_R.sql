CREATE TABLE temp (x int, y int);

INSERT INTO temp VALUES(4,6);
INSERT INTO temp VALUES(8,3);
INSERT INTO temp VALUES(4,7);
INSERT INTO temp VALUES(1,5);
INSERT INTO temp VALUES(7,8);
INSERT INTO temp VALUES(2,3);
INSERT INTO temp VALUES(5,1);
INSERT INTO temp VALUES(9,4);

DROP FUNCTION f_graph();
CREATE OR REPLACE FUNCTION f_graph() RETURNS text AS
	'
	str <<- pg.spi.exec (''select x as "my a" ,y as "my b" from temp order by x,y'');
	pdf(''/home/jrc/Document/pg_out/myplot.pdf'');
	plot(str,type="l",main="Graphics Demonstration",sub="Line Graph");
	dev.off();
	print(''done'');
	'
LANGUAGE plr;
SELECT f_graph(); 

create table foo(f0 int, f1 text, f2 float8);
insert into foo values(1,'cat1',1.21);
insert into foo values(2,'cat1',1.24);
insert into foo values(3,'cat1',1.18);
insert into foo values(4,'cat1',1.26);
insert into foo values(5,'cat1',1.15);
insert into foo values(6,'cat2',1.15);
insert into foo values(7,'cat2',1.26);
insert into foo values(8,'cat2',1.32);
insert into foo values(9,'cat2',1.30);

CREATE OR REPLACE FUNCTION r_median(_float8) 
	RETURNS float AS 'median(arg1)' 
language 'plr';

CREATE AGGREGATE median (
  sfunc = plr_array_accum,
  basetype = float8,
  stype = _float8,
  finalfunc = r_median
);

SELECT f1, median(f2) FROM foo GROUP BY f1 ORDER BY f1;



