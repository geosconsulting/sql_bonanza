
CREATE schema test;
CREATE TABLE test.part_test (col1 serial, col2 text, col3 timestamptz NOT NULL DEFAULT now());

ALTER TABLE test.part_test ADD primary key(col1);

alter table test.part_test add column col4 date;

alter table test.part_test rename column col1 to id;
alter table test.part_test rename column col2 to descr;
alter table test.part_test rename column col3 to tempo;
alter table test.part_test rename column col4 to data_evento;

insert into test.part_test(descr,data_evento) values('desc 1', '2012-06-20');

insert into test.part_test(descr,data_evento) values('desc 1', '2014-07-20');

insert into test.part_test(descr,data_evento) values('desc 1', '2016-11-20');
insert into test.part_test(descr,data_evento) values('desc 1', '2016-11-21');

alter table test.part_test ALTER column data_evento SET NOT NULL;

DROP EXTENSION pg_partman;

CREATE EXTENSION pg_partman SCHEMA test;

SELECT test.create_parent('test.part_test', 'data_evento', 'partman', 'yearly');