require "trifle/initialize_with_redis"
require 'ipaddr'

class Trifle
  class Finder
    include InitializeWithRedis

    def handle ip
      ip_i = IPAddr.new(ip).native.to_i
      find(ip_i, 0, max)
    rescue ArgumentError => ex
      nil
    end

    protected

    def find ip_i, lower, upper
      index = (lower+upper)/2
      current = entry_for(index)

      return unless current

      if in_range(current, ip_i)
        current.last(2)
      elsif lower >= upper
        nil
      elsif ip_i < current[0]
        find ip_i, lower, index-1
      else
        find ip_i, index+1, upper
      end
    end

    def max
      redis.llen(key)-1
    end

    def entry_for index
      entry = redis.lindex(key, index)
      return unless entry
      entry = entry.split(":")
      entry[0] = entry[0].to_i
      entry[1] = entry[1].to_i
      entry
    end

    def in_range range, ip_i
      range[0] <= ip_i && ip_i <= range[1]
    end
  end
end
