create table tasks (
  task_id serial primary key,
  title varchar,
  notes text,
  context varchar,
  priority varchar, /* maybe change to enum */
  parent_id integer, /* add foreign key constraint; use for recursive queries */
  position integer,
  created_at timestamp default now(),
  due_at timestamp, /* add this */
  completed_at timestamp
);
