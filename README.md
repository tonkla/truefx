# TrueFX

The TrueFX API client for Crystal. Read [TrueFX](https://www.truefx.com/) for more information.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  truefx:
    github: tonkla/truefx
```

## Usage

TrueFX provides a price feed of these ten paris by default,  
EUR/USD, USD/JPY, GBP/USD, EUR/GBP, USD/CHF,  
EUR/JPY, EUR/CHF, USD/CAD, AUD/USD, GBP/JPY

```crystal
require "truefx"

feed = TrueFX::Feed.new
```

Get tick of the specific pair

```crystal
feed.get("EUR/USD")
```

Results in JSON

```json
[{\"symbol\":\"EUR/USD\",\"timestamp\":1485407262530,\"bid\":1.07581,\"offer\":1.07588,\"high\":1.0745,\"low\":1.07661,\"open\":1.0754}]
```

Get tick of more specific pairs, separate by comma

```crystal
feed.get("EUR/USD,USD/JPY")
```

Get ticks of all default pairs

```crystal
feed.get
```

Authorized session can access to more minor pairs. [Register](https://www.truefx.com)

AUD/CAD, AUD/CHF, AUD/JPY, AUD/NZD, CAD/CHF, CAD/JPY, CHF/JPY,  
EUR/AUD, EUR/CAD, EUR/NOK, EUR/NZD, GBP/CAD, GBP/CHF, NZD/JPY,  
NZD/USD, USD/NOK, USD/SEK

```crystal
feed = TrueFX::Feed.new(username: "USERNAME", password: "PASSWORD")
feed.get("AUD/JPY")
```

## Contributing

1. Fork it ( https://github.com/tonkla/truefx/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tonkla](https://github.com/tonkla) Surakarn Samkaew - creator, maintainer
