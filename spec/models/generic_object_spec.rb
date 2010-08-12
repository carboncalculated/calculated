require File.dirname(__FILE__) + '/../spec_helper'

describe "Models:GenericObject ID:4c370c11ae2b7b418e00232c" do
  before(:each) do
    json = Crack::JSON.parse(File.read(File.join(File.dirname(__FILE__), "..", "carbon_calculated_api", "responses", "generic_object_4c370c11ae2b7b418e00232c.json")))
    @generic_object = Calculated::Models::GenericObject.new(json["generic_object"])
  end
  
  it "should have identifier 'VAUXHALL - Vectra, MY 2003 - 2.2 16v SXi 5 door Hatchback From VIN: W0L0ZCF6838000000 - 2198cc - M5 - Petrol - 2003 - May onwards'" do
    @generic_object.identifier.should == "VAUXHALL - Vectra, MY 2003 - 2.2 16v SXi 5 door Hatchback From VIN: W0L0ZCF6838000000 - 2198cc - M5 - Petrol - 2003 - May onwards"
  end
  
  it "should have template_name 'car'" do
    @generic_object.template_name == "car"
  end
  
  it "should have an array of characteristics" do
    @generic_object.characteristics.is_a?(Array).should be_true
  end
    
  it "should have a description characteristic" do
    @generic_object.characteristics.detect{|ch| ch.attribute == "description"}.should_not be_nil
  end
  
  it "should have a manufacturer characteristics" do
    @generic_object.characteristics.detect{|ch| ch.attribute == "manufacturer"}.should_not be_nil
  end
  
  it "should have a value of VAUXHALL for the manufacturer characteristics" do
    @generic_object.characteristics.detect{|ch| ch.attribute == "manufacturer"}.value.should == "VAUXHALL"
  end
  
  it "should have an array of formula_inputs" do
    @generic_object.formula_inputs.is_a?(Array).should be_true
  end
  
  it "should have a formula input with the name emissions_in_grams_per_km" do
    @generic_object.formula_inputs.detect{|f| f.name == "emissions_in_grams_per_km"}.should_not be_nil
  end
  
end