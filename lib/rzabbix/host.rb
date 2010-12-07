module RZabbix
  
  class Host < Base
    
    attr_accessor :attributes
                                        
    # attr_accessor :hostid           
    # attr_accessor :host             
    # attr_accessor :port             
    # attr_accessor :status           
    # attr_accessor :useip            
    # attr_accessor :dns              
    # attr_accessor :ip               
    # attr_accessor :proxy_hostid     
    # attr_accessor :useipmi          
    # attr_accessor :ipmi_ip          
    # attr_accessor :ipmi_port        
    # attr_accessor :ipmi_authtype    
    # attr_accessor :ipmi_privilege   
    # attr_accessor :ipmi_username    
    # attr_accessor :ipmi_password	  
  
  
    def self.find_host_id_by_hostname(hostname)
      hosts = perform_request(:get, 'filter' => {'host'=>hostname})
      hosts.first["hostid"]
    end
    
    def self.find_by_hostname(hostname)
      #host_id = find_host_id_by_hostname(hostname)
      hosts = perform_request(:get, 'filter' => {'host'=>hostname}, "output"=>"extend")
      self.new(hosts.first) unless hosts.empty?
    end
    
    def self.create(attributes)
      groups = attributes.delete(:groups)
      hosts = perform_request(:create, "host data"=>attributes, "groups"=>groups)
      self.new(attributes)
    end
    
    def self.resource_name
      "host"
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