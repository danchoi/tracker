require 'sequel'

DB = Sequel.connect 'postgres:///tracker'

FIELDS = { 
  title: "%-72s",
  parent_id: "%9s",
  depth: "%6s",
  position: "%9s",
  path: "%-30s",
  task_id: "%9s",
}

def format(result_set)
  template = FIELDS.values.join(" | ")
  header = template % FIELDS.keys
  divider_line = header.gsub(/\|/, "+").gsub(/[^+]/, '-')
  output = result_set.inject([header, divider_line]) do |memo, row|
    vals = row.keys.inject([]) {|s, key| 
      val = row[key]
      colwidth = FIELDS[key][/\d+/,0].to_i - 1
      s << val.to_s[0, colwidth]
    }
    line = template % vals
    memo << line
  end
  output.map {|line| "  #{line}" }.join("\n")
end

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
  format DB[query]
end

if __FILE__ == $0

  puts show
end

