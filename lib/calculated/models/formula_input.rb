module Calculated
  module Models
    class FormulaInput < Hashie::Dash
      
      # properties
      property :id # [String]
      property :values # [Hash]
      property :name # [String]
      property :base_unit # [String]
      property :active_at # [Time] yes time
      property :main_source_id # [String]
      property :group_name # [String]
      property :input_units # [String]
      property :label_input_units # [String]
      property :model_state # [String]
      property :source # holder of old data this is not used I repeat this is not used
          
    end
  end
end