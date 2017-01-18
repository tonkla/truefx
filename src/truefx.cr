# require "./truefx/*"

require "csv"
require "http/client"

module TrueFX
  struct Tick
    property symbol : String
    property timestamp : Int64
    property bid : Float64
    property offer : Float64
    property high : Float64
    property low : Float64
    property open : Float64

    def initialize
      @symbol = ""
      @timestamp = 0_i64
      @bid = 0.0
      @offer = 0.0
      @high = 0.0
      @low = 0.0
      @open = 0.0
    end
  end

  struct Feed
    property base_uri = "http://webrates.truefx.com/rates/connect.html?f=csv"

    def get
      ticks = [] of Tick
      csv = CSV.new(HTTP::Client.get(base_uri).body)
      while csv.next
        tick = Tick.new
        tick.symbol = csv[0]
        tick.timestamp = csv[1].to_i64
        tick.bid = (csv[2] + csv[3]).to_f64
        tick.offer = (csv[4] + csv[5]).to_f64
        tick.high = csv[6].to_f64
        tick.low = csv[7].to_f64
        tick.open = csv[8].to_f64
        ticks.push(tick)
      end
      ticks
    end

    def get(pairs)
      ticks = [] of Tick
      uri = base_uri + "&c=#{pairs}"
      csv = CSV.new(HTTP::Client.get(uri).body)
      while csv.next
        tick = Tick.new
        tick.symbol = csv[0]
        tick.timestamp = csv[1].to_i64
        tick.bid = (csv[2] + csv[3]).to_f64
        tick.offer = (csv[4] + csv[5]).to_f64
        tick.high = csv[6].to_f64
        tick.low = csv[7].to_f64
        tick.open = csv[8].to_f64
        ticks.push(tick)
      end
      ticks
    end
  end
end
