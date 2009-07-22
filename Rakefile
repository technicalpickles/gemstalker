require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "gemstalker"
    gem.summary = "GemStalker is a small library to determine if GitHub has built a gem yet."
    gem.email = "josh@technicalpickles.com"
    gem.homepage = "http://github.com/technicalpickles/gemstalker"
    gem.description = "A library for determining if GitHub has built a gem yet"
    gem.authors = ["Josh Nichols"]
    gem.files =  FileList["[A-Z]*", "{bin,lib,test}/**/*"] 
    gem.add_dependency "git"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |test|
  test.libs << 'lib'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'gemstalker'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |rcov|
    rcov.libs << 'test'
    rcov.test_files = FileList['test/**/*_test.rb']
    rcov.verbose = true
  end
rescue LoadError
end

task :default => :test
