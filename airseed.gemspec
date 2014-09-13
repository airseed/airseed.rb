# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airseed/version'

Gem::Specification.new do |spec|
  spec.name          = "airseed"
  spec.version       = Airseed::VERSION
  spec.authors       = ["Airseed Engineering"]
  spec.email         = ["dev@airseed.com"]
  spec.summary       = %q{The official Ruby Client for the Airseed API}
  spec.homepage      = "https://github.com/airseed/airseed.rb"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  s.add_dependency("httparty")
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  s.add_development_dependency("rspec")
  s.add_development_dependency("webmock")
end
