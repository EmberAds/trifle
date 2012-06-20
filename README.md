# Trifle

Stores the GeoIP databases in Redis and gives it a simple way to lookup IPs and map them to countries/country codes.

## Installation

Install the gem

```
gem install trifle
```

or add it to your Gemfile and bundle

```ruby
gem "trifle"
```

## Usage

### Loading

```ruby
# Initialize
trifle = Trifle.new(Redis.new)
# Load data from file
trifle.load filename: "file.csv"
# or files
trifle.load filenames: ["file1.csv", "file2.csv"]
# or directly as an array
trifle.load data: preloaded_array
```

### Lookup

```ruby
# Initialize
trifle = Trifle.new(Redis.new)

# Lookup for existing data
trifle.find "223.255.128.0"
# => ["HK", "Hong Kong"]

# Lookup for missing data
trifle.find "192.168.1.1"
# => nil
```



