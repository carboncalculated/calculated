module Calculated
  module ObjectTemplateApiCalls
    
    
    # @param [String] id
    # @param [Hash] params
    # @return [Calculated::Models::ObjectTemplate]
    def object_template(id, params = {})
      api_call(:get, "/object_templates/#{id}", params) do |response|
         Calculated::Models::ObjectTemplate.new(response["object_template"])
      end
    end 
  
    # @param [Hash] params
    # @return [Array<Calculated::Models::ObjectTemplate>]
    def object_templates(params = {})
      api_call(:get, "/object_templates", params) do |response|
        response["object_templates"].map{|object_template| Calculated::Models::ObjectTemplate.new(object_template)}
      end
    end
    
    
    # this request will have loaded generic objects for the ready basically
    # @param [String] name
    # @param [Hash] params
    # @return [Calculated::Models::ObjectTemplate]
    def generic_objects_for_object_template(name, params = {})
      api_call(:get, "/object_templates/#{name}/generic_objects", params) do |response|
         Calculated::Models::ObjectTemplate.new(response["object_template"])
      end
    end
    
    # this request will have loaded relatable categories for the object template
    # @param [String] related_attribute
    # @param [String] name
    # @param [Hash] params
    # @return [Calculated::Models::ObjectTemplate]
    def relatable_categories_for_object_template(name, related_attribute, params = {})
      api_call(:get, "/object_templates/#{name}/relatable_categories", params.merge!(:related_attribute => related_attribute)) do |response|
         Calculated::Models::ObjectTemplate.new(response["object_template"])
      end
    end
    
    #   This will filter the results of the generic objects from a simple text search
    #   note this is not an expancive text search so limit to 1 word searches for best
    #   results
    #
    # @example
    #   generic_objects_for_object_template_with_filter('airport', 'london')
    #
    #   There is also the usuage of relatable_category_values with the params
    #   this will allow further filtering on the search its an AND Filter not an OR filter
    #
    # @example
    #   searching for ford diesel cars for example
    #
    #   generic_objects_for_object_template_with_filter('car', 'diesel', :relatable_category_values => ["ford"])
    #
    # this request will have loaded relatable categories for the object template
    # @param [String] name
    # @param [String] filter
    # @param [Hash] params
    # @return [Calculated::Models::GeneriObject]
    def generic_objects_for_object_template_with_filter(name, filter, params = {})
      api_call(:get, "/object_templates/#{name}/generic_objects/filter", params.merge!(:filter => filter)) do |response|
         Calculated::Models::ObjectTemplate.new(response["object_template"])
      end
    end
    
 end
end