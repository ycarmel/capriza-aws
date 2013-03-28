# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capriza-aws/version'
require 'aws-sdk'
require 'yaml'
require 'rubygems'

Gem::Specification.new do |gem|
  gem.name          = "capriza-aws"
  gem.version       = Capriza::Aws::VERSION
  gem.authors       = ["Alon Becker"]
  gem.email         = ["alon@alonbecker.com"]
  gem.description   = %q{AWS Helper Files}
  gem.summary       = %q{AWS Helper Files}
  gem.homepage      = "http://rubygems.org/gems/capriza-aws"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
