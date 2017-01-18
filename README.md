# TrueFX

The TrueFX API client for Crystal. Visit [TrueFX](https://www.truefx.com/) for more information.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  truefx:
    github: tonkla/truefx
```

## Usage

```crystal
require "truefx"

feed = TrueFX::Feed.new

# get ticks of all pairs by unauthorized session
feed.get

# get tick of the specific pair by unauthorized session
feed.get("EUR/USD")

# get ticks of the specific pairs by unauthorized session
feed.get("EUR/USD,USD/JPY")

feed = TrueFX::Feed.new
tick = feed.get("EUR/USD").first
tick.class # TrueFX::Tick
```

## Contributing

1. Fork it ( https://github.com/tonkla/truefx/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tonkla](https://github.com/tonkla) Surakarn Samkaew - creator, maintainer
