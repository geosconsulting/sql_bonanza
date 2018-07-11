create table articles (id serial, title varchar, content text);

create table articles_w_tags (tags text[]) inherits (articles);

create table articles_wo_tags () inherits (articles);

insert into articles_wo_tags (title, content)
    values ('Title 1', 'Content 1'),
           ('Title 2', 'Content 2');

insert into articles_w_tags (title, content, tags)
    values ('Title 3', 'Content 3', '{"tag_1", "tag_2"}'::text[]),
           ('Title 4', 'Content 4', '{"tag_2", "tag_3"}'::text[]);

select * from articles_wo_tags;

select * from articles;


create table logs (created_at timestamp without time zone default now(),
                   content text);

create table logs_q1
    (check (created_at >= date '2014-01-01' and created_at <= date '2014-03-31'))
    inherits (logs);

create table logs_q2
    (check (created_at >= date '2014-04-01' and created_at <= date '2014-06-30'))
    inherits (logs);

create table logs_q3
    (check (created_at >= date '2014-07-01' and created_at <= date '2014-09-30'))
    inherits (logs);

create table logs_q4
    (check (created_at >= date '2014-10-01' and created_at <= date '2014-12-31'))
    inherits (logs);


create index logs_q1_created_at on logs_q1 using btree (created_at);
create index logs_q2_created_at on logs_q2 using btree (created_at);
create index logs_q3_created_at on logs_q3 using btree (created_at);
create index logs_q4_created_at on logs_q4 using btree (created_at);

create or replace function on_logs_insert() returns trigger as $$
begin
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

    return null;
end;
$$ language plpgsql;

create trigger logs_insert
    before insert on logs
    for each row execute procedure on_logs_insert();

insert into logs (created_at, content)
    values (date '2014-02-03', 'Content 1'),
           (date '2014-03-11', 'Content 2'),
           (date '2014-04-13', 'Content 3'),
           (date '2014-07-08', 'Content 4'),
           (date '2014-10-23', 'Content 5');

select * from logs_q1;

select * from logs_q2;

select * from logs_q3;

select * from logs_q4;


