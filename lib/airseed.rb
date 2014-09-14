require "airseed/version"
require "airseed/client"

module Airseed
  class << self
    attr_accessor :base_api, :client_id, :client_secret
  end
end
