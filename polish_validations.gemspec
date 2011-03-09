# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "polish_validations/version"

Gem::Specification.new do |s|
  s.name        = "polish_validations"
  s.version     = PolishValidations::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Krzysztof Jablonski"]
  s.email       = ["jablko@gmail.com"]
  s.homepage    = "http://github.com/jablkopp/polish_validations"
  s.summary     = %q{The set of validations for Polish users (e.g. nip, regon, bank account)}
  s.description = %q{The set of validations for Polish users (e.g. nip, regon, bank account)}

  s.rubyforge_project = "polish_validations"
  
  s.add_dependency('rails')
  s.add_dependency('activerecord')
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
