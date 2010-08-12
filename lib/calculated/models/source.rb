module Calculated
  module Models
    class Source  < Hashie::Dash
      
      # properties
      property :id # [String]
      property :description # [String]
      property :main_source_ids # [Array<String>]
      property :external_url # [String]
      property :wave_id # [String]
                  
    end
  end
end