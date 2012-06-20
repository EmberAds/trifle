class Trifle
  module InitializeWithRedis
    attr_accessor :redis

    def initialize redis
      raise ArgumentError.new("Redis-like object expected") unless redis
      self.redis = redis
    end
  end
end