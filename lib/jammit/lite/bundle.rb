module Jammit
  
  module Lite
    
    class Bundle
      
      # takes array of files from yaml hash and expands any wilcards
      def self.expand(files)
        files.inject([]) do |expanded,file| 
          wildcard?(file) ? expanded.concat(expand_wildcard_path(file)) : expanded.push(file)
          expanded
        end
      end
      
      # returns true if given path includes "*"
      def self.wildcard?(path)
        not path.match(/\*/).nil?
      end
      
      # expands paths with wildcards into Array of matching filenames
      def self.expand_wildcard_path(path)
        Dir[Rails.root + path].map { |path| path.gsub("#{Rails.root}/",'') }
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