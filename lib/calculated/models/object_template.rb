module Calculated
  module Models
    class ObjectTemplate < Hashie::Dash
        
      # properties
      property :id # [String]
      property :name # [String]
      property :generic_objects # [Array<Calculated::Models::GenericObject>]
      
      # characteristics from an object template will not have a value property set as it is a template
      property :characteristics # [Hash] not the same as generi_objects characteristics
      
      # formula_inputs from an object template will not have a value property set as it is a template
      property :formula_inputs # [Hash] not the same as generi_objects formula_inputs
      
      property :relatable_categories # [Array<Calculated::Models::RelatableCategory>]
      
      # dont ask why I need to check for nil? here just dont!
       def generic_objects=(value)
         unless value.nil?
           self[:generic_objects] = value.map{|generic_object| Calculated::Models::GenericObject.new(generic_object)}
         end
       end
       
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
       
       # setting the formula inputs to a defined model
       def relatable_categories=(value)
         unless value.nil?
           self[:relatable_categories] = value.map{|relatable_category| Calculated::Models::RelatableCategory.new(relatable_category)}
         end
       end

    end
  end
end