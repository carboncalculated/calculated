module Calculated
  module Models
    class Characteristic < Hashie::Dash
      
      # properties
      property :id # [String]
      property :attribute # [String]
      property :value # [String]
      property :value_type # [String]
      property :units # [String]
      property :image_id # [String]
      property :image_name # [String]
      property :image_size # [String]
      property :image_type # [String]
          
    end
  end
end