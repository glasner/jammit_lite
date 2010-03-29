module Jammit
  
  module Lite
    
    # returns hash of bundle file arrays keyed by bundle name
    def self.assets(type)
      hash = asset_hash(type)
      hash_to_assets(hash)
    end
    
    # typecasts paths in given Hash into Assets
    def self.hash_to_assets(hash)
      hash.inject({}) do |out,array|   
        key,paths = array
        out[key] = paths.map { |path| Jammit::Lite::Asset.new(path) }
        out
      end
    end    
    
    # returns hash from yaml with given type, e.g. :javascripts
    # expands all wildcard paths
    def self.asset_hash(type)
      yaml[type].symbolize_keys.inject({}) do |out,pair|
        bundle,files = pair
        out[bundle] = Jammit::Lite::Bundle.expand(files)
        out
      end
    end
    
    # returns hash from config/assets.yml
    def self.yaml
      yaml = File.open("#{Rails.root}/config/assets.yml")
      YAML::load(yaml).symbolize_keys
    end
    
  end

end

require 'jammit' unless Rails.env.production?
files = %w(routes bundle asset helper)
files.each { |file| require "#{File.dirname(__FILE__)}/jammit/lite/#{file}"  }

