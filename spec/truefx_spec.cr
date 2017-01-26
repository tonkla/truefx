require "json"
require "./spec_helper"

describe TrueFX do
  describe "get ticks of all pairs" do
    it "works" do
      feed = TrueFX::Feed.new
      feed.get.empty?.should be_false
    end
  end

  describe "get tick of the specific pair" do
    it "works" do
      feed = TrueFX::Feed.new
      JSON.parse(feed.get("EUR/USD")).first["symbol"].should eq("EUR/USD")
    end
  end

  describe "get ticks of the specific pairs" do
    it "works" do
      feed = TrueFX::Feed.new
      ticks = JSON.parse(feed.get("EUR/USD,USD/JPY"))
      ticks[0]["symbol"].should eq("EUR/USD")
      ticks[1]["symbol"].should eq("USD/JPY")
    end
  end

  describe "get the secret pair with unauthorized session" do
    it "gets empty" do
      feed = TrueFX::Feed.new
      ticks = JSON.parse(feed.get("AUD/JPY"))
      ticks.size.should eq(0)
    end
  end
end
