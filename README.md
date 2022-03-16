# Turkish ID 🔖

[![Status](https://img.shields.io/github/workflow/status/krmbzds/turkish_id/Test/master)](https://github.com/krmbzds/turkish_id/actions/workflows/test.yml)
[![Coverage](https://img.shields.io/coveralls/github/krmbzds/turkish_id)](https://coveralls.io/github/krmbzds/turkish_id)
[![Downloads](https://img.shields.io/gem/dt/turkish_id.svg)](https://rubygems.org/gems/turkish_id)
[![Dependencies](https://img.shields.io/badge/dependencies-none-brightgreen.svg)](https://rubygems.org/gems/turkish_id)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/krmbzds/turkish_id)](https://codeclimate.com/github/krmbzds/turkish_id)
[![Version](https://img.shields.io/gem/v/turkish_id.svg)](https://github.com/krmbzds/turkish_id)
[![Docs](https://img.shields.io/badge/rubydoc-info-blue.svg)](https://www.rubydoc.info/gems/turkish_id)

This gem provides methods to validate Turkish Identification Numbers.

## Installation

Add this line to your application's Gemfile:

```rb
gem 'turkish_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turkish_id

## Usage

### Validating ID Numbers

Create a new instance:

```rb
identity_number = TurkishId.new(10000000146)
```

Use ```valid?``` method to check validity:

```rb
identity_number.valid?  #=> true
```

Or use the command line executable:

```sh
$ turkish_id 10000000078  #=> true
$ echo $?                 #=> 0
$ turkish_id 10000000079  #=> false
$ echo $?                 #=> 1
```

### Generating Relatives

You can generate ID numbers for your younger or elder relatives.

```rb
me = TurkishId.new(10000000146)
```

Calling `younger_relative` or `elder_relative` will return an Enumerable class.

```rb
me.elder_relative  #=> #<Enumerator:0x00007f9e629032d0>
```

You can perform standard Enumerable operations on it.

```rb
me.elder_relative.first  #=> 10003000082
```

```rb
3.times do
 puts me.elder_relative.next
end

#=> 10035998982
#=> 10005999902
#=> 10008999848
```

```rb
me.elder_relative.take(5)  #=> [10003000082, 10005999902, 10008999848, 10011999774, 10014999610]
```

And so on.

## Anatomy of the Turkish ID Number

The Turkish Identification Number consists of ```11``` digits.

There are three conditions for a valid identification number:

1. ```d1 > 0```
2. ```d10 == ((d1 + d3 + d5 + d7 + d9) * 7 - (d2 + d4 + d6 + d8)) mod 10```
3. ```d11 == (d1 + d2 + d3 + d4 + d5 + d6 + d8 + d9 + d10) mod 10```

Where ```dn``` refers to the ```n-th``` digit of the identification number.

Remember that a valid identification number does not imply the existence of an ID. It could only be used as a preliminary check e.g. before querying a government website. This is very similar to credit card validation.

## Support

#### Ruby Versions Tested Against

This gem is used in production and tested against the following Ruby versions:

- ✅ `3.1.1` (stable)
- ✅ `3.0.3` (stable)
- ✅ `2.7.5` (stable)
- ⏳ `2.6.9` (security maintenance)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org][RubyGems].

## Contributing

1. [Fork the repository][Fork]
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Donations ❤️

You can donate me at [Liberapay][Donation]. Thanks! ☕️

## Is it any good?

Yes.

## License

Copyright © 2015-2022 [Kerem Bozdas][Personal Webpage]

This gem is available under the terms of the [MIT License][License].

[Donation]: https://liberapay.com/krmbzds/donate
[Fork]: https://github.com/krmbzds/turkish_id/fork
[License]: https://kerem.mit-license.org
[Personal Webpage]: https://kerembozdas.com
[RubyGems]: https://rubygems.org
