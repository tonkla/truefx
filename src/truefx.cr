# require "./truefx/*"

require "csv"
require "http/client"
require "json"

module TrueFX
  struct Tick
    property symbol : String
    property timestamp : Int64
    property bid : Float64
    property offer : Float64
    property high : Float64
    property low : Float64
    property open : Float64
    property spread : Float64

    def initialize
      @symbol = ""
      @timestamp = 0_i64
      @bid = 0.0
      @offer = 0.0
      @high = 0.0
      @low = 0.0
      @open = 0.0
      @spread = 0.0
    end

    def to_json(json : JSON::Builder)
      json.object do
        json.field "symbol", self.symbol
        json.field "timestamp", self.timestamp
        json.field "bid", self.bid
        json.field "offer", self.offer
        json.field "high", self.high
        json.field "low", self.low
        json.field "open", self.open
        json.field "spread", self.spread
      end
    end
  end

  struct Feed
    property username = ""
    property password = ""
    property session  = ""

    # They provide HTTPS on `*.truefx.com`, when use it, we will get this
    # error:14077410:SSL routines:SSL23_GET_SERVER_HELLO:sslv3 alert handshake failure
    property base_uri = "http://webrates.truefx.com/rates/connect.html?f=csv"

    def initialize
    end

    def initialize(username, password)
      @username = username
      @password = password
    end

    def get
      fetch base_uri
    end

    def get(pairs)
      fetch base_uri + "&c=#{pairs}"
    end

    private def fetch(uri)
      if @session.empty? && !@username.empty? && !@password.empty?
        _uri = uri + "&u=#{@username}&p=#{@password}&q=eurates"
        session = HTTP::Client.get(_uri).body.strip
        @session = session unless session == "not authorized"
      end
      uri += "&id=#{@session}" unless @session.empty?

      ticks = [] of Tick
      csv = CSV.new(HTTP::Client.get(uri).body.strip)
      while csv.next
        tick = Tick.new
        tick.symbol = csv[0]
        tick.timestamp = csv[1].to_i64
        tick.bid = (csv[2] + csv[3]).to_f64
        tick.offer = (csv[4] + csv[5]).to_f64
        tick.high = csv[6].to_f64
        tick.low = csv[7].to_f64
        tick.open = csv[8].to_f64
        tick.spread = calc_spread tick
        ticks.push tick
      end
      ticks.to_json
    end

    private def calc_spread(tick)
      if tick.symbol.includes? "JPY"
        (tick.offer - tick.bid).round(5) * 100
      else
        (tick.offer - tick.bid).round(5) * 10000
      end
    end
  end
end
