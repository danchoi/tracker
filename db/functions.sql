CREATE OR REPLACE FUNCTION remove_task(integer) RETURNS VOID AS $$
BEGIN
  update tasks set position = position - 1
  where parent_id = (select parent_id from tasks where task_id = $1)
    and position > (select position from tasks where task_id = $1);
  update tasks set parent_id = null, position = null where task_id = $1;
  RETURN;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_task(integer, target_parent integer, target_position integer) RETURNS VOID AS $$
BEGIN
  update tasks set position = position + 1 where parent_id = target_parent and position >= target_position;
  /* NOTE. Data integrity will be lost if this is called before removing
  the task from the old place in the three. Can just put an IF
  condition here to check that the inserted task has null parent_id and
  position */
  update tasks set position = target_position, parent_id = target_parent where task_id = $1;
  RETURN;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW outline AS 
  WITH recursive subtasks(title, parent_id, depth, position, path, task_id) as (
    select title, 0, 0, position, array[position], task_id from tasks where parent_id = 0
  union all
    select
      lpad('', (depth+1)*2 , '  ') || t.title, t.parent_id, depth+1, t.position, path || t.position, t.task_id
    from tasks t, subtasks s
    where s.task_id  = t.parent_id
  ) select * from subtasks order by path;

