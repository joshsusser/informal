# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "informal/version"

Gem::Specification.new do |s|
  s.name        = "informal"
  s.version     = Informal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josh Susser"]
  s.email       = ["josh@hasmanythrough.com"]
  s.homepage    = "https://github.com/joshsusser/informal"
  s.summary     = %q{Easily use any Plain Old Ruby Object as the model for Rails form helpers.}
  s.description = %q{Easily use any Plain Old Ruby Object as the model for Rails form helpers.}

  s.rubyforge_project = "informal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activemodel', "~> 3.0")
end
