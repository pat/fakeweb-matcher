# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name          = "fakeweb-matcher"
  spec.version       = "1.2.4"
  spec.authors       = ["Pat Allan"]
  spec.email         = ["pat@freelancing-gods.com"]

  spec.homepage      = "http://github.com/pat/fakeweb-matcher"
  spec.summary       = "RSpec matcher for the FakeWeb library"

  spec.files         = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |file| File.basename(file) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fakeweb", ">= 1.2.5"
  spec.add_runtime_dependency "rspec",   ">= 1.2.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard", "~> 0.9.11"
end
