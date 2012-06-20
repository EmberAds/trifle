require "spec_helper"

describe Trifle::Loader do

  it "should extend InitializeWithRedis" do
    Trifle::Loader.included_modules.should include(Trifle::InitializeWithRedis)
  end

  describe "#handle" do
    context "when given the :filename option" do
      it "should pass it on to load_file"
    end

    context "when given the :data option" do
      it "should pass it on to load_data"
    end

    context "when given anything else" do
      it "should raise an error"
    end
  end

  describe "#load_file" do
    context "when given a valid file" do
      it "should load the file"
      it "should parse the file as csv"
      it "should pass the data to load_data"
    end

    context "when given anything but a string" do
      it "should raise an error"
    end

    context "when given a filename for a file that's missing" do
      it "should raise an error"
    end

    context "when given a filename for a file that has invalid data" do
      it "should raise an error"
    end
  end

  describe "#load_data" do
    context "when given valid data" do
      it "should validate the data"
      it "should load it in redis"
      it "should append to existing data"
    end

    context "when given invalid data" do
      it "should raise an error"
    end

    context "when given anything but an array" do
      it "should raise an error"
    end
  end

  describe "#parse" do
    it "should parse valid csv data"
    it "should raise an error for invalid csv data"
  end

  describe "#valid?" do
    it "should mark valid data as such"
    it "should mark invalid data as such"
  end

  describe "#clear" do
    it "should clear existing data"
  end

end