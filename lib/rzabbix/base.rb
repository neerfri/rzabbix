module RZabbix
  
  class Base
    
    class << self
      attr_accessor :credentials
      attr_accessor :use_ssl
    end
    
    self.use_ssl = false
    
    def self.set_credentials(api_host, api_user, api_password)
      self.credentials = {:api_host=>api_host, :api_user=>api_user, :api_password=>api_password}
    end
    
    def self.auth
  
      auth_message = {
        'auth' => nil,
        'method' => 'user.authenticate',
        'params' => {
          'user' => credentials[:api_user],
          'password' => credentials[:api_password],
          '0' => '0'
        }
      }
  
      auth_id = do_request(auth_message)
  
      return auth_id
    end
    
    
    def self.perform_request(action, params)
      message = message_for(self.name.downcase, action, params)
      message['id'] = rand 100_000
      message['jsonrpc'] = '2.0'
      message['auth'] = auth()
      
    end
    
    def self.message_for(controller, action, params = {})
      { 
        'method' => "#{controller}.#{action}",
        'params' => params
      }
    end
    
    def do_request(message)
      id = rand 100_000
  
      message['id'] = id
      message['jsonrpc'] = '2.0'
  
      message_json = JSON.generate(message)
  
      uri = URI.parse(@api_url)
      http = Net::HTTP.new(uri.host, uri.port)
  
      if ( uri.scheme == "https" ) then
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
      end
  
      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field('Content-Type', 'application/json-rpc')
      request.body=(message_json)
  
      # TODO сделать проверку невозможности подключения.
      responce = http.request(request)
  
      if ( responce.code != "200" ) then
        raise Zabbix::ResponceCodeError.new("Responce code from [" + @api_url + "] is " + responce.code)
      end
  
      responce_body_hash = JSON.parse(responce.body)
  
      #if not ( responce_body_hash['id'] == id ) then
      # raise Zabbix::InvalidAnswerId.new("Wrong ID in zabbix answer")
      #end
  
  
      # Check errors in zabbix answer. If error exist - raise exception Zabbix::Error
      if ( error = responce_body_hash['error'] ) then
        error_message = error['message']
        error_data = error['data']
        error_code = error['code']
  
        e_message = "Code: [" + error_code.to_s + "]. Message: [" + error_message +\
              "]. Data: [" + error_data + "]."
  
        raise Zabbix::Error.new(e_message)
      end
  
      result = responce_body_hash['result']
  
      return result
    end
  
    def send_request(message)
      message['auth'] = auth()
      do_request(message)
    end
  
    def merge_opt(a, b)
      
      c = {}
  
      b.each_pair do |key, value|
        
        if ( a.has_key?(key) ) then
          c[key] = value
        end
  
      end
  
      return a.merge(c)
    end
    
  end
  
end