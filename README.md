#Calculated#

Calculated allows you to interact with the [CarbonCalculated API](http://www.carboncalculated.com/platform) in 
a ruby way.

"The Carbon Calculated platform is a freely accessible aggregation system containing up to the minute data on carbon emissions and emission calculation"

* Idiomatic Ruby
* Concrete classes and methods modelling CarbonCalculated data

Please visit [The Blog](http://blog.carboncalculated.com) For Developer examples and information

DOCS Are located [here](http://rdoc.info/projects/hookercookerman/calculated/blob/dd7ed3f73d987492486abb7091f6321e8b04443e)

Super Simple Example Apps Using the API

[http://miniapps.carboncalculated.com/](http://miniapps.carboncalculated.com/)

##Getting Started##

Get An API KEY
  
    contact support@carboncalculated.com 

You can install it as:

    sudo gem install calculated (dont use sudo if using RVM)

##Creating A Session##
  
    @session = Calculated::Session.create(:api_key => "your_api_key")

##Overwriting defaults##

**These are the defaults**

    caching                    # => true (boolean)
    expires_in                 # => 60*60*24 (seconds)
    cache                      # => Moneta::Memory.new "(Moneta Supported Cache) http://github.com/wycats/moneta
    server                     # => "api.carboncalculated.com" (string)
    api_version                #=>  "v1" (string)
    logging                    # => true (boolean)
    
**This is overriding the defaults**

    @session = Calculated::Session.create(
      :api_key => "your_api_key", 
      :cache => Moneta::S3.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :bucket => 'carbon')
      :expires_in => 60*60*24*14
    )
    
    This has created a session with S3 Moneta cache that expires in 14 days
    
##Basic Usage##

Via using the CarbonCalculated Browser http://browser.carboncalculated.com/ you can easily see what is available for you to interact with in terms of 
data and calculations;

Now that you have a session you can call methods on the session to interact with carbon calculated api

**Example**

**Very simple materials Calculator**

Lets first got to the calculator on the browser (click here to see what I mean http://browser.carboncalculated.com/calculators/4bab7e4ff78b122cdd000004/computations/4bab7e64f78b122cdd000005"

    @answer = @session.answer_for_computation("4bab7e64f78b122cdd000005", {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"})
    @answer.calculations["co2"]["value"]
    
    
    
    OR
    
    
    @answer = @session.answer_for_calculator("4bab7e4ff78b122cdd000004", {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"})
    @answer.calculations["co2"]["value"]
    
    This will return a Calculated::Models::Answer Object
    
    
    The reason that you can get an answer from either a calculator or a computation is the power of the validations; its cool
    trust me.
    
##Object Template Api##

A Object Template is a template for the building of generic objects; these contain information about what
all the object for the object template should contain; as well as getting relatable categories which can be 
used to filter to specific generic objects which you can then later be used in answer calls

    @object_templates = @session.object_templates  # returns an Array of ObjectTemplate Objects
    @object_templates[0].name
    @object_templates[0].characteristics
  
  
  
  
    @object_template = @session.generic_objects_for_object_template("car")  # returns an ObjectTemplate Object with paginate GenericObjects
    @object_template.generic_objects[0].identifier
  
  
  
  
  
    params can be given for pagination
    @session.object_templates(:page => 50, :per_page => 3)
    @session.generic_objects_for_object_template("car", :page => 50, :per_page => 3)
  
  
  
  
  
    # Getting object template with its relatable categories
    # this will return ObjectTemplate with Relatable Category Objects
    @object_template = @session.relatable_categories_for_object_template("car", "manufacture")
    @object_template.relatable_categories[0].name
    @object_template.relatable_categories[0].relatable_categories
  
    # yes relatable category know about other ones very cool when building "successive drop downs"[http://blog.carboncalculated.com/2010/06/16/creating-successive-drop-downs/]
  
  
  
  
  
    # @param [String] name # the object_template name ie "car", "airport", "material"
    # @param [String] filter # the string you want to filter 
    #
    @object_template = @session.generic_objects_for_object_template_with_filter("airport", "london")
    @object_template.generic_objects[0].identifier
  
##Object Template Object##

    property :id # [String]
    property :template_name # [String]
    property :identifier # [String]
    property :characteristics # [Array<Calculated::Models::Characteristic>]
    property :formula_inputs # [Array<Calculated::Models::FormulaInput>]
  
##Generic Objects API##

A Generic Object represents and object that is used in computations OR calculators; a computation will always
need at least one object to talk about; The "formula_inputs" of an object are the values that are used 
in formulas and can be versioned to specific times for equations that change over time.

This is a list of car for instance CLICK http://browser.carboncalculated.com/object_templates/car/generic_objects

Finding and using generic objects is a major part of the platform apart from the actual calculations themselves
  
      # Finding generic objects
      @generic_objects = @session.generic_objects
      @generic_objects[0].identifier
  

      # Specific Generic Object
      @generic_object = @session.generic_object("4c370c11ae2b7b418e00232c")
      @generic_object.identifier
  
  
  
      # Getting just the "Formula Inputs" of a generic Object
      @formula_inputs = @session.formula_inputs_for_generic_object("4c370c11ae2b7b418e00232c")
      @formula_inputs[0].values

##Generic Object (Object)##

      # properties
      property :id # [String]
      property :template_name # [String]
      property :identifier # [String]
      property :characteristics # [Array<Calculated::Models::Characteristic>]
      property :formula_inputs # [Array<Calculated::Models::FormulaInput>]
    
##Formula Input Object##

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
    
##Relatable Category API##

Relatable Categories are created when an generic object has been created; And not before hand; Hence
in theory a relatable category is only there when objects are there and not before; Which means
that you should never have a problem of a category existing just for the fun of it;

A relatable category will know all the objects that have its name and related_attribute; In a nut shell you can use relatable
category to filter and find related objects easily and effectively;

Also a relatable category will know of other relatable categories of the created object; so this allows for 
super easy drop downs to create easy filter; the blog should help explain this further or just send me an email;
  
  
  
      # Getting related objects from an ARRAY OF Relatable Category IDS USED in intersecting the related objects
      # therefore its a really cool way to get filtered results
      #
      # @param object_template_name ie "car", "material"
      # @param relatable_category_ids # Array # 
      result = @session.related_objects_from_relatable_categories("material", ["4bf42d8a46a95925b500199a"])
      result["4bf42d8b46a95925b5001a0c"]  # Partial Board
  
  
  
  
  
      # Getting Related Categories from a related category
      #
      # @param Relatable Category ID
      # @param related_attribute
      result = @session.related_categories_from_relatable_category("4bf42d8a46a95925b500199a", "material_type")
      results["4bf42d8b46a95925b50019c7"] # hardboard
  
  
##Relatable Category Object##

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
    
    
##Answer API##

This is the crux of the api; this is where co2, co2e etc results can be found;

The best and easiest way to found what information you need to get a valid answer is using the browser["http://browser.carboncalculated.com"]
Once you have found what parameters you need to send you can then do exactly that;

A Answer Object will give you vaste information on what it used to get the answer; You will be told the all the objects that were used in the calculation
all the used_formula_inputs and the sources that where used to gain the information to make the calculation even possible. 
    
    
      @answer = @session.answer_from_computation("4bab7e64f78b122cdd000005", {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "amount_of_material"=>"10", "formula_input_name"=>"emissions_by_kg"})
      @answer.calculations["co2"]["value"]
    
*Errors

If you don send the correct parameters in an answer you will be told where you are going wrong
    
      @answer = @session.answer_from_computation("4bab7e64f78b122cdd000005", {"material_category"=>"4bf42d8046a95925b5000efb", "type_of_material"=>"4bf42d8046a95925b5000f40", "material"=>"4bf42d8046a95925b5000f2a", "formula_input_name"=>"emissions_by_kg"})
      @answer.valid? # false
    
      @answer.errors 
  
        "amount_of_material" =>["can't be blank", "is not a number"]
  
##Answer Object##
  
      #   answer.calculations["co2"]["value"] == 10
      #   answer.calculations["co2"]["units"] == "kg"
      #
      property :calculations # [Hash]
      property :object_references # [Hash]
      property :used_global_computations # [Hash]
      property :calculator_id # [String]
      property :computation_id # [String]
      property :answer_set_id # [String]
      property :source # [Calculated::Models::Source]
      property :errors # [Hash]
  
##Source Object##

      # properties
      property :id # [String]
      property :description # [String]
      property :main_source_ids # [Array<String>]
      property :external_url # [String]
      property :wave_id # [String]
    
##Bugs and Feedback##

If you discover any bugs or want to drop a line support@carboncalculated.com

Copyright (c) 2010 Richard Hooker http://blog.carboncalculated.com
See the attached MIT License.
