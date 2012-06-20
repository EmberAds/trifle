require "spec_helper"

describe Trifle::Finder do

  before do
    @valid_data = [
      ["223.255.128.0","223.255.191.255","3758063616","3758079999","HK","Hong Kong"],
      ["223.255.192.0","223.255.223.255","3758080000","3758088191","KR","Korea, Republic of"],
      ["223.255.224.0","223.255.231.255","3758088192","3758090239","ID","Indonesia"],
      ["223.255.232.0","223.255.235.255","3758090240","3758091263","AU","Australia"],
      ["223.255.236.0","223.255.239.255","3758091264","3758092287","CN","China"],
      ["223.255.240.0","223.255.243.255","3758092288","3758093311","HK","Hong Kong"],
      ["223.255.244.0","223.255.247.255","3758093312","3758094335","IN","India"],
      ["223.255.248.0","223.255.251.255","3758094336","3758095359","AU","Australia"],
      ["223.255.252.0","223.255.253.255","3758095360","3758095871","CN","China"],
      ["223.255.254.0","223.255.254.255","3758095872","3758096127","SG","Singapore"],
      ["223.255.255.0","223.255.255.255","3758096128","3758096383","AU","Australia"]
    ]
    @redis = Redis.new
    trifle = Trifle.new(@redis)
    @finder = Trifle::Finder.new(@redis)
    trifle.load(data: @valid_data)
  end

  describe "#handle" do
    it "should find the right entry" do
      @finder.handle("223.255.128.0").should be == ["HK", "Hong Kong"]
      @finder.handle("223.255.244.10").should be == ["IN", "India"]
      @finder.handle("223.255.255.255").should be == ["AU","Australia"]
    end

    it "should return nil if the entry wasn't found" do
      @finder.handle("127.0.0.1").should be_nil
    end
  end

end