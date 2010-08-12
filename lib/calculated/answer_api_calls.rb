module Calculated
  module AnswerApiCalls    
  
    # @param [String] id
    # @param [Hash] params
    # @return [Array<Calculated::Models::Answer>]
    def answer_for_calculator(calculator_id, params = {})
      api_call(:get, "/calculators/#{calculator_id}/answer", params) do |response|
        Calculated::Models::Answer.new(response)
      end
    end
    
    
    # @param [String] id
    # @param [Hash] params
    # @return [Array<Calculated::Models::Answer>]
    def answer_for_computation(compuation_id, params = {})
      api_call(:get, "/computations/#{compuation_id}/answer", params) do |response|
        Calculated::Models::Answer.new(response)
      end
    end
  
  end
end