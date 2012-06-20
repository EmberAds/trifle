require "spec_helper"

describe Trifle::InitializeWithRedis do

  describe "#initialize" do
    before do
      @klass = Class.new do
        include Trifle::InitializeWithRedis
      end
    end

    it "should accept a redis instance" do
      @klass.new(Redis.new).should be_a(@klass)
    end

    it "should fail without a redis instance" do
      -> { @klass.new(nil) }.should raise_error(ArgumentError)
    end

    it "should accept an optional redis key" do
      instance = @klass.new(Redis.new, key: "foo")
      instance.key.should be == "foo"
    end
  end

end