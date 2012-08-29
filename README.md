# Trifle

![Build status](https://secure.travis-ci.org/EmberAds/trifle.png?branch=master)

Stores the GeoIP databases in Redis and gives it a simple way to lookup IPs and map them to countries/country codes.

Get your GeoIP country CSVs from http://www.maxmind.com/app/geolite.

Trifle supports both the IPV4 and IPV6 databases.

## Why?

Loading the GeoIP databases from disk is slow, and doing that for every request is a pain. Trifle keeps your GeoIP database in memory and makes it easy to query.

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

Additionally you can specify your own Redis key to store the Trifle in:

```ruby
trifle = Trifle.new(Redis.new, key: "foobar")
```

You can also load the Trifle from the command line:

```
trifle redis://127.0.0.1:6379/0 file1.csv file2.csv
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

* **0.0.8** Fixed a search bug that created conflicts between IPv4 and IPv6 data
* **0.0.7** Loading now happens into separate key, making loading possible without downtime
* **0.0.6** Added a fix for invalid IPs
* **0.0.5** Fixed bug when finding IPs at the edge of the data set
* **0.0.4** Changed binary syntax
* **0.0.3** Added a binary for loading Trifle from the command line
* **0.0.2** Added support for custom Redis key
* **0.0.1** First draft

## Future releases

* Allow for loading of more data than just country data
* Split country data into separate Redis records

## License

See LICENSE

