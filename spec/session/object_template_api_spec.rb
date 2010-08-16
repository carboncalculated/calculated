require File.dirname(__FILE__) + '/../spec_helper'

describe "Session" do
  before(:each) do
    @session = Calculated::Session.create(:api_key => "testing_api_key")
  end
  
  describe "#object_templates with :id" do
    before(:each) do
      @result = @session.object_template("4c205ac5d3aea93ba9000003")
    end
    
    it "should find the object_template with name 'car'" do
      @result.is_a?(Calculated::Models::ObjectTemplate)
      @result.name.should == "car"
      @result.characteristics.should_not be_empty
    end
  end
  
  describe "#object_templates" do
    it "should create object template objects array with successful request" do
      @session.object_templates.each{|a| a.is_a?(Calculated::Models::ObjectTemplate).should be_true}
    end
    
    it "should get 18 object template as that is how many there is" do
      @session.object_templates.size.should == 18
    end
  end
  
  describe "#generic_object_for_object_template with name 'ipcc_oil_and_gas_operations'" do
    it "should not only get object template but an array of generic objects paginated" do
      result = @session.generic_objects_for_object_template("ipcc_oil_and_gas_operations")
      result.is_a?(Calculated::Models::ObjectTemplate).should be_true
      result.generic_objects.should_not be_nil
      result.generic_objects.each{|g| g.is_a?(Calculated::Models::GenericObject).should be_true}
    end
    
    it "should get 50 generic_objects as that is the max page size" do
      @session.generic_objects_for_object_template("ipcc_oil_and_gas_operations").generic_objects.size.should == 50
    end
  end
  
  describe "#relatable_categories_for_object_template with name 'ipcc_oil_and_gas_operations' and related attribute 'operations_in_country_type'" do
    it "should not only get object template but an array of relatable categories" do
      result = @session.relatable_categories_for_object_template("ipcc_oil_and_gas_operations", "operations_in_country_type")
      result.is_a?(Calculated::Models::ObjectTemplate).should be_true
      result.relatable_categories.should_not be_nil
      result.relatable_categories.each{|g| g.is_a?(Calculated::Models::RelatableCategory).should be_true}
    end
    
    it "should get a relatable category with id 4c349f6468fe543496017e31" do
      result = @session.relatable_categories_for_object_template("ipcc_oil_and_gas_operations", "operations_in_country_type")
      r = result.relatable_categories.detect{|r| r.id == "4c349f6468fe543496017e31"}
      r.should_not be_nil
      r.related_categories["emission_source"].should_not be_nil
      r.related_categories["emission_source"]["4c349f6068fe5434960178c2"].should_not be_nil
    end
  end
  
  describe "#generic_objects_for_object_template_with_filter with name 'airport' and filter 'london'" do
    it "should not only get object template but an array of generic_objects" do
      result = @session.generic_objects_for_object_template_with_filter("airport", "london")
      result.is_a?(Calculated::Models::ObjectTemplate).should be_true
      result.generic_objects.should_not be_nil
      result.generic_objects.each{|g| g.is_a?(Calculated::Models::GenericObject).should be_true}
    end
  end
end