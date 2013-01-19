# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rufus-tokyo"
  s.version = "1.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Mettraux", "Zev Blut", "Jeremy Hinegardner", "James Edward Gray II"]
  s.date = "2010-02-09"
  s.description = "\nRuby-ffi based lib to access Tokyo Cabinet and Tyrant.\n\nThe ffi-based structures are available via the Rufus::Tokyo namespace.\nThere is a Rufus::Edo namespace that interfaces with Hirabayashi-san's native Ruby interface, and whose API is equal to the Rufus::Tokyo one.\n\nFinally rufus-tokyo includes ffi-based interfaces to Tokyo Dystopia (thanks to Jeremy Hinegardner).\n  "
  s.email = "jmettraux@gmail.com"
  s.extra_rdoc_files = ["LICENSE.txt", "README.rdoc"]
  s.files = ["LICENSE.txt", "README.rdoc"]
  s.homepage = "http://github.com/jmettraux/rufus-tokyo/"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rufus"
  s.rubygems_version = "1.8.24"
  s.summary = "ruby-ffi based lib to access Tokyo Cabinet, Tyrant and Dystopia"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<ffi>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<ffi>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
