require "airseed/version"
require "airseed/client"
require "airseed/oauth"
require "airseed/user_api"

module Airseed
  class << self
    attr_accessor :client_id, :client_secret
  end
end
