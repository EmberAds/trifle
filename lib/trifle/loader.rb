require_relative "initialize_with_redis"
require "csv"

class Trifle
  class Loader
    include InitializeWithRedis

    def handle options = {}
      if options[:filename]
        load_files [options[:filename]]
      elsif options[:filenames]
        load_files options[:filenames]
      elsif options[:data]
        load_data options[:data]
      else
        raise ArgumentError.new("Please provide a :filename, :filenames or an array of :data as an argument.")
      end
    end

    def load_files filenames
      raise ArgumentError.new("filenames must be an array of strings") unless filenames.is_a?(Array) && !filenames.map{|element| element.is_a?(String)}.include?(false)

      data = []
      filenames.each do |filename|
        contents = File.open(filename, "rb").read
        data += parse(contents)
      end
      load_data data
    end

    def load_data data
      raise ArgumentError.new("data must be an array as loaded from a GeoIP data set") unless valid?(data)
      clear
      sort(data)
      data.each {|row| append(row) }
    end

    def append row
      entry = row.values_at(2,3,4,5).join(":")
      redis.rpush Trifle::KEY, entry
    end

    def sort data
      data.sort {|a,b| a[2] <=> b[2] }
    end

    def parse contents
      contents.gsub!('", "', '","')
      CSV.parse(contents)
    end

    def valid? data
      if data.is_a?(Array) && data.count > 0
        return data.map do |row|
          is_number(row[2]) && is_number(row[3])
        end.select{|valid| !valid}.count == 0
      end
      false
    end

    def is_number field
      field.is_a?(Numeric) || field =~ /^\d+$/
    end

    def clear
      redis.del(Trifle::KEY)
    end
  end
end