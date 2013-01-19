# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sinbook"
  s.version = "0.1.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aman Gupta"]
  s.date = "2010-02-04"
  s.description = "A full-featured facebook extension for the sinatra webapp framework"
  s.email = "aman@tmm1.net"
  s.homepage = "http://github.com/tmm1/sinbook"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "simple sinatra facebook extension in 300 lines of ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yajl-ruby>, [">= 0"])
    else
      s.add_dependency(%q<yajl-ruby>, [">= 0"])
    end
  else
    s.add_dependency(%q<yajl-ruby>, [">= 0"])
  end
end
