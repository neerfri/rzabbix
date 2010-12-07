# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rzabbix/version'

Gem::Specification.new do |s|
  s.name        = "rzabbix"
  s.version     = RZabbix::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Neer Friedman"]
  s.email       = ["neerfri@gmail.com"]
  s.homepage    = "http://github.com/neerfri/rzabbix"
  s.summary     = "Zabbix API client for Ruby."
  s.description = "A ruby API to access zabbix configuration via HTTP API"
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("{lib}/**/*") + %w(README.md ROADMAP.md CHANGELOG.md)
  s.require_path = 'lib'
end