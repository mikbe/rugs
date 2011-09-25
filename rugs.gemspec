# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rugs/version"

Gem::Specification.new do |s|
  s.name        = "rugs"
  s.version     = RUGS::VERSION
  s.authors     = ["Mike Bethany"]
  s.email       = ["mikbe.tk@gmail.com"]
  s.homepage    = "http://mikbe.tk"
  s.summary     = %q{A helper script that makes setting up remote git repositories a snap.}
  s.description = 
"""
= RUGS - RUby Git Setup

A helper script that makes setting up remote git repositories a snap.  

RUGS has three main functions:  

Creates a local git repository and directory structure using default templates or ones you create.
Sets up a remote repository to mirror your local one.
Adds a framework of git hooks allowing you to store and run your own hooks in directly from the repo.

RUGS makes creating remote repos as simple as `rugs create repo_name on server_name`.

RUGS even allows you to automatically embed your Git hooks in the repo itself. No more jumping through hoops to make sure your hooks are maintained with your project; with RUGS you just store your hook scripts in the `git_hooks` directory and they're automatically updated and run.  

Once you've set up your project using RUGS you just use Git as you normally would with the exception of your hooks being the in `git_hooks` directory.  

"""

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  
  s.add_runtime_dependency "commandable"
  s.add_runtime_dependency "term-ansicolor-hi"
  
end
