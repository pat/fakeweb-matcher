require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :test
task :test    => :spec
