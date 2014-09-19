require "bundler/gem_tasks"
require 'airseed'

desc "Run default test"
task :default do |t|
  Airseed.client_id     = ENV['CLIENT_ID']
  Airseed.client_secret = ENV['CLIENT_SECRET']
  Airseed.base_api      = 'https://api.airseed.com'

  # e.g. usage
  # Airseed::Client.request(:get, 'v1/users/me', {}, :bearer_token => ENV['BEARER_TOKEN'])
end

