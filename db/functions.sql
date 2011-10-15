
CREATE OR REPLACE FUNCTION remove_task(integer) RETURNS VOID AS $$
BEGIN
  update tasks set position = position - 1
  where parent_id = (select parent_id from tasks where task_id = $1)
    and position > (select position from tasks where task_id = $1);
  update tasks set parent_id = null, position = null where task_id = $1;
  RETURN;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_task(integer, integer, integer) RETURNS VOID AS $$
DECLARE
  target_parent ALIAS FOR $2;
  target_position ALIAS FOR $3;
BEGIN
  update tasks set position = position + 1
    where parent_id = target_parent and position >= target_position;
  update tasks set position = target_position, parent_id = target_parent
    where task_id = $1;
  RETURN;
END $$ LANGUAGE plpgsql;



