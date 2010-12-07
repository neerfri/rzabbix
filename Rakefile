$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rzabbix/version"
 
desc "Builds the RZabbix gem"
task :build do
  system "gem build rzabbix.gemspec"
end

desc "Pushes the RZabbix gem to Gemcutter"
task :release => :build do
  system "gem push rzabbix-#{RZabbix::VERSION}"
end

gem 'rspec'
require 'rspec'
require 'rspec/core/rake_task'

desc "Run all specs"
Rspec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = ["--format doc"]
end
