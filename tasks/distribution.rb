desc 'Generate documentation'
YARD::Rake::YardocTask.new

task :rdoc => :yardoc

Jeweler::Tasks.new do |gem|
  gem.name      = "fakeweb-matcher"
  gem.summary   = "RSpec matcher for the FakeWeb library"
  gem.homepage  = "http://github.com/freelancing-god/fakeweb-matcher"
  gem.author    = "Pat Allan"
  gem.email     = "pat@freelancing-gods.com"
  
  gem.files     = FileList[
    'lib/**/*.rb',
    'LICENSE',
    'Rakefile',
    'README.textile',
    'tasks',
    'VERSION.yml'
  ]
  gem.test_files = FileList['spec/**/*.rb']
end
