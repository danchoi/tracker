require 'sequel'

DB = Sequel.connect 'postgres:///tracker'
def show
  query = <<SQL
with recursive subtasks(title, parent_id, depth, position, path, task_id) as (
  select title, parent_id, 0, position, array[position], task_id from tasks where parent_id is null
union all
  select
    lpad('', (depth+1)*2 , '  ') || t.title, t.parent_id, depth+1, t.position, path || t.position, t.task_id
  from tasks t, subtasks s
  where s.task_id  = t.parent_id
) select * from subtasks order by path;
SQL
  DB[query].to_a
end

if __FILE__ == $0

  puts show
end

