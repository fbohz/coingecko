# Coingecko - A CoinGecko API with CLI Interface

Pushes all coin data from Coingecko API. Also lists top 100 coins.

Disclaimer: This is my first Ruby gem so any feedback is greatly welcomed!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coingecko'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coingecko

## Usage

A CLI console is provided to lookup coins or list top 100 coins. It also provides a print feature of basic coin attributes. However, all coin attributes can be read as it pulls directly from Coingecko API. To launch the console just launch it from bin folder E.g.

```ruby
ruby bin/coingecko
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'courageoustuple'/coingecko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Coingecko project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'courageoustuple'/coingecko/blob/master/CODE_OF_CONDUCT.md).
