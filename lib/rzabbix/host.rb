module RZabbix
  
  class Host < Base
    
    def self.find(host_id)
      hosts = perform_request(:host, :get, :hostids=>[host_id], :output=>"extend")
      self.new(hosts.first.rzbx_recursively_symbolize_keys) unless hosts.empty?
    end
  
    def self.find_host_id_by_hostname(hostname)
      hosts = perform_request(:host, :get, :filter => {:host=>hostname})
      hosts.first[:hostid]
    end
    
    def self.find_by_hostname(hostname)
      hosts = perform_request(:host, :get, :filter => {:host=>hostname}, :output=>"extend")
      self.new(hosts.first) unless hosts.empty?
    end
    
    def self.create(attributes)
      host = self.new(attributes)
      result = perform_request(:host, :create, host)
      result && result[:hostids] ? self.find(result[:hostids].first) : nil
    end
    
    def self.default_attributes
      {
        #:hostid=>nil,             #int	    Host ID	
        :host=>nil,               #string	  Host name.
        :port=>10050,             #int	    Port number.	
        :status=>0,               #int	    Host Status.	
        :useip=>0,                #int	    Use IP.	
        :dns=>'',                 #string	  DNS.	
        :ip=>'0.0.0.0',           #string	  IP.	
        :proxy_hostid=> 0,        #int	    Proxy Host ID.	
        :useipmi=> 0 ,            #int	    Use IPMI.	
        :ipmi_ip=>'',             #string	  IPMAI IP.	
        :ipmi_port=>623,          #int	    IPMI port.	
        :ipmi_authtype=>0,        #int	    IPMI authentication type.	
        :ipmi_privilege=>0,       #int	    IPMI privilege.	
        :ipmi_username=>'',      #string	  IPMI username.	
        :ipmi_password=>''       #string	  IPMI password.
      }
    end
    
    def to_hash(*args)
      host_hash = self.attributes.inject({}) do |hash, (attr, v)|
        case attr.to_sym
          when :groups
            hash[:groups] = v.map {|g| { :groupid=>g.attributes[:groupid]}}
          when :templates
            hash[:templates] = v.map {|t| {:templateid=>t.attributes[:templateid]}}
          else
            hash[attr] = v
        end
        hash
      end
      host_hash
    end
    
  end
  
end