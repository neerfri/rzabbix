module RZabbix
  
  class HostGroup < Base
    
    attr_accessor :attributes
    
    def self.find_by_name(name)
      groups = perform_request(:get, 'filter' => {'name'=>name}, "output"=>"extend")
      self.new(groups.first) unless groups.empty?
    end
    
    def self.resource_name
      "hostgroup"
    end
    
    def default_attributes
      {                           
        :hostid=>nil,             #int	    Host ID	
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
    
  end
  
end