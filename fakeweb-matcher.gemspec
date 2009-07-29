# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fakeweb-matcher}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pat Allan"]
  s.date = %q{2009-07-29}
  s.email = %q{pat@freelancing-gods.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    "LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION.yml",
     "lib/fake_web_matcher.rb",
     "lib/fake_web_matcher/extension.rb",
     "lib/fake_web_matcher/matchers.rb",
     "lib/fake_web_matcher/request_matcher.rb",
     "lib/fakeweb_matcher.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/freelancing-god/fakeweb-matcher}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{RSpec matcher for the FakeWeb library}
  s.test_files = [
    "spec/lib/fake_web_matcher/extension_spec.rb",
     "spec/lib/fake_web_matcher/matchers_spec.rb",
     "spec/lib/fake_web_matcher/request_matcher_spec.rb",
     "spec/lib/fake_web_matcher_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fakeweb>, [">= 1.2.5"])
      s.add_runtime_dependency(%q<rspec>, [">= 1.2.0"])
    else
      s.add_dependency(%q<fakeweb>, [">= 1.2.5"])
      s.add_dependency(%q<rspec>, [">= 1.2.0"])
    end
  else
    s.add_dependency(%q<fakeweb>, [">= 1.2.5"])
    s.add_dependency(%q<rspec>, [">= 1.2.0"])
  end
end
