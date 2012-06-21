# Trifle

Stores the GeoIP databases in Redis and gives it a simple way to lookup IPs and map them to countries/country codes.

Get your GeoIP country CSVs from http://www.maxmind.com/app/geolite.

Trifle supports both the IPV4 and IPV6 databases.

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


## Release notes

* **0.0.2** Added support for custom Redis key
* **0.0.1** First draft



