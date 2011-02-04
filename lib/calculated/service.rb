module Calculated
  class Service
    include HTTParty
    format :json
        
    # set the httparty defaults [this obviously makes 1 service] limitation me feels
    def initialize(server, api_version, api_key)
      self.class.base_uri "http://#{server}/api/#{api_version}"
      self.class.headers 'Accept' => 'application/json', "X-CCApiKey" => api_key
    end
    
    def get(path, params = {})
      perform_request(:get, path, params)
    end
    
    def post(path, params = {})
      perform_request(:post, path, params)
    end
    
    private
    def perform_request(type, path, params)
      response = self.class.send(type, path, :query => params)
      check_response(response)
      response
    rescue Errno::ECONNREFUSED, SocketError
      raise Calculated::Session::ServerNotFound, "Carbon Calculated Server could not be found"
    end
    
    # checking the status code of the response; if we are not authenticated
    # then authenticate the session
    # @raise [Calculated::PermissionDenied] if the status code is 403
    # @raise [Calculated::SessionExpired] if a we get a 401
    # @raise [Calculated::MissingParameter] if we get something strange
    def check_response(response)
      case response.code
        when 200, 201
          true
        when 401
          raise Calculated::Session::PermissionDenied.new("Your Request could not be authenticated is your api key valid?")
        when 404
          raise Calculated::Session::NotFound.new("Resource was not found")
        when 412
          raise Calculated::Session::MissingParameter.new("Missing Parameter: #{response.body}")
        else
          raise Calculated::Session::UnknownError.new("super strange type unknown error: #{response.code} :body #{response.body}")
      end
    end
  
  end
end