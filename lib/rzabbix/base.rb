require 'json'
require 'uri'
require 'net/http'
require 'net/https'

module RZabbix
  
  class Base
    
    def self.perform_request(*args)
      Connection.perform_request(*args)
    end
    
    ###########################################################################################################
    # Instance methods
    ###########################################################################################################
    
    attr_accessor :attributes
    
    def initialize(attributes)
      super()
      self.attributes = self.class.default_attributes.merge(attributes)
    end
    
    def [](key)
      self.attributes[key.to_sym]
    end
    
    def to_json(*args)
      self.attributes.to_json(*args)
    end
    
    def to_hash
      self.attributes
    end
  end
  
end