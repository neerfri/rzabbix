module RZabbix
  
  class HostGroup < Base
    
    def self.find_by_name(name)
      groups = perform_request(:hostgroup, :get, :filter => {:name=>name}, :output=>"extend")
      self.new(groups.first.rzbx_recursively_symbolize_keys) unless groups.empty?
    end
    
    def self.default_attributes
      {                      
        :nodeids => nil,
        :groupids => nil,
        :hostids => nil,
        :templateids => nil,
        :graphids => nil,
        :triggerids => nil,
        :maintenanceids => nil,
        :monitored_hosts => nil,
        :templated_hosts => nil,
        :real_hosts => nil,
        :not_proxy_hosts => nil,
        :with_items => nil,
        :with_monitored_items => nil,
        :with_historical_items => nil,
        :with_triggers => nil,
        :with_monitored_triggers => nil,
        :with_httptests => nil,
        :with_monitored_httptests => nil,
        :with_graphs => nil,
        :editable => nil,
        :nopermissions => nil
        
#        :filter => nil,
#        :pattern => '',
#        
#        :output => Connection::API_OUTPUT_REFER,
#        :extendoutput => nil,
#        :select_hosts => nil,
#        :select_templates => nil,
#        :count => nil,
#        :preservekeys => nil,
#        :sortfield => '',
#        :sortorder => '',
#        :limit => nil,
#        :limitSelects => nil
      }
    end
    
    def to_json(*args)
      self.attributes.to_json(*args)
    end
    
  end
  
end