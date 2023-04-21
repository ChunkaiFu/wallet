# -*- encoding: utf-8 -*-
# stub: has_scope 0.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "has_scope".freeze
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/heartcombo/has_scope/issues", "changelog_uri" => "https://github.com/heartcombo/has_scope/blob/main/CHANGELOG.md", "homepage_uri" => "https://github.com/heartcombo/has_scope", "source_code_uri" => "https://github.com/heartcombo/has_scope" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jos\u00E9 Valim".freeze]
  s.date = "2023-02-04"
  s.description = "Maps controller filters to your resource scopes".freeze
  s.email = "opensource@plataformatec.com.br".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "http://github.com/plataformatec/has_scope".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.4.6".freeze
  s.summary = "Maps controller filters to your resource scopes.".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 5.2"])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.2"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_development_dependency(%q<mocha>.freeze, ["~> 1.0.0"])
end
