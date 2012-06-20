require_relative "initialize_with_redis"

class Trifle
  class Finder
    include InitializeWithRedis

    def handle ip
    end
  end
end