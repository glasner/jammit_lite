module Jammit
  
  module Lite
    
    module Routes
      
      def self.draw(map)
        Jammit::Routes.draw(map) unless Rails.env.production?
      end

    end
    
  end

  
end