require File.expand_path("../lib/calculated/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "calculated"
  s.version     = Calculated::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Richard Hooker"]
  s.email       = ["richard.hooker@carboncalculated.com"]
  s.homepage    = "http://github.com/hookercookerman/calculated"
  s.summary     = "A gem to use the carbon calculated api"
  s.description = "makes using a simple api even more simple;"

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "calculated"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"
  s.add_dependency 'activesupport',           '~> 3.0.0.rc2'
  s.add_dependency 'httparty',           '~> 0.6.1'
  s.add_dependency 'hashie',           '~> 0.2.1'
  s.add_dependency 'moneta',           '~> 0.6.0'
  s.add_dependency 'tzinfo',           '~> 0.3.22'
  

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir['lib/**/{*,.[a-z]*}', "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ["newgem"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end