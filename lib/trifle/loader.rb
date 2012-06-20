require_relative "initialize_with_redis"

class Trifle
  class Loader
    include InitializeWithRedis

    def handle options = {}
     if options[:filename]
       load_file options[:filename]
     elsif options[:data]
       load_data [:data]
     else
       raise ArgumentError.new("Please provide a :filename or an array of :data as an argument.")
     end
   end

   def load_file filename
     raise ArgumentErrror.new("filename must be a string") unless filename.is_a?(String)
     contents = File.open(filename, "rb").read
     data = parse(contents)
     load_data data
   end

   def load_data data
     raise ArgumentError.new("data must be an array as loaded from a GeoIP data set") unless valid?(data)
   end

   def parse contents

   end

   def valid?(data)
     true
   end
  end
end