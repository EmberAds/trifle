class Trifle
  class Loader
    class Sanitizer
      def process data
        categorised_data = categorise(data)
        strip(categorised_data)
      end

      def categorise data
        data.inject(Hash.new) do |h, set|
          key = :country
          if set[0] == ["startIpNum","endIpNum","locId"]
            key = :city_blocks
          elsif  set[0] == ["locId","country","region",'city',"postalCode","latitude","longitude","metroCode","areaCode"]
            key = :city_locations
          end
          h[key] ||= []
          h[key] += set
          h
        end
      end

      def strip data
        data.inject(Hash.new) do |h, (key, set)|
          h[key] = clean(set, key)
          h
        end
      end

      def clean set, type
        case type
        when :country
          set.map do |row|
            row.shift(2)
            row[0] = row[0].to_i
            row[1] = row[1].to_i
            row
          end
        when :city_blocks
          set.shift
          set.map do |row|
            row.map{|element| element.to_i }
          end
        when :city_locations
          set.shift
          set
        end
      end
    end
  end
end