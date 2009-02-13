require 'net/http'
require 'rubygems/spec_fetcher'

class GemStalker
  attr_accessor :username, :name, :repository, :version

  def initialize(options = {})
    @username   = options[:username]
    @repository = options[:repository]
    @version    = options[:version] || determine_version

  end

  def built?
    Net::HTTP.start('gems.github.com') {|http|
      response = http.head(gem_path)
      response.code == "200"
    }
  end
  
  def gem?
    Net::HTTP.start('github.com') {|http|
      res = http.get(master_path)
      return res.body =~ /alt\=.Rubygem./ if res.code == "200"
    }
    false
  end

  def in_specfile?
    fetcher = Gem::SpecFetcher.new
    specs = fetcher.load_specs(URI.parse('http://gems.github.com/'), 'specs')
    specs.any? do |(name, spec)|
      name == gem_name && spec.version.to_s == @version
    end
  end

  def edit_repo_url
    "http://github.com/#{@username}/#{@repository}/edit"
  end

  protected

  def gem_path
    "/gems/#{gem_name}-#{@version}.gem"
  end
  
  def gem_name
    "#{@username}-#{@repository}"
  end

  def gemspec_path
    # TODO this seems very unfuture proof, and also specific to master branch...
    "/#{@username}/#{@repository}/blob/master/#{@repository}.gemspec?raw=true"
  end

  def master_path
    "/#{@username}/#{@repository}/tree/master"
  end



  def determine_version
    res = nil
    Net::HTTP.start('github.com') {|http|
      res = http.get(gemspec_path)
    }

    if res.code == "200"
      gemspec_file = res.body
      gemspec = nil
      # TODO this assumes Ruby format, but GitHub is cool with YAML
      Thread.new { gemspec = eval("$SAFE = 3\n#{gemspec_file}") }.join
      gemspec.version.to_s
    end
  end
  
end
