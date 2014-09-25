module Airseed
  class OAuth
    include Airseed::Client
    AUTH_BASE_URL = "https://auth.airseed.com"

    def initialize(callback_url = nil)
      @client_id     = Airseed.client_id,
      @client_secret = Airseed.client_secret,
      @callback_url  = callback_url
    end

    def login(provider)
      params = {
        client_id: @client_id,
        redirect_uri: @callback_url,
        response_type: 'code',
        state: state,
        provider: provider
      }

      url = request_url("oauth/authenticate")
      params = URI.escape(params.collect{|k,v|"#{k}=#{v}"}.join('&'))

      return URI::parse("#{url}?#{params}").to_s
    end

    def handle_callback(params)
      params.symbolize_keys!
      unless params[:state] == state
        fail Client::APIError.new(:csrf_detected, 'CSRF detected')
      end

      if params[:code]
        @state = nil
        return access_token(params[:code])
      end

    end

    def access_token(code)
      params = {
        client_id: @client_id,
        client_secret: @client_secret,
        redirect_uri: @callback_url,
        code: code,
        grant_type: 'authorization_code'
      }

      request(:post, request_url('oauth/token'), params)
    end

    def refresh_token(refresh_token)
      params = {
        client_id: @client_id,
        client_secret: @client_secret,
        redirect_uri: @callback_url,
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      }

      request(:post, request_url('oauth/token'), params)
    end

    private

    def state
      @state ||= SecureRandom.hex(24)
    end

    def request_url(path)
      URI.join(AUTH_BASE_URL, path).to_s
    end
  end
end
