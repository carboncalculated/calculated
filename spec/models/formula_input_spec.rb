require File.dirname(__FILE__) + '/../spec_helper'

describe "Models:FormulaInput" do
  before(:each) do
    json = Crack::JSON.parse(File.read(File.join(File.dirname(__FILE__), "..", "carbon_calculated_api", "responses", "generic_object_4c370c11ae2b7b418e00232c.json")))
    @generic_object = Calculated::Models::GenericObject.new(json["generic_object"])
    @formula_input = @generic_object.formula_inputs.first
  end
  
  it "should have a values hash" do
    @formula_input.values.should == {"co2" => 206,"co"=>0.504,"hc_and_nox"=>0.05,"hc"=>0.022,"nox"=>0,"particulates"=>0}
  end
  
  it "should have an active_at" do
    @formula_input.active_at.should == Time.parse("2010-07-09T11:46:25Z")
  end
end