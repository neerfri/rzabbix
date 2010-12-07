require File.expand_path(File.join(File.dirname(__FILE__), './../spec_helper.rb'))

describe RZabbix do
  it "is at version 0.1" do
    RZabbix::VERSION.should == "0.1"
  end
end