require "spec_helper"

describe Trifle do

  it "should extend InitializeWithRedis" do
    Trifle.included_modules.should include(Trifle::InitializeWithRedis)
  end

  describe "#load" do
    before do
      @trifle = Trifle.new(Redis.new)
      @options = { filename: "foobar.csv" }
    end

    it "should pass this to the loader" do
      loader = mock Trifle::Loader
      Trifle::Loader.should_receive(:new).and_return(loader)
      loader.should_receive(:handle).with(@options)
      @trifle.load @options
    end
  end

  describe "#find" do
    before do
      @trifle = Trifle.new(Redis.new)
      @ip = "127.0.0.1"
    end

    it "should pass this to the finder" do
      finder = mock Trifle::Finder
      Trifle::Finder.should_receive(:new).and_return(finder)
      finder.should_receive(:handle).with(@ip)
      @trifle.find @ip
    end
  end

end