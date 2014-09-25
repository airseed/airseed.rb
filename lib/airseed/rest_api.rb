module Airseed
  class RestAPI
    include Airseed::Client
    attr_reader :access_token
    API_BASE_URL = "https://api.airseed.com"

    def initialize(access_token = nil)
      @access_token = access_token
    end

    def users_info
      request(:get, request_url('v1/users/me'), { bearer_token: @access_token })
    end

    def users_data(endpoint, params = {})
      params.merge!(bearer_token: @access_token)
      request(:get, request_url("v1/users/me/#{endpoint}"), params)
    end

    def endpoint(path, params = {})
      params.merge!(bearer_token: @access_token)
      request(:get, request_url(path), params)
    end

    private
    def request_url(path)
      URI.join(API_BASE_URL, path).to_s
    end
  end
end
