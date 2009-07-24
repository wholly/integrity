# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{integrity-yammer}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Stewart"]
  s.date = %q{2009-03-09}
  s.description = %q{Post a short message to a Yammer feed after each build}
  s.email = %q{jason.m.stewart@gmail.com}
  s.extra_rdoc_files = ["lib/notifier/config.haml", "lib/notifier/yammer.rb", "README.markdown"]
  s.files = ["integrity-yammer.gemspec", "lib/notifier/config.haml", "lib/notifier/yammer.rb", "Rakefile", "README.markdown", "spec/integrity_yammer_spec.rb", "spec/spec_helper.rb"]
  s.homepage = %q{http://integrityapp.com}
  s.has_rdoc = false
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Yammer notifier for Integrity ci server}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<foca-integrity>, [">= 0"])
      s.add_runtime_dependency(%q<jstewart-yammer4r>, [">= 0"])
    else
      s.add_dependency(%q<foca-integrity>, [">= 0"])
      s.add_dependency(%q<jstewart-yammer4r>, [">= 0"])
    end
  else
    s.add_dependency(%q<foca-integrity>, [">= 0"])
    s.add_dependency(%q<jstewart-yammer4r>, [">= 0"])
  end
end
