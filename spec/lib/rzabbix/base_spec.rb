require File.expand_path(File.join(File.dirname(__FILE__), './../../spec_helper.rb'))

include RZabbix

describe Base do
  
  describe "use_ssl accessor" do
    it "should have use_ssl set to false by default" do
      RZabbix::Base.use_ssl.should == false
    end
  end
  
  describe "set_credentials method" do
    it "should set the value in the class accessor" do
      RZabbix::Base.set_credentials("host", "user", "pass")
      RZabbix::Base.credentials.should == {:api_host=>"host", :api_user=>"user", :api_password=>"pass"}
    end
  end
  
  describe "perform_request method" do
    RZabbix::Base.perform_request(:get, {})
  end
  
end