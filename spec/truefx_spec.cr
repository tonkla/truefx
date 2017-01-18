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
      feed.get("EUR/USD").first.symbol.should eq("EUR/USD")
    end
  end

  describe "get ticks of the specific pairs" do
    it "works" do
      feed = TrueFX::Feed.new
      ticks = feed.get("EUR/USD,USD/JPY")
      ticks.first.symbol.should eq("EUR/USD")
      ticks.last.symbol.should eq("USD/JPY")
    end
  end
end
