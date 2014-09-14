require 'json'

module Airseed
  module Client
    module_function

    def request(method, path, params = {}, options = {})
      url = URI.join(Airseed.base_api, path).to_s
      bearer_token = options[:bearer_token]

      if method.to_s.downcase.to_sym == :get
        url_params = URI.escape(params.collect{|k,v|"#{k}=#{v}"}.join('&'))
        uri        = URI::parse("#{url}?#{url_params}")
        http       = http_request(uri)

        req        = Net::HTTP::Get.new uri.to_s
      else
        uri  = URI.parse(url)
        http = http_request(uri)
        req  = Net::HTTP::Post.new(uri.to_s, {'Content-Type' =>'application/json'})
        req.body = params.to_json
      end

      if bearer_token
        req['Authorization'] = "Bearer #{bearer_token}"
      else
        req.basic_auth(Airseed.client_id, Airseed.client_secret)
      end

      res = http.request(req)

      unless res.kind_of? Net::HTTPSuccess
        raise "HTTP Response: #{res.code} #{res.message} for #{url}"
      end
      res = JSON.parse(res.body) unless res.body.nil? || res.body.empty?

      # Hashie::Mash.new(res.body)
      return res
    end

    class RequestError < StandardError; end

    def http_request(uri)
      http         = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"

      return http
    end
  end
end
