# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gemstalker}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Nichols"]
  s.date = %q{2009-02-09}
  s.default_executable = %q{stalk}
  s.description = %q{A library for determining if GitHub has built a gem yet}
  s.email = %q{josh@technicalpickles.com}
  s.executables = ["stalk"]
  s.files = ["LICENSE", "Rakefile", "README", "VERSION.yml", "bin/stalk", "lib/gemstalker.rb", "test/gemstalker_test.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/technicalpickles/gemstalker}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{GemStalker is a small library to determine if GitHub has built a gem yet.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
