module Jammit
  
  module Lite
    
    # returns hash of bundle file arrays keyed by bundle name
    def self.assets(type)
      hash = asset_hash[type].symbolize_keys
      assets = hash.inject({}) do |out,array|   
        key,paths = array
        out[key] = paths.map { |path| Jammit::Lite::Asset.new(path) }
        out
      end
    end
    
    
    # returns hash from config/assets.yml
    # expands all wildcard paths
    def self.asset_hash
      yaml.each do |key,bundles|
        bundles.each { |name,files| bundles[name] = Jammit::Lite::Bundle.expand(files) }
      end
    end
    
    def self.yaml
      yaml = File.open("#{Rails.root}/config/assets.yml")
      hash = YAML::load(yaml).symbolize_keys
    end
    
  end

end

require 'jammit' unless Rails.env.production?
files = %w(routes bundle asset helper)
files.each { |file| require "#{File.dirname(__FILE__)}/jammit/lite/#{file}"  }

