# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trifle/version"

Gem::Specification.new do |s|
  s.name        = "trifle"
  s.version     = Trifle::VERSION
  s.authors     = ["Cristiano Betta"]
  s.email       = ["cristiano@emberads.com"]
  s.homepage    = "http://emberads.com"
  s.summary     = "A GeoIP lookup in Redis"
  s.description = "Stores the GeoIP databases in Redis and gives it a simple way to lookup IPs and map them to countries"

  s.rubyforge_project = "trifle"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rujitsu'
  s.add_development_dependency 'active_support'
  s.add_development_dependency "fakeredis", "~> 0.3.0"
end
