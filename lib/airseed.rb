require "airseed/version"
require "airseed/client"
require "airseed/oauth"
require "airseed/user_api"

module Airseed
  class << self
    attr_accessor :client_id, :client_secret, :api_base_url, :auth_base_url
  end
end
