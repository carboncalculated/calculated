# Answers from the api
#  calculations will be in the form of a hash with value and units keys
#   answer.calculations["co2"]["value"] == 10
#   answer.calculations["co2"]["units"] == "kg"
module Calculated
  module Models
    class Answer  < Hashie::Dash
      
      # properties
      property :calculations # [Hash]
      property :object_references # [Hash]
      property :used_global_computations # [Hash]
      property :calculator_id # [String]
      property :computation_id # [String]
      property :answer_set_id # [String]
      property :source # [Calculated::Models::Source]
      property :errors # [Hash]
                  
      def source=(value)
        unless value.nil?
          self[:source] = Models::Source.new(value)
        end
      end
      
      def valid?
        errors.nil?
      end
      
    end
  end
end