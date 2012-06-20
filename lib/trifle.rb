# Trifle is a simple storage and lookup gem for GeoIP data
# using Redis as storage
require "trifle/loader"
require "trifle/finder"
require "trifle/initialize_with_redis"

class Trifle
  include InitializeWithRedis

  KEY = "triffle".freeze

  def load options = {}
    loader.handle options
  end

  def find ip
    finder.handle ip
  end

  protected

  def loader
    @loader = Loader.new(redis)
  end

  def finder
    @finder = Finder.new(redis)
  end
end