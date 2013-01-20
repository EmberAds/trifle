# Trifle is a simple storage and lookup gem for GeoIP data
# using Redis as storage
require "trifle/loader"
require "trifle/finder"
require "trifle/initialize_with_redis"

class Trifle
  include InitializeWithRedis

  def load options = {}
    loader.handle options
  end

  def find ip
    finder.handle ip
  end

  protected

  def loader
    @loader = Loader.new(redis, :key => key)
  end

  def finder
    @finder = Finder.new(redis, :key => key)
  end
end
