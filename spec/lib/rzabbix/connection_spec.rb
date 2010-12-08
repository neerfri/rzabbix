require File.expand_path(File.join(File.dirname(__FILE__), './../../spec_helper.rb'))

include RZabbix

describe Connection do
  
  describe "use_ssl accessor" do
    it "should have use_ssl set to false by default" do
      RZabbix::Connection.use_ssl.should == false
    end
  end
  
  describe "set_credentials method" do
    it "should set the value in the class accessor" do
      RZabbix::Connection.set_credentials("host", "user", "pass")
      RZabbix::Connection.credentials.should == {:api_url=>"host", :api_user=>"user", :api_password=>"pass"}
    end
    
  end
  
end