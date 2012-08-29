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
      ["223.255.255.0","223.255.255.255","3758096128","3758096383","AU","Australia"],
      ["2407:7800::", "2407:7800:ffff:ffff:ffff:ffff:ffff:ffff", "47890987815419153418387641314551267328", "47890987894647315932651978908095217663", "AU", "Australia"],
      ["2407:8400::", "2407:8400:ffff:ffff:ffff:ffff:ffff:ffff", "47891231204334397238432728681566699520", "47891231283562559752697066275110649855", "AU", "Australia"],
      ["2407:8600::", "2407:8600:ffff:ffff:ffff:ffff:ffff:ffff", "47891271769153604541773576576069271552", "47891271848381767056037914169613221887", "AU", "Australia"],
      ["2407:8800::", "2407:8800:ffff:ffff:ffff:ffff:ffff:ffff", "47891312333972811845114424470571843584", "47891312413200974359378762064115793919", "IN", "India"],
      ["2407:8e00::", "2407:8e00:ffff:ffff:ffff:ffff:ffff:ffff", "47891434028430433755136968154079559680", "47891434107658596269401305747623510015", "AU", "Australia"],
      ["2407:9000::", "2407:9000:ffff:ffff:ffff:ffff:ffff:ffff", "47891474593249641058477816048582131712", "47891474672477803572742153642126082047", "AU", "Australia"],
      ["2407:a200::", "2407:a200:ffff:ffff:ffff:ffff:ffff:ffff", "47891839676622506788545447099105280000", "47891839755850669302809784692649230335", "AU", "Australia"],
      ["2407:aa00::", "2407:aa00:ffff:ffff:ffff:ffff:ffff:ffff", "47892001935899336001908838677115568128", "47892002015127498516173176270659518463", "AU", "Australia"],
      ["2407:ae00::", "2407:ae00:ffff:ffff:ffff:ffff:ffff:ffff", "47892083065537750608590534466120712192", "47892083144765913122854872059664662527", "AU", "Australia"],
    ]
    @redis = Redis.new
    @trifle = Trifle.new(@redis)
    @finder = Trifle::Finder.new(@redis)
    @trifle.load(data: @valid_data)
  end

  describe "#handle" do
    it "should find the right entry" do
      @finder.handle("223.255.128.0").should be == ["HK", "Hong Kong"]
      @finder.handle("223.255.244.10").should be == ["IN", "India"]
      @finder.handle("223.255.255.255").should be == ["AU","Australia"]
      @finder.handle("2407:8800:ffff:ffff:ffff:ffff:ffff:ffff").should be == ["IN","India"]
      @finder.handle("2407:ae00:ffff:ffff:ffff:ffff:ffff:ffff").should be == ["AU","Australia"]
    end

    it "should return nil if the entry wasn't found" do
      @finder.handle("127.0.0.1").should be_nil
    end

    it "should not fail if there's only 1 record" do
      @trifle.load(data: [["82.132.242.55","82.132.242.55","1384444471","1384444471","GB","United Kingdrom"]])
      @finder.handle("127.0.0.1").should be_nil
    end

    it "should handle nil ips" do
      @finder.handle(nil).should be_nil
    end
  end

end