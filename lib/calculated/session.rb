require 'active_support/core_ext/object/to_query'
module Calculated
  class Session
    
    class CalculatedError < StandardError ;end
    class Expired < CalculatedError; end
    class UnAuthorized < CalculatedError; end
    class NotAuthenticated < CalculatedError; end
    class PermissionDenied < CalculatedError; end
    class NotFound < CalculatedError; end
    class ServerNotFound < CalculatedError; end
    class MissingParameter < CalculatedError; end
    class UnknownError < CalculatedError; end
    
    # api calls that can be made on the session
    include Calculated::GenericObjectApiCalls
    include Calculated::ObjectTemplateApiCalls
    include Calculated::RelatableCategoryApiCalls
    include Calculated::AnswerApiCalls
    
    # accessors
    attr_accessor :cache, :caching, :logging, :server, :expires_in, :api_version
    
    # creating a session one must supply the api_key as this is always required basically
    # @param [Hash] options
    # @return [Calculated::Session]
    def self.create(options = {})
      api_key = options.delete(:api_key)
      raise ArgumentError.new("You need an API Key to save the planet") unless api_key
      new(api_key, options)
    end
    
    # @param [String] api_key
    # @param [Hash] options
    # default options
    #   caching => true
    #   expires_in => 60*60*24
    #   cache => Moneta::Memory.new
    #   server => "api.carboncalculated.com"
    #   api_version => "v1"
    #   logging => true
    def initialize(api_key, options)
      @api_key = api_key
      if @caching = options[:caching].nil? ? true : options.delete(:caching)
        @expires_in = options.delete(:expires_in) || 60*60*24
        @cache = options.delete(:cache) || Moneta::Memory.new 
      end
      @server = options.delete(:server) || "api-stage.carboncalculated.com"
      @api_version = options.delete(:api_version) || "v1"
      @logging = options[:logging].nil? ? true : options.delete(:caching)
    end
    
    
    # api calls
    def api_call_without_logging(method, path, params = {}, &proc)
      result = service.send(method, path, params)
      result = yield result if block_given?
      store_call(result, path, params || {}) if caching?
      result
    end
    
    # if we caching and we have the same cache lets try and get the 
    # cache; otherwise we will make the request logging if need be
    def api_call(method, path, params ={}, &proc)
      if cache = caching? && (@cache[cache_key(path, params)])
        return cache
      else
        if @logging
          Calculated::Logging.log_calculated_api(method, path, params) do
            api_call_without_logging(method, path, params, &proc)
          end
        else
          api_call_without_logging(method, path, params, &proc)
        end
      end
    end
    
    def service 
      @service ||= Calculated::Service.new(@server, @api_version, @api_key)
    end
    
    def caching?
      @caching
    end
      
    protected
    # @param [String] path
    # @param [Hash] params
    # @return [String] the cache key from the path and the params
    def cache_key(path, params = {})
      parts = []
      parts << path
      parts << params.to_query
      parts.join("/")
    end
    
    # @param [Object] result
    # @param [String] path
    # @param [Hash] params
    def store_call(result, path, params)
      key = cache_key(path, params ||{})
      @cache.store(key, result, :expires_in => @expires_in)
    end
            
  end
end