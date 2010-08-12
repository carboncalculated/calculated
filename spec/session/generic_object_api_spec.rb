require File.dirname(__FILE__) + '/../spec_helper'

describe "Session" do
  before(:each) do
    @session = Calculated::Session.create(:api_key => "testing_api_key")
  end
  
  describe "#generic_objects" do
        
    it "should be cool to get some generic objects" do
      @session.generic_objects.size.should == 50
    end
    
    it "each array object should be a GenericObject" do
      @session.generic_objects.each{|generic_object| generic_object.is_a?(Calculated::Models::GenericObject)}
    end
    
    it "should be cool to set the page size lets say 5" do
      @session.generic_objects(:per_page => 5).size.should == 5
    end
  end
  
  describe "#generic_object/4c370c11ae2b7b418e00232c" do
    it "should find a generic object with an id '4c370c11ae2b7b418e00232c'" do
      @generic_object = @session.generic_object("4c370c11ae2b7b418e00232c")
    end
    
    it "should raise Calculated::Session::NotFound when a 404 is returned" do
      lambda{@session.generic_object("4c370c11ae2b7b418e00232c34543345")}.should raise_error(Calculated::Session::NotFound)
    end
  end
  
  describe "#generic_object/4c370c11ae2b7b418e00232c/formula_inputs" do
    it "should find a formula inputs for object with an id '4c370c11ae2b7b418e00232c'" do
      lambda{@session.formula_inputs_for_generic_object("4c370c11ae2b7b418e00232c")}.should_not raise_error(Calculated::Session::NotFound)
    end
    
    it "should have formula_input objects elements in the array" do
      @formula_inputs = @session.formula_inputs_for_generic_object("4c370c11ae2b7b418e00232c")
      @formula_inputs.each{|f| f.is_a?(Calculated::Models::FormulaInput)}
    end
    
    it "should raise Calculated::Session::NotFound when a 404 is returned" do
      lambda{@session.generic_object("4c370c11ae2b7b418e00232c34543345")}.should raise_error(Calculated::Session::NotFound)
    end
  end
end