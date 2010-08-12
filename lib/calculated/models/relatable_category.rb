module Calculated
  module Models
    class RelatableCategory < Hashie::Dash
              
      # properties
      property :id # [String]
      property :name # [String]
      property :related_attribute # [String] 
      property :related_object_name # [String]      
      # @example 
      #  "emission_source" => {
      #   {
      #       "4c349f6068fe5434960178c2" => "flaring and venting",
      #       "4c349f6068fe54349601791f" => "fugitives",
      #   }    
      # }
      property :related_categories # [Hash{name => <Hash{:id => identifier}}]
      
      
  
    end
  end
end