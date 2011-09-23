# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rugs/version"

Gem::Specification.new do |s|
  s.name        = "rugs"
  s.version     = RUGS::VERSION
  s.authors     = ["Mike Bethany"]
  s.email       = ["mikbe.tk@gmail.com"]
  s.homepage    = "http://mikbe.tk"
  s.summary     = %q{Place holder gem}
  s.description = %q{Nothing to see here, move along.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_development_dependency "rspec"
  
  # s.add_runtime_dependency "rest-client"

end
