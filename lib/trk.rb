require 'sequel'
require 'trk/html'
DB = Sequel.connect 'postgres:///tracker'

module Trk
  
  extend self

  def outline
    query = "select * from outline"
    DB[query]
  end

end

if __FILE__ == $0
  puts Trk::Html.format(Trk.outline)
end
