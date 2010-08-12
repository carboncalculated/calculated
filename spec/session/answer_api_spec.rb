require File.dirname(__FILE__) + '/../spec_helper'

describe "Session" do
  before(:each) do
    @session = Calculated::Session.create(:api_key => "testing_api_key")
  end
  
  describe "#answer_for_calculator (material)" do
    it "should create a answer object" do
      params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
      answer = @session.answer_for_calculator("4bab7e4ff78b122cdd000004", params)
      answer.should be_valid
    end
    
    it "should create a answer object with calculation" do
      params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
      answer = @session.answer_for_calculator("4bab7e4ff78b122cdd000004", params)
      answer.calculations["co2"]["value"] == 10
      answer.calculations["co2"]["units"] == "kg"
    end
    
    it "should have a source" do
      params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
      answer = @session.answer_for_calculator("4bab7e4ff78b122cdd000004", params)
      answer.source.should_not be_nil
      answer.source.main_source_ids = [
          "4bebe984dfde7b477d000002",
          "4bebe9e5dfde7b477d000004",
          "4bebea10dfde7b477d000006"]
    end
    
    it "should have a computation_id of '4bab7e64f78b122cdd000005'" do
      params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
      answer = @session.answer_for_calculator("4bab7e4ff78b122cdd000004", params)
      answer.computation_id.should == "4bab7e64f78b122cdd000005"
      answer.calculator_id.should == "4bab7e4ff78b122cdd000004"
      answer.answer_set_id.should == "4bd5cb3bdfde7b125600374f"
    end
    
    it "should not be valid with there is no params of the amount_of material" do
      params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a","formula_input_name"=>"emissions_by_kg"}
      answer = @session.answer_for_calculator("4bab7e4ff78b122cdd000004", params)
      answer.should_not be_valid
      answer.errors.should_not be_nil
      answer.errors["amount_of_material"].should_not be_nil
    end
    
    
    describe "#answer_for_computation (material)" do
      it "should create a answer object" do
        params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
        answer = @session.answer_for_computation("4bab7e64f78b122cdd000005", params)
        answer.should be_valid
      end

      it "should create a answer object with calculation" do
        params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
        answer = @session.answer_for_computation("4bab7e64f78b122cdd000005", params)
        answer.calculations["co2"]["value"] == 10
        answer.calculations["co2"]["units"] == "kg"
      end

      it "should have a source" do
        params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
        answer = @session.answer_for_computation("4bab7e64f78b122cdd000005", params)
        answer.source.should_not be_nil
        answer.source.main_source_ids = [
            "4bebe984dfde7b477d000002",
            "4bebe9e5dfde7b477d000004",
            "4bebea10dfde7b477d000006"]
      end

      it "should have a computation_id of '4bab7e64f78b122cdd000005'" do
        params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"}
        answer = @session.answer_for_computation("4bab7e64f78b122cdd000005", params)
        answer.computation_id.should == "4bab7e64f78b122cdd000005"
        answer.calculator_id.should == "4bab7e4ff78b122cdd000004"
        answer.answer_set_id.should == "4bd5cb3bdfde7b125600374f"
      end

      it "should not be valid with there is no params of the amount_of material" do
        params = {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a","formula_input_name"=>"emissions_by_kg"}
        answer = @session.answer_for_computation("4bab7e64f78b122cdd000005", params)
        answer.should_not be_valid
        answer.errors.should_not be_nil
        answer.errors["amount_of_material"].should_not be_nil
      end
    end
    
  end
end