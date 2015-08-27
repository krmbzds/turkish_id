# Turkish ID

This gem provides methods to validate Turkish Identification Numbers.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'turkish_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turkish_id

## Usage

Create a new instance:
```rb
identity_number = TurkishId.new('10000000146')
```
Use ```is_valid?``` method to check validity:

```rb
identity_number.is_valid?
=> true
```

## Anatomy of the Turkish ID Number

The Turkish Identification Number consists of ```11``` digits.

There are three conditions for a valid identification number:

1. ```d1 > 0```
2. ```d10 == ((d1 + d3 + d5 + d7 + d9) * 7 - (d2 + d4 + d6 + d8)) mod 10```
3. ```d11 == (d1 + d2 + d3 + d4 + d5 + d6 + d8 + d9 + d10) mod 10```

Where ```dn``` refers to the ```n-th``` digit of the identification number.

Remember that a valid identification number does not imply the existence of an ID. It could only be used as a preliminary check e.g. before querying a government website. This is very similar to credit card validation.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( http://github.com/krmbzds/turkish_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Bug reports and pull requests are welcome on GitHub at https://github.com/krmbzds/turkish_id.


## License

Copyright © 2015 Kerem Bozdaş

This gem is available under the terms of the [MIT License](https://github.com/krmbzds/turkish_id/blob/master/LICENSE.txt).
