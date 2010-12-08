module RZabbix
  
end

require 'rzabbix/connection'
require 'rzabbix/base'
require 'rzabbix/host'
require 'rzabbix/host_group'
require 'rzabbix/template'
require 'rzabbix/version'

class Hash
  
  def rzbx_symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end


  def rzbx_recursively_symbolize_keys
    result = self.rzbx_symbolize_keys
    result.keys.each do |key|
      if result[key].is_a?(Hash) || result[key].is_a?(Array)
        result[key] = result[key].rzbx_recursively_symbolize_keys
      end
    end
    result
  end
end

class Array
  def rzbx_recursively_symbolize_keys
    self.map do |item|
      if item.is_a?(Hash) || item.is_a?(Array)
        item.rzbx_recursively_symbolize_keys
      else
        item
      end
    end
  end
end