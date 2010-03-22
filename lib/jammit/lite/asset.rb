module Jammit
  module Lite
    class Asset

      attr_accessor :path

      def initialize(path)
        @type = path.split('.').last.to_sym #=> :js
        @path = path.gsub('public','')
      end

    end
  end  
end