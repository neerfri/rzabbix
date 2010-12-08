require 'rubygems'
require 'lib/rzabbix'

RZabbix::Connection.set_credentials("http://zabbix.applicaster.com/api_jsonrpc.php", "api_user", "api_pass")

def find_or_create_group(name)
  RZabbix::HostGroup.find_by_name(name)
end

def find_or_create_host(hostname, groups, templates)
  host = RZabbix::Host.find_by_hostname(hostname)
  if !host
    puts "Creating new Host"
    host = RZabbix::Host.create(:host=>hostname, :dns=>hostname, :groups=>groups, :templates=>templates)
  end
  host
end

groups = ["Application servers"].map {|name| RZabbix::HostGroup.find_by_name(name) || raise("group '#{name} not found") }
#puts "\n\nFound #{groups.size} groups:\n" + groups.map {|g| g.inspect}.join($/)

#templates = ["Template_Applicaster_Passenger"].map {|name| RZabbix::Template.find_by_name(name)  || raise("template '#{name} not found") }
templates = []

host = find_or_create_host("my-new-host-f394ec9e.us-east-1a.applicaster.com", groups, templates)
puts "Host: #{host.attributes[:host].inspect}"