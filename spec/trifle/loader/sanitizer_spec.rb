require "spec_helper"
require 'active_support/core_ext/string/strip'

describe Trifle::Loader::Sanitizer do

  before do
    @sanitizer = Trifle::Loader::Sanitizer.new

    @country_data_ipv4 = [
      ["223.255.254.0","223.255.254.255","3758095872","3758096127","SG","Singapore"],
      ["223.255.255.0","223.255.255.255","3758096128","3758096383","AU","Australia"]
    ]

    @country_data_ipv6 = [
      ["2c0f:ffe8::", "2c0f:ffe8:ffff:ffff:ffff:ffff:ffff:ffff", "58569106662796955307479896348547874816", "58569106742025117821744233942091825151", "NG", "Nigeria"],
      ["2c0f:fff0::", "2c0f:fff0:ffff:ffff:ffff:ffff:ffff:ffff", "58569107296622255421594597096899477504", "58569107375850417935858934690443427839", "NG", "Nigeria"]
    ]

    @city_data_block = [
      ["startIpNum","endIpNum","locId"],
      ["7602176","7864319","16"],
      ["16777216","16777471","17"],
      ["16777472","16777727","24328"],
      ["16777728","16778239","49"],
      ["16778240","16779263","17"]
    ]

    @city_data_location = [
      ["locId","country","region",'city',"postalCode","latitude","longitude","metroCode","areaCode"],
      ["1","O1","","","","0.0000","0.0000"],
      ["2","AP","","","","35.0000","105.0000"],
      ["3","EU","","","","47.0000","8.0000"],
      ["364590","US","CO","Copper Mountain","80443","39.5067","-106.1422","751","970"],
      ["365328","CA","NB","Saint Anthony","","46.3667","-64.7500"],
      ["365329","RU","71","Studencheskiy","","56.6965","61.2622"],
      ["365330","NL","06","Brakkenstraat","","51.5500","4.6500"]
    ]

    @data = [
      @country_data_ipv4,
      @country_data_ipv6,
      @city_data_block,
      @city_data_location
    ]

    @cleaned_data = {
      country: [
        [3758095872,3758096127,"SG","Singapore"],
        [3758096128,3758096383,"AU","Australia"],
        [58569106662796955307479896348547874816, 58569106742025117821744233942091825151, "NG", "Nigeria"],
        [58569107296622255421594597096899477504, 58569107375850417935858934690443427839, "NG", "Nigeria"]
      ],
      city_blocks: [
        [7602176,7864319,16],
        [16777216,16777471,17],
        [16777472,16777727,24328],
        [16777728,16778239,49],
        [16778240,16779263,17]
      ],
      city_locations: [
        ["1","O1","","","","0.0000","0.0000"],
        ["2","AP","","","","35.0000","105.0000"],
        ["3","EU","","","","47.0000","8.0000"],
        ["364590","US","CO","Copper Mountain","80443","39.5067","-106.1422","751","970"],
        ["365328","CA","NB","Saint Anthony","","46.3667","-64.7500"],
        ["365329","RU","71","Studencheskiy","","56.6965","61.2622"],
        ["365330","NL","06","Brakkenstraat","","51.5500","4.6500"]
      ]
    }
  end

  describe "#process" do
    it "should combine and sort the data" do
      @sanitizer.process(@data).should be_eql(@cleaned_data)
    end
  end

  describe "#categorise" do
    it "should categorise the data" do
      @sanitizer.categorise(@data).should be == {
        country: (@country_data_ipv4+@country_data_ipv6),
        city_blocks: @city_data_block,
        city_locations: @city_data_location }
    end
  end

  describe "#strip" do
    it "should remove unnessesary info from the files" do
      @sanitizer.strip(@sanitizer.categorise(@data)).should be_eql(@cleaned_data)
    end
  end

end