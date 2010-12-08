module RZabbix
  
  class Connection
    
    API_OUTPUT_SHORTEN = "shorten"
    API_OUTPUT_REFER   = "refer"
    API_OUTPUT_EXTEND  = "extend"
    
    class ResponseCodeError < StandardError; end
    
    class << self
      attr_accessor :credentials
      attr_accessor :use_ssl
      attr_accessor :auth
    end
    
    self.use_ssl = false
    
    def self.set_credentials(api_url, api_user, api_password)
      self.credentials = {:api_url=>api_url, :api_user=>api_user, :api_password=>api_password}
    end
    
    def self.next_request_id
      @request_id = @request_id ? @request_id+1 : 1
    end
    
    def self.auth
      @auth ||= begin
        auth_message = {
          'auth' => nil,
          'method' => 'user.authenticate',
          'params' => {
            'user' => Connection.credentials[:api_user],
            'password' => Connection.credentials[:api_password],
            '0' => '0'
          }
        }
        do_request(auth_message)
      end
    end
    
    
    def self.perform_request(controller, action, params)
      message = message_for(controller, action, params)
      do_request(message)
    end
    
    def self.message_for(controller, action, params = {})
      { 
        'method' => "#{controller}.#{action}",
        'params' => params.to_hash.merge(:output=>API_OUTPUT_EXTEND),
        'auth' => Connection.auth
      }
    end
    
    def self.do_request(message)
      id = next_request_id
  
      message['id'] = id
      message['jsonrpc'] = '2.0'
  
      message_json = JSON.generate(message)
      
      #puts "#{JSON.parse(message_json).inspect}\n\n\n"
      
      uri = URI.parse(Connection.credentials[:api_url])
      http = Net::HTTP.new(uri.host, uri.port)
      if (use_ssl)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
      end
      
      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field('Content-Type', 'application/json-rpc')
      request.body=(message_json)
      responce = http.request(request)
      
      if ( responce.code != "200" ) then
        raise ResponseCodeError.new("Responce code from [" + credentials[:api_url] + "] is " + responce.code)
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
  
        raise StandardError.new(e_message)
      end
      
      result = responce_body_hash['result'] 
      result.respond_to?(:rzbx_recursively_symbolize_keys) ? result.rzbx_recursively_symbolize_keys : result
    end
  
    
  end
  
end