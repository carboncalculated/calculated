module Calculated
  module Models
    class GenericObject < Hashie::Dash
      
      # properties
      property :id # [String]
      property :template_name # [String]
      property :identifier # [String]
      property :characteristics # [Array<Calculated::Models::Characteristic>]
      property :formula_inputs # [Array<Calculated::Models::FormulaInput>]
      
      # dont ask why I need to check for nil? here just dont!
      def characteristics=(value)
        unless value.nil?
          self[:characteristics] = value.map{|characteristic| Calculated::Models::Characteristic.new(characteristic)}
        end
      end
      
      # setting the formula inputs to a defined model
      def formula_inputs=(value)
        unless value.nil?
          self[:formula_inputs] = value.map{|formula| Calculated::Models::FormulaInput.new(formula)}
        end
      end
      
      def used_formula_inputs=(value)
        unless value.nil?
          self[:used_formula_inputs] = value.map{|formula| Calculated::Models::FormulaInput.new(formula)}
        end
      end
    
    end
  end
end