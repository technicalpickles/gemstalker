require 'net/http'
require 'rubygems/spec_fetcher'
require 'git'

# Small class for determining if a gem has been built on GitHub and if it's installable.
class GemStalker
  attr_accessor :username, :name, :repository, :version

  # Accepts the following options:
  #
  # username::   GitHub username
  # repository:: repository name
  # version::    version to stalk. Defaults to checking the repository for a
  #               gemspec to determine the latest version.
  def initialize(options = {})
    @username   = options[:username]
    @repository = options[:repository]
    unless @username && @repository
      @username, @repository = determine_username_and_repository
    end

    @version    = options[:version] || determine_version


  end

  # Is it built yet?
  def built?
    Net::HTTP.start('gems.github.com') {|http|
      response = http.head(gem_path)
      response.code == "200"
    }
  end
  
  # Is RubyGem building enabled for the repository?
  def gem?
    Net::HTTP.start('github.com') {|http|
      res = http.get(master_path)
      return res.body =~ /alt\=.Rubygem./ if res.code == "200"
    }
    false
  end

  # Is it in the specs yet? ie is it installable yet?
  def in_specfile?
    fetcher = Gem::SpecFetcher.new
    specs = fetcher.load_specs(URI.parse('http://gems.github.com/'), 'specs')
    specs.any? do |(name, spec)|
      name == gem_name && spec.version.to_s == @version
    end
  end

  def install
    sudo = RUBY_PLATFORM =~ /mswin32/ ? '' : 'sudo'
    wget = "wget http://gems.github.com/#{gem_path}"
    install = "#{sudo} gem install #{gem_name}-#{@version}.gem"
    system "#{wget}; #{install}"
  end
  
  # Path to edit the repository
  def edit_repo_url
    "http://github.com/#{@username}/#{@repository}/edit"
  end

  def gem_path
    "/gems/#{gem_name}-#{@version}.gem"
  end
  
  protected

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

  def determine_username_and_repository
    git = Git.open(Dir.pwd)

    origin_url = git.remote('origin').url
    origin_url =~ /git@github\.com:(.*)\/(.*)\.git/

    username, repository = $1, $2
  end
end
