# Coingecko - A CoinGecko API with CLI

Pushes all coin data from Coingecko API. Also lists top 100 coins and overall market info.

Disclaimer: This is my first published Ruby gem so any feedback is greatly welcomed!

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

```ruby

#Returns object with all Global Data from coingecko
Coingecko::Global.new_from_global

#Returns object with ALL available coins with id, symbol, name
Coingecko::Global.get_all_coins_list

#Returns top 100 coins objects only with id, symbol, name, market_cap_rank, last_updated. Default currency is "usd" if no currency given. E.g.
Coingecko::Coin.new_from_top_100

#Returns a particular coin object with ALL avaiable data from Coingecko. It needs an id as an argument. E.g.
Coingecko::Coin.get_coin("bitcoin")


```
## CLI Usage

A CLI console is provided to see an example of the methods in action. You need to have **terminal-table gem** installed for correct display of output. You can do one of the following to launch the CLI:

```ruby
Coingecko::CLI.new.run
```
or to launch directly:

```ruby
ruby bin/coingecko
```

## Development 

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fbohz/coingecko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Coingecko project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'courageoustuple'/coingecko/blob/master/CODE_OF_CONDUCT.md).
