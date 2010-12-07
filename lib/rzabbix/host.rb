module RZabbix
  
  class Host
  
    def self.find(hostname)
      perform_request(:get, {
          'filter' => {
            'host' => hostname
          }
        })
    end
    
  end
  
end