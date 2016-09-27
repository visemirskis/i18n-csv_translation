# I18n::CsvTranslation

Ever needed to add a new locale to an existing (Rails) project with dozens of .yml files? Too afraid to give all files to the customer or translation service and hope they do not mess up the YAML format?

This gem allows you to export all i18n keys and values to one CSV file. With this the values can be easily translated and later reimported into your project. The new translations are saved in a filename similar to the original one (only the locale is replaced).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "i18n-csv_translation", require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-csv_translation

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/swelther/i18n-csv_translation.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
