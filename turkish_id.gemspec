# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "turkish_id/version"

Gem::Specification.new do |spec|
  spec.name = "turkish_id"
  spec.version = TurkishId::VERSION
  spec.authors = ["Kerem Bozdas"]
  spec.email = ["krmbzds.github@gmail.com"]

  spec.summary = "Validate Turkish Identification Numbers and More!"
  spec.description = "Validate Turkish Identification Numbers and More!"
  spec.homepage = "https://github.com/krmbzds/turkish_id"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "bin"
  spec.executables = ["turkish_id"]
  spec.require_paths = ["lib", "lib/turkish_id"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls_reborn"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "standard-rails"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "savon"
end
