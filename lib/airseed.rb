require "airseed/version"
require "airseed/client"
require "airseed/oauth"
require "airseed/rest_api"

module Airseed
  class << self
    attr_accessor :client_id, :client_secret, :oauth_callback_url
  end
end
