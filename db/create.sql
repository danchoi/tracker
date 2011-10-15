drop table if exists tasks CASCADE;
create table tasks (
  task_id serial primary key,
  title varchar,
  notes text,
  context varchar,
  priority varchar, /* maybe change to enum */
  parent_id integer, /* null means that the node is floating */
  position integer, /* null means that the node is floating */
  created_at timestamp default now(),
  due_at timestamp, /* add this */
  completed_at timestamp
);

alter table tasks add constraint task_parent_position_uniq_key UNIQUE (parent_id, position);

\i db/functions.sql
