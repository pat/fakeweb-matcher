require "bundler/gem_tasks"

desc 'Generate documentation'
YARD::Rake::YardocTask.new

task :rdoc => :yardoc
