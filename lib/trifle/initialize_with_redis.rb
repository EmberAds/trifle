class Trifle
  module InitializeWithRedis
    attr_accessor :redis
    attr_accessor :key

    def initialize redis, options = {}
      raise ArgumentError.new("Redis-like object expected") unless redis
      self.redis = redis
      self.key = options[:key] || "trifle"
    end
  end
end