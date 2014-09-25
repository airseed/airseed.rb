require 'bundler/setup'
Bundler.setup

require 'airseed'

spec_root = File.expand_path(File.dirname(__FILE__))

$: << spec_root

Dir[File.join(spec_root, "support/**/*.rb")].each { |f| require f }

def has_keys(hash, keys)
  keys.all? {|k| hash.key? k}
end
