require "bundler"
Bundler.setup

# get the calculated gem and bundle in the test group
require "calculated"
Bundler.require(:test)

# support files
lib_dir = ::File.expand_path(::File.join(::File.dirname(__FILE__)))
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', 'version_mapper')
require ::File.join(lib_dir, 'carbon_calculated_api', 'api')
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "generic_object_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "object_template_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "answer_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "relatable_category_app")

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|  
   config.before(:each) do
     # set up the api
     @api_user = ApiUser.new(
       :email => "hacktheplanet@cc.com", 
       :api_key => "testing_api_key"
      )
      
      ApiUser.record(@api_user)
    
     # fake api server to be release as seperate gem for other devs
     Artifice.activate_with(CarbonCalculatedApi::API.app)
   end

   config.after(:each) do
     Artifice.deactivate
   end
   
  config.mock_with :rspec
end