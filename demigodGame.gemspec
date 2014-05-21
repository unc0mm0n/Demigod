# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'demigodGame/version'

Gem::Specification.new do |spec|
  spec.name          = "demigod_game"
  spec.version       = DemigodGame::VERSION
  spec.authors       = ["Yuval"]
  spec.email         = ["yvw.bor@gmail.com"]
  spec.description   = %q{A learning project game, build your own island and unleash the dragons from the dragon shrine!}
  spec.summary       = %q{Build your own island and unleash the dragons!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
