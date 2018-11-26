# AdaptiveCards

An experimental ruby library to author [Adaptive Cards](https://docs.microsoft.com/en-us/adaptive-cards/)
for use with Microsoft and other tools.

For this experimental release only a few components are supported:

* AdaptiveCards v1.0
  * Containers
  * Text blocks
  * Fact sets
  * Columns
  * Open URL action

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'adaptive_cards'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adaptive_cards

## Usage

Create an adaptive card and add the elements you need to it, e.g.

```ruby
ac = AdaptivdCards::AdaptiveCard.new( lang: 'fr' )
                                .add( AdaptiveCards::TextBlock.new( 'Bonjour à tous', color: 'accent' )
                                .add( 'Plus d'informations ici' ) # Will be interpreted as text block
render json: ac.to_json
```

For simplicity all card elements accept their children via a simple `add`
method, avoiding the need to remember which elements they need.
`InvalidElementError` will be raised if you attempt to add a child that is not
valid for a particular element.

The library is focussed on allowing you to create valid cards based on the
Adaptive Card schema. It does not know or care about the ability of a
particular client (e.g. Teams) to successfully render all elements in a card.

All elements support all options defined in the Adaptive Card schema. Use
standard Ruby naming conventions for options, e.g.
```ruby
ac.select_action = AdaptiveCards::Action::OpenUrl.new( 'https://example.com/' )
```
These will be automatically converted to the correct camelCased form when you
serialize the card to a hash or JSON.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/transoceanic2000/adaptive_cards. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AdaptiveCards project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/adaptive_cards/blob/master/CODE_OF_CONDUCT.md).
