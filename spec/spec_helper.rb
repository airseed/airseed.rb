require 'bundler/setup'
Bundler.setup

require 'airseed'

spec_root = File.expand_path(File.dirname(__FILE__))

$: << spec_root

Dir[File.join(spec_root, "support/**/*.rb")].each { |f| require f }

def has_keys(hash, keys)
  keys.all? {|k| hash.key? k}
end

class Configs

  def initialize
    @config = YAML.load(File.read(File.expand_path('../config.yml', __FILE__)))['test']
  end

  def [](key)
    @config.fetch(key)
  end

  def []=(key, val)
    @config[key] = val
    File.write(File.expand_path('../config.yml', __FILE__), YAML.dump({ 'test' => @config}))
  end
end

CONFIG = Configs.new
