require 'yaml'
require 'sequel'

DB = Sequel.connect "postgres:///tracker"


data = YAML::load(File.read('db/mock.yml'))
data.each_with_index do |x, i|
  r = DB[:tasks].insert(x)
  puts r
end
