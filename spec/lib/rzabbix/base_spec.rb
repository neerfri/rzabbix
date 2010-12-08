require File.expand_path(File.join(File.dirname(__FILE__), './../../spec_helper.rb'))

include RZabbix

describe Base do
  
  describe "perform_request method" do
    RZabbix::Connection.should_receive(:perform_request).with(:get, {})
    RZabbix::Base.perform_request(:controller, :action, {})
  end
  
end