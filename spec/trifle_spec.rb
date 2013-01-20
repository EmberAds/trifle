require "spec_helper"

describe Trifle do

  it "should extend InitializeWithRedis" do
    Trifle.included_modules.should include(Trifle::InitializeWithRedis)
  end

  describe "#load" do
    before do
      @redis = Redis.new
      @trifle = Trifle.new(@redis)
      @options = { :filenames => "foobar.csv" }
    end

    it "should pass this to the loader" do
      loader = mock Trifle::Loader
      Trifle::Loader.should_receive(:new).with(@redis, :key => @trifle.key).and_return(loader)
      loader.should_receive(:handle).with(@options)
      @trifle.load @options
    end
  end

  describe "#find" do
    before do
      @redis = Redis.new
      @trifle = Trifle.new(@redis)
      @ip = "127.0.0.1"
    end

    it "should pass this to the finder" do
      finder = mock Trifle::Finder
      Trifle::Finder.should_receive(:new).with(@redis, :key => @trifle.key).and_return(finder)
      finder.should_receive(:handle).with(@ip)
      @trifle.find @ip
    end
  end

end