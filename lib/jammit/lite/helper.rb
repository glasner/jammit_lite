module Jammit
  
  module Lite
    
    module Helper
      
      #= Javascript Helpers
      
      # creates <script> tags for Jammit js bundles 
      # in development, creates <script> tag for each individual file in bundles
      # in production, creates <script> tag for each bundle
      def include_javascripts(*bundles)
        bundles.map! { |name| Jammit::Lite::Bundle.new(:javascripts => name)  }
        return include_individual_javascripts(bundles) unless Rails.env.production?    
        tags = bundles.map { |bundle| javascript_include_tag(bundle.path) }
        tags.join("\n")
      end

      # creates <script> tags for Jammit templates
      def include_templates(*bundles)
        tags = bundles.map { |bundle| javascript_include_tag("/assets/#{bundle}.jst")  }
        tags.join("\n")
      end
      
      private
      
      # creates <script> tags for each individual file in given Array of bundles
      def include_individual_javascripts(bundles=[])
        tags = []
        bundles.each do |bundle|      
          tags.concat bundle.files.map { |js| javascript_include_tag(js.path) }
        end
        tags.join("\n")
      end
      
      public
      
      #= Stylesheet Helpers
      
      # creates <link> tags for Jammit css bundles
      # in development, creates <link> tag for each individual file in bundles
      # in production, creates <link> tag for each bundle
      def include_stylesheets(*bundles)        
        bundles.map! { |name| Jammit::Lite::Bundle.new(:stylesheets => name)  }
        return include_individual_stylesheets(bundles) unless Rails.env.production?    
        tags = bundles.map { |bundle| stylesheet_link_tag(bundle.path) }
        tags.join("\n")
      end

      private
      
      
      
      # creates <script> tags for each individual file in given Array of bundles
      def include_individual_stylesheets(bundles=[])
        tags = []
        bundles.each do |bundle|      
          tags.concat bundle.files.map { |css| stylesheet_link_tag(css.path)  }
        end
        tags.join("\n")
      end

      # returns hash for stylesheet link tag attributes for given file
      def attributes_for_stylesheet_link(file)
        {:href => file.path, :media => 'screen', :rel => 'stylesheet', :type => 'text/css'}
      end
      
      

    end
    
  end
  

  
end

# Include the Jammit asset helpers in all views, a-la ApplicationHelper.
::ActionView::Base.send(:include, Jammit::Lite::Helper)