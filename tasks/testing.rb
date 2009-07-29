require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts << "-c"
end

Spec::Rake::SpecTask.new(:rcov) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.spec_opts << "-c"
  
  t.rcov_opts = ['--exclude', 'spec', '--exclude', 'gems']
  t.rcov      = true
end
