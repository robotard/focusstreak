# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sinatra-authentication"
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Max Justus Spransy"]
  s.date = "2010-12-14"
  s.description = "Simple authentication plugin for sinatra."
  s.email = "maxjustus@gmail.com"
  s.extra_rdoc_files = ["TODO"]
  s.files = ["TODO"]
  s.homepage = "http://github.com/maxjustus/sinatra-authentication"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Simple authentication plugin for sinatra."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_runtime_dependency(%q<dm-migrations>, [">= 0"])
      s.add_runtime_dependency(%q<dm-validations>, [">= 0"])
      s.add_runtime_dependency(%q<dm-timestamps>, [">= 0"])
      s.add_runtime_dependency(%q<rufus-tokyo>, [">= 0"])
      s.add_runtime_dependency(%q<sinbook>, [">= 0"])
      s.add_runtime_dependency(%q<rack-flash>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<dm-migrations>, [">= 0"])
      s.add_dependency(%q<dm-validations>, [">= 0"])
      s.add_dependency(%q<dm-timestamps>, [">= 0"])
      s.add_dependency(%q<rufus-tokyo>, [">= 0"])
      s.add_dependency(%q<sinbook>, [">= 0"])
      s.add_dependency(%q<rack-flash>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<dm-migrations>, [">= 0"])
    s.add_dependency(%q<dm-validations>, [">= 0"])
    s.add_dependency(%q<dm-timestamps>, [">= 0"])
    s.add_dependency(%q<rufus-tokyo>, [">= 0"])
    s.add_dependency(%q<sinbook>, [">= 0"])
    s.add_dependency(%q<rack-flash>, [">= 0"])
  end
end
