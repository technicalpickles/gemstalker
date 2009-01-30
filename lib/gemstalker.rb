require 'net/http'

class GemStalker
  attr_accessor :username, :name, :repository, :version

  def initialize(options = {})
    @username   = options[:username]
    @repository = options[:repository]
    @version    = options[:version]

  end

  def built?
    Net::HTTP.start('gems.github.com') {|http|
      response = http.head(gem_path)
      response.code == "200"
    }
  end

  def in_specfile?
    fetcher = Gem::SpecFetcher.new
    specs = fetcher.load_specs(URI.parse('http://gems.github.com/'), 'specs')
    specs.any? do |(name, spec)|
      name == gem_name && spec.version.to_s == @version
    end
  end

  protected

  def gem_path
    "/gems/#{gem_name}-#{@version}.gem"
  end
  
  def gem_name
    "#{@username}-#{@repository}"
  end
end
