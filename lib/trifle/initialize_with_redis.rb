class Trifle
  module InitializeWithRedis
    attr_accessor :redis

    def initialize redis
      raise ArgumentError.new("Redis object expected") unless redis.is_a?(Redis)
      self.redis = redis
    end
  end
end