module Airseed
  class UserAPI
    include Airseed::Client
    attr_reader :access_token
    API_BASE_URL = "https://api.airseed.com"

    def initialize(access_token)
      @access_token = access_token
    end

    def users_info(id = 'me')
      url = request_url("v1/users/#{id}")
      request(:get, request_url(url), { bearer_token: @access_token })
    end

    def users_data(endpoint, params = {})
      params.merge!(bearer_token: @access_token)
      id = params.delete(:id) || 'me'
      url = request_url("v1/users/#{id}/#{endpoint}")
      request(:get, url, params)
    end

    def endpoint(path, params = {})
      params.merge!(bearer_token: @access_token)
      request(:get, request_url(path), params)
    end

    def post_endpoint(path, params = {})
      params.merge!(bearer_token: @access_token)
      request(:post, request_url(path), params)
    end

    private
    def request_url(path)
      URI.join(Airseed.api_base_url || API_BASE_URL, path).to_s
    end
  end
end
