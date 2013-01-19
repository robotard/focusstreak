# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rack_csrf"
  s.version = "2.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Emanuele Vicentini"]
  s.date = "2012-02-28"
  s.description = "Anti-CSRF Rack middleware"
  s.email = "emanuele.vicentini@gmail.com"
  s.extra_rdoc_files = ["LICENSE.rdoc", "README.rdoc"]
  s.files = ["LICENSE.rdoc", "README.rdoc"]
  s.homepage = "https://github.com/baldowl/rack_csrf"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Rack::Csrf 2.4.0", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rackcsrf"
  s.rubygems_version = "1.8.24"
  s.summary = "Anti-CSRF Rack middleware"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0.9"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<cucumber>, [">= 1.1.1"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 0.9"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<cucumber>, [">= 1.1.1"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0.9"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<cucumber>, [">= 1.1.1"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<rdoc>, [">= 2.4.2"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end
