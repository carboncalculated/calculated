module Calculated
  module GenericObjectApiCalls    
  
    # @param [Hash] params
    # @return [Array<Calculated::Models::GeneriObject>]
    def generic_objects(params = {})
      api_call(:get, "/generic_objects", params) do |response|
        response["generic_objects"].map{|generic_object| Calculated::Models::GenericObject.new(generic_object)}
      end
    end
  
    # @param [String] id
    # @param [Hash] params
    # @return [Calculated::Models::GeneriObject
    def generic_object(id, params = {})
      api_call(:get, "/generic_objects/#{id}", params) do |response|
         Calculated::Models::GenericObject.new(response["generic_object"])
      end
    end
  
    # @param [String] id
    # @param [Hash] params
    # @return [Array<Calculated::Models::FormulaInput>]
    def formula_inputs_for_generic_object(id, params = {})
      api_call(:get, "/generic_objects/#{id}/formula_inputs", params) do |response|
       response["formula_inputs"].map{|formula_input| Calculated::Models::FormulaInput.new(formula_input)}
      end
    end
  end
end