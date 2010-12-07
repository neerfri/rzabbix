require 'rubygems'
require 'lib/rzabbix'

RZabbix::Base.set_credentials("http://zabbix.applicaster.com/api_jsonrpc.php", "api_user", "api_pass")

def find_or_create_group(name)
  RZabbix::HostGroup.find_by_name(name)
end

def find_or_create_host(hostname)
  host = RZabbix::Host.find_by_hostname(hostname)
  if !host
    puts "Creating new Host"
    host = RZabbix::Host.create(:host=>hostname, :groups=>[RZabbix::HostGroup.find_by_name("Application servers")])
  end
end

find_or_create_host("my-new-host-f394ec9e.us-east-1a.applicaster.com")