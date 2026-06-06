# Passcraft

Passcraft is a secure, flexible, and easy-to-use password generator and analyzer library for Ruby. It utilizes cryptographically secure random number generation (`SecureRandom`) to build high-entropy passwords and helps you measure password strength by calculating scores, ratings, entropy, and providing improvement feedback.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'passcraft'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install passcraft

## Usage

### Password Generation

You can generate passwords easily with the default configurations or customize the parameters.

```ruby
require 'passcraft'

# 1. Generate a password with default settings (16 characters, all character pools enabled)
password = Passcraft.generate
# => "aB3$eF7*iJ0!mN3#"

# 2. Customize length
password = Passcraft.generate(length: 24)
# => "p$9K#m2W!z_Q8&vR3*tB5^yN"

# 3. Enable or disable specific character sets
password = Passcraft.generate(
  uppercase: true,
  lowercase: true,
  numbers: false,
  symbols: false
)
# => "xHkLzQwPaSdFgHjK"

# 4. Exclude visually similar characters (1, I, l, 0, O, o)
password = Passcraft.generate(exclude_similar: true)

# 5. Use a custom symbol set
password = Passcraft.generate(
  symbols: true,
  custom_symbols: "@#$%"
)
# => "aB3$eF7@iJ%!mN3#"
```

### Password Strength Analysis

You can evaluate any password using `Passcraft.strength`. It returns a hash with numerical score, verbal rating, informational entropy (in bits), and list of actionable hints.

```ruby
require 'passcraft'

result = Passcraft.strength("Password123")
# => {
#      score: 3,
#      rating: :strong,
#      entropy: 71.93,
#      feedback: ["Add symbols"]
#    }

result = Passcraft.strength("12345")
# => {
#      score: 0,
#      rating: :weak,
#      entropy: 16.61,
#      feedback: [
#        "Add lowercase letters",
#        "Add uppercase letters",
#        "Add symbols",
#        "Make it longer (at least 12 characters)"
#      ]
#    }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MiyoshiLight/passcraft.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
