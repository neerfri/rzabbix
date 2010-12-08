module RZabbix
  
  class Template < Base
    
    def self.find_by_name(name)
      templates_hash = perform_request(:template, :get, :filter => {:host=>name}, :output=>"extend")
      if templates_hash.kind_of?(Hash) && !templates_hash.keys.empty?
        template_hash = templates_hash[templates_hash.keys.first]
        self.new(template_hash.rzbx_recursively_symbolize_keys)
      end
    end
    
    def self.default_attributes
      {                           
        :nodeids => nil,
        :groupids => nil,
        :templateids => nil,
        :parentTemplateids => nil,
        :hostids => nil,
        :graphids => nil,
        :itemids => nil,
        :triggerids => nil,
        :with_items => nil,
        :with_triggers => nil,
        :with_graphs => nil,
        :editable => nil,
        :nopermissions => nil
        
#        :filter => nil,
#        :pattern => '',
#        
#        :output => API_OUTPUT_REFER,
#        :extendoutput => nil,
#        :select_groups => nil,
#        :select_hosts => nil,
#        :select_templates => nil,
#        :selectParentTemplates => nil,
#        :select_items => nil,
#        :select_triggers => nil,
#        :select_graphs => nil,
#        :select_applications => nil,
#        :select_macros => nil,
#        :countOutput => nil,
#        :groupCount => nil,
#        :preservekeys => nil,
#        :sortfield => '',
#        :sortorder => '',
#        :limit => nil,
#        :limitSelects => nil
      }
    end
    
  end
  
end