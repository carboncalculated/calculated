require File.dirname(__FILE__) + '/../spec_helper'

describe "Models:ObjectTemplate ID: 4c2c84e1d3a90d1d6f000002" do
  
  before(:each) do
     json = Crack::JSON.parse(File.read(File.join(File.dirname(__FILE__), "..", "carbon_calculated_api", "responses", "object_templates_ipcc_oil_and_gas_operations_related_categories_operations_in_country_type.json")))
     @object_template = Calculated::Models::ObjectTemplate.new(json["object_template"])
   end
   
   it "should have id '4c2c84e1d3a90d1d6f000002'" do
     @object_template.id.should == "4c2c84e1d3a90d1d6f000002"
   end
   
   it "should have name 'ipcc_oil_and_gas_operations'" do
     @object_template.name.should == "ipcc_oil_and_gas_operations"
   end
   
   it "should have characteristics of attribute 'co2_uncertainty_range'" do
     @object_template.characteristics.detect{|c| c.attribute == "co2_uncertainty_range"}.should_not be_nil
   end
   
   it "should have formula_inputs of attribute 'emissions_in_gg_per_1000000m3_gas_production'" do
     @object_template.formula_inputs.detect{|c| c.name == "emissions_in_gg_per_1000000m3_gas_production"}.should_not be_nil
   end
end