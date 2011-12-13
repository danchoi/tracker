# formats outline stuff into html 

module Trk
  module Html
    
    extend self

    def format(outline)
      out = ["<ul>"]
      last_depth = 0
      outline.to_a.each do |row|

        css_class = "task_depth_#{row[:depth]}"

        if row[:depth] > last_depth
          out.pop
          out << indent( %Q|<ul>|, row[:depth])
        elsif row[:depth] < last_depth
          out << indent( %Q|</ul>|, last_depth)
          out << indent( %Q|</li>|, last_depth - 1)
        end

        out << indent( %Q|<li class="#{css_class}" id="task_#{row[:task_id]}">|, row[:depth] )
        out << indent( row.inspect, row[:depth] + 1) 
        out << indent( %Q|</li>|, row[:depth] )

        last_depth = row[:depth]

      end
      out << "</ul>"
      puts out.join("\n")
    end

    def indent(s, indent)
    puts "indent "
      "#{' ' * indent * 4}%s" % s 
    end
    
  end
end

__END__



rlib lib/trk.rb
{:title=>"Task A", :parent_id=>0, :depth=>0, :position=>0, :path=>"{0}", :task_id=>1}
{:title=>"  Task A1", :parent_id=>1, :depth=>1, :position=>0, :path=>"{0,0}", :task_id=>2}
{:title=>"Task B", :parent_id=>0, :depth=>0, :position=>1, :path=>"{1}", :task_id=>4}
{:title=>"  Task A2", :parent_id=>4, :depth=>1, :position=>0, :path=>"{1,0}", :task_id=>3}
{:title=>"Task C", :parent_id=>0, :depth=>0, :position=>2, :path=>"{2}", :task_id=>5}



StackOverflow

Let's say I have a data structure like this:


