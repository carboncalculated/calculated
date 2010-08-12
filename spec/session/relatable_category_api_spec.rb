require File.dirname(__FILE__) + '/../spec_helper'

describe "Session" do
  before(:each) do
    @session = Calculated::Session.create(:api_key => "testing_api_key")
  end
  
  describe "#related_objects_from_relatable_categories using material and id 4bf42d8a46a95925b500199a" do
    it "should bring back a hash of related_objects" do
      @session.related_objects_from_relatable_categories("material", ["4bf42d8a46a95925b500199a"]).is_a?(Hash).should be_true
    end
    
    it "should have '4bf42d8b46a95925b50019f6' key" do
      @session.related_objects_from_relatable_categories("material", ["4bf42d8a46a95925b500199a"])["4bf42d8b46a95925b50019f6"].should_not be_nil
    end
    
    it "should raise 412 if there is no relatable_category_ids" do
       lambda{@session.related_objects_from_relatable_categories("material", [])}.should raise_error(Calculated::Session::MissingParameter)
    end
  end
  
  describe "#related_categories_from_relatable_category using 4bf42d8a46a95925b500199a" do
    it "should bring back a hash of related_categories" do
      @session.related_categories_from_relatable_category("4bf42d8a46a95925b500199a", "material_type").is_a?(Hash).should be_true
    end
    
    it "should have '4bf42d8b46a95925b50019c7' key" do
      @session.related_categories_from_relatable_category("4bf42d8a46a95925b500199a", "material_type")["4bf42d8b46a95925b50019c7"].should == "hardboard"
    end
  end
end