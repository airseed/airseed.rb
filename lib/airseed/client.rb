require 'json'

module Airseed
  module Client
    module_function
    # Public: Airseed API's Ruby Rest Client
    #
    # method - HTTP Verb
    # path - API endpoint path
    # params - API endpoint specific params
    #
    # Examples
    #
    #   request(:get, '/v1/users/me/info', {}. { :bearer_token => 'access_token' }
    # Returns the API response as hash

    def request(method, url, params = {})
      bearer_token = params.delete(:bearer_token)

      if method.to_s.downcase.to_sym == :get
        params = URI.escape(params.collect{|k,v|"#{k}=#{v}"}.join('&'))
        uri    = URI.parse("#{url}?#{params}")
        http   = http_request(uri)
        req    = Net::HTTP::Get.new uri.request_uri
      else
        uri  = URI.parse(url)
        http = http_request(uri)
        req  = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
        req.body = params.to_json
      end

      if bearer_token
        req['Authorization'] = "Bearer #{bearer_token}"
      else
        req.basic_auth(Airseed.client_id, Airseed.client_secret)
      end

      res = http.request(req)

      unless res.kind_of? Net::HTTPSuccess
        fail APIError.new(res.code, res.message, url)
      end
      res = JSON.parse(res.body) unless res.body.nil? || res.body.empty?
    end

    def http_request(uri)
      http         = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"

      return http
    end

    class APIError < StandardError
      attr_accessor :error, :error_reason, :error_uri

      def initialize(error, error_reason = nil, error_uri = nil)
        self.error = error
        self.error_reason = error_reason
        self.error_uri = error_uri
      end

      def message
        [error, error_reason, error_uri].compact.join(' | ')
      end
    end
  end
end
