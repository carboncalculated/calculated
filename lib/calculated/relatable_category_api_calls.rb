module Calculated
  module RelatableCategoryApiCalls  
    
    
    # @param [String] id
    # @param [Hash] params
    # @return [Calculated::Models::RelatableCategory]
    def relatable_category(id, params = {})
      api_call(:get, "/relatable_categories/#{id}", params) do |response|
         Calculated::Models::RelatableCategory.new(response["relatable_category"])
      end
    end
    
    # @param [Hash] params
    # @return [Array<Calculated::Models::RelatableCategory>
    def relatable_categories(params = {})
      api_call(:get, "/relatable_categories", params) do |response|
         response["relatable_categories"].map{|relatable_category| Calculated::Models::RelatableCategory.new(relatable_category)}
      end
    end
  
    # this call just beings back a native array with hash of ids and identifiers
    # @example 
    #   
    #   "4bf42d8b46a95925b5001a0c" => "Particle Board"
    #
    # @param [String] template_name
    # @param [Array<String>] relatable_category_ids
    # @param [Hash] params
    # @return [Hash]
    def related_objects_from_relatable_categories(template_name, relatable_category_ids, params = {})
      relatable_category_ids = relatable_category_ids.is_a?(String) ? [relatable_category_ids] : relatable_category_ids
      api_call(:get, "/relatable_categories/related_objects", params.merge!(:template_name => template_name, :relatable_category_ids => relatable_category_ids)) do |response|
        response["related_objects"]
      end
    end
    
    
    
    ## this call just beings back a native array with hash of ids and identifiers
    # @example 
    #   
    #   "4bf42d8a46a95925b5001999" => "timber"
    #
    # @param [String] id
    # @param [String] related_attribute
    # @param [Hash] params
    # @return [Hash]
    def related_categories_from_relatable_category(id, related_attribute, params = {})
      api_call(:get, "/relatable_categories/#{id}/related_categories", params.merge!(:related_attribute => related_attribute)) do |response|
        response["related_categories"]
      end
    end
     
 end
end