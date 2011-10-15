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
  query = "select * from outline"
  format DB[query]
end

if __FILE__ == $0
  puts show
end

