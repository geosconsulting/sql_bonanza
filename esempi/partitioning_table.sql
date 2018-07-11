CREATE TABLE logs (created_at timestamp without time zone default now(), content text);

CREATE TABLE logs_q1
    (check (created_at >= date '2014-01-01' and created_at <= date '2014-03-31'))
    inherits (logs);

CREATE TABLE logs_q2
    (check (created_at >= date '2014-04-01' and created_at <= date '2014-06-30'))
    inherits (logs);

CREATE TABLE logs_q3
    (check (created_at >= date '2014-07-01' and created_at <= date '2014-09-30'))
    inherits (logs);

CREATE TABLE logs_q4
    (check (created_at >= date '2014-10-01' and created_at <= date '2014-12-31'))
    inherits (logs);

CREATE INDEX logs_q1_created_at on logs_q1 using btree (created_at);
CREATE INDEX logs_q2_created_at on logs_q2 using btree (created_at);
CREATE INDEX logs_q3_created_at on logs_q3 using btree (created_at);
CREATE INDEX logs_q4_created_at on logs_q4 using btree (created_at);

CREATE OR REPLACE FUNCTION on_logs_insert() RETURNS TRIGGER as $$
BEGIN
    if ( new.created_at >= date '2014-01-01' and new.created_at <= date '2014-03-31') then
        insert into logs_q1 values (new.*);
    elsif ( new.created_at >= date '2014-04-01' and new.created_at <= date '2014-06-30') then
        insert into logs_q2 values (new.*);
    elsif ( new.created_at >= date '2014-07-01' and new.created_at <= date '2014-09-30') then
        insert into logs_q3 values (new.*);
    elsif ( new.created_at >= date '2014-10-01' and new.created_at <= date '2014-12-31') then
        insert into logs_q4 values (new.*);
    else
        raise exception 'created_at date out of range';
    end if;

    RETURN null;
end;
$$ language plpgsql;

--Let's attach the trigger function defined above to logs table.

CREATE TRIGGER logs_insert
    BEFORE insert on logs
    for each row execute procedure on_logs_insert();

INSERT INTO logs (created_at, content)
	VALUES (date '2014-02-03', 'Content 1'),
           (date '2014-03-11', 'Content 2'),
           (date '2014-04-13', 'Content 3'),
           (date '2014-07-08', 'Content 4'),
           (date '2014-10-23', 'Content 5');

SELECT * FROM logs_q1;
SELECT * FROM logs_q2;
SELECT * FROM logs_q3;
SELECT * FROM logs_q4;