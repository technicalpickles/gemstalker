require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'ruby-debug'
require 'fake_web'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.dirname(__FILE__), '..', 'lib')
require 'gem_stalker'

FakeWeb.allow_net_connect = false
FakeWeb.register_uri 'http://gems.github.com:80/gems/technicalpickles-jeweler-0.8.1.gem',
                     :response => File.join(File.dirname(__FILE__), 'responses', 'technicalpickles-jeweler-0.8.1.gem')

FakeWeb.register_uri 'http://gems.github.com:80/specs.4.8.gz',
                     :response => File.join(File.dirname(__FILE__), 'responses', 'specs.4.8.gz')

FakeWeb.register_uri 'http://github.com:80/technicalpickles/jeweler/blob/master/jeweler.gemspec?raw=true',
                     :response => File.join(File.dirname(__FILE__), 'responses', 'jeweler.gemspec')

FakeWeb.register_uri 'http://gems.github.com:80/gems/technicalpickles-jeweler-0.9.3.gem',
                     :response => File.join(File.dirname(__FILE__), 'responses', 'technicalpickles-jeweler-0.9.3.gem')

FakeWeb.register_uri 'http://github.com:80/technicalpickles/bostonrb/blob/master/bostonrb.gemspec?raw=true',
                     :response => File.join(File.dirname(__FILE__), 'responses', 'bostonrb.gemspec')

FakeWeb.register_uri 'http://github.com:80/technicalpickles/bostonrb/tree/master',
                     :response => File.join(File.dirname(__FILE__), 'responses', 'bostonrb-tree-master')

FakeWeb.register_uri 'http://github.com:80/technicalpickles/jeweler/tree/master',
                     :response => File.join(File.dirname(__FILE__), 'responses', 'jeweler-tree-master')


class Test::Unit::TestCase
end
