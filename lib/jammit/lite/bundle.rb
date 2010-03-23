module Jammit
  
  module Lite
    
    class Bundle
      
      # takes array of files from yaml hash and expands any wilcards
      def self.expand(files)
        files.map! do |file|
          if file.match(/\*/).nil?
            # return single file name
            return file
          else
            # expand wildcard into all matching filenames
            return Dir[Rails.root + file].map { |path| path.gsub("#{Rails.root}/",'') }
          end          
        end
        files.flatten!
      end

      attr_accessor :path

      # takes hash with bundle type as key and bundle name as value
      # eg, Bundle.new(:stylesheets => :cotillion)
      def initialize(args= {})
        @filetype, @name = args.shift
        @path = "/assets/#{@name}.#{extension}"
      end

      def extension
        case @filetype
        when :javascripts : 'js'
        when :stylesheets : 'css'
        end
      end

      # returns Array of Jammit::Lite::Files
      def files
        Jammit::Lite.assets(@filetype)[@name]
      end



    end
    
  end

  
end