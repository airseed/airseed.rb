module Airseed
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