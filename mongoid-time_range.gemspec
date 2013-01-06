$: << File.expand_path('../lib', __FILE__)
require 'mongoid/time_range/version'

Gem::Specification.new do |gem|
  gem.name          = 'mongoid-time_range'
  gem.version       = Mongoid::TimeRange::VERSION
  gem.authors       = 'Mario Uher'
  gem.email         = 'uher.mario@gmail.com'
  gem.homepage      = 'https://github.com/haihappen/mongoid-time_range'
  gem.summary       = 'Time range type for Mongoid.'
  gem.description   = 'Mongoid::TimeRange defines a TimeRange type for your Mongoid apps.'

  gem.files         = `git ls-files`.split("\n")
  gem.require_path  = 'lib'

  gem.add_dependency 'activesupport'
  gem.add_dependency 'mongoid'
end
