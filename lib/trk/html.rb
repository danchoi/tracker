# formats outline stuff into html 

module Trk
  module Html
    
    extend self

  
    def format outline
      outline.to_a.map do |row|
        row.inspect
      end.join("\n")
    end
    
  end
end
