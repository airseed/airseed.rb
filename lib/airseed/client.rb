module Airseed
  module Client
    module_function

    def request(method, path, params = {}, options = {})
      url = Airseed.base_api + path
      bearer_token = options[:bearer_token]
      use_ssl = url.scheme == "https"

      if method.to_s.downcase.to_sym == :get
        url_params = URI.escape(params.collect{|k,v|"#{k}=#{v}"}.join('&'))
        uri = URI::parse("#{url}?#{url_params}")

        res = Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl) do |http|
          req = Net::HTTP::Get.new(uri.to_s)
        end
      else
        uri = URI.parse(url)
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl) do |http|
          req = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
          req.body = params.to_json
        end
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

      res = JSON.parse(res.body) if res.body.present?

      # Hashie::Mash.new(res.body)
      return res
    end

    class RequestError < StandardError; end
  end
end
