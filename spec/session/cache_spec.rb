require File.dirname(__FILE__) + '/../spec_helper'

describe "Session caching on" do
  before(:each) do
    @session = Calculated::Session.create(:api_key => "testing_api_key")
  end
  
  describe "Cache" do
    before(:each) do
      @service = @session.service
      response = Crack::JSON.parse(File.read(File.join(File.dirname(__FILE__), "..", "carbon_calculated_api", "responses", "generic_objects.json")))
      @service.stub!(:get => response)
    end
    
    it "should create the cache key from the request" do
      @session.generic_objects(:page => 50)
      @session.cache.should_not be_empty
      @session.cache.keys.should include("/generic_objects/page=50")  
    end
    
    it "should call get only the once" do
      @service.should_receive(:get).once
      @session.generic_objects(:page => 50)
      @session.generic_objects(:page => 50)
    end
    
    it "should give exactly the same response as the first request" do
      response1 = @session.generic_objects(:page => 50)
      response2 = @session.cache["/generic_objects/page=50"]
      response1.should == response2
      response2.should == @session.generic_objects(:page => 50)
    end
  end
end


describe "Session caching off" do
  before(:each) do
    @session = Calculated::Session.create(:api_key => "testing_api_key", :caching => false)
  end
  
  describe "Cache" do
    before(:each) do
      @service = @session.service
      response = Crack::JSON.parse(File.read(File.join(File.dirname(__FILE__), "..", "carbon_calculated_api", "responses", "generic_objects.json")))
      @service.stub!(:get => response)
    end
    
    it "should not create the cache key from the request" do
      @session.generic_objects(:page => 50)
      @session.cache.should be_nil
    end
    
    it "should always be calling get" do
      @service.should_receive(:get).twice
      @session.generic_objects(:page => 50)
      @session.generic_objects(:page => 50)
    end
  end
end

describe "Session expiration" do
  before(:each) do
    @session = Calculated::Session.create(:api_key => "testing_api_key", :expires_in => 1)
  end
  
  describe "Cache" do
    before(:each) do
      @service = @session.service
      response = Crack::JSON.parse(File.read(File.join(File.dirname(__FILE__), "..", "carbon_calculated_api", "responses", "generic_objects.json")))
      @service.stub!(:get => response)
    end
    
    it "should create the cache" do
      @session.generic_objects(:page => 50)
      @session.cache.should_not be_empty
    end
    
    it "should expire when the time as gone passed expiration" do
      @session.generic_objects(:page => 50)
      @time_now = Time.parse("Feb 24 2100")
      Time.stub!(:now).and_return(@time_now)
      @session.cache["/generic_objects/page=50"].should be_nil
    end
  end
end