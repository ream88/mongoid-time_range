$: << File.expand_path('../lib', __FILE__)
# require 'mongoid/time_range/version'

Gem::Specification.new do |gem|
  gem.name          = 'mongoid-time_range'
  gem.version       = '0.0.1'
  gem.authors       = 'Mario Uher'
  gem.email         = 'uher.mario@gmail.com'
  gem.homepage      = 'https://github.com/haihappen/mongoid-time_range'
  gem.summary       = 'TimeRange type for Mongoid.'
  gem.description   = 'Mongoid::TimeRange defines a TimeRange type for your Mongoid apps.'

  gem.files         = `git ls-files`.split("\n")
  gem.require_path  = 'lib'

  gem.add_dependency 'mongoid'
end
