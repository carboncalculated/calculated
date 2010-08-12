require File.dirname(__FILE__) + '/../spec_helper'

describe "Session" do
  describe "when creating, .create" do
    it "should be cool when supplying an api key" do
      Calculated::Session.create(:api_key => "123")
    end
    
    it "should have the defaults" do
      session = Calculated::Session.create(:api_key => "123")
      session.server.should == "api.carboncalculated.com"
      session.api_version.should == "v1"
      session.logging.should be_true
      session.caching.should be_true
    end
    
    it "should allow defaults to be changed when creating" do
      session = Calculated::Session.create(:api_key => "123", :api_version => "v2", :logging => false, :server => "beans")
      session.server.should == "beans"
      session.logging.should be_false
      session.api_version.should == "v2"
    end
    
    it "should raise Argument error if no api key is supplied; with message 'need API to save the planet!'" do
      lambda{Calculated::Session.create}.should raise_error(ArgumentError)
    end
  end
end