require "trifle/initialize_with_redis"
require "fastercsv"
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

    def tmp_key
      "#{key}:tmp"
    end

    def clear
      redis.del key
    end

    protected

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
      move
    end

    def append row
      entry = row.values_at(2,3,4,5).join(":")
      redis.rpush tmp_key, entry
    end

    def sort data
      data.sort {|a,b| a[2] <=> b[2] }
    end

    def parse contents
      contents.gsub!('", "', '","')
      csv = RUBY_VERSION =~ /^1\.8/ ? FasterCSV : CSV
      csv.parse(contents)
    end

    def valid? data
      if data.is_a?(Array) && data.count > 0
        return data.detect {|row| !is_number(row[2]) || !is_number(row[3])}.nil?
      end
      false
    end

    def is_number field
      field.is_a?(Numeric) || field =~ /^\d+$/
    end

    def move
      redis.rename tmp_key, key
    end
  end
end