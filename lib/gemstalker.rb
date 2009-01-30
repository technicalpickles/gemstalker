require 'net/http'

class GemStalker
  attr_accessor :username, :name, :repository, :version

  def initialize(options = {})
    @username   = options[:username]
    @name       = options[:name]
    @repository = options[:repository]
    @version    = options[:version]

  end

  def built?
    Net::HTTP.start('gems.github.com') {|http|
      req = Net::HTTP::Head.new(gem_path)
      response = http.request(req)
      return response.code == "200"
    }
  end

  def in_specfile?
    fetcher = Gem::SpecFetcher.new
    specs = fetcher.load_specs(URI.parse('http://gems.github.com/'), 'specs')
    specs.any? do |(name, spec)|
      name == @name && spec.version.to_s == @version
    end
  end

  protected

  def gem_path
    "/gems/#{@name}-#{@version}.gem"
  end
end
