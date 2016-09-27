# I18n::CsvTranslation

Ever needed to add a new locale to an existing (Rails) project with dozens of .yml files? Too afraid to give all files to the customer or translation service and hope they do not mess up the YAML format?

This gem allows you to export all i18n keys and values to one CSV file. With this the values can be easily translated and later reimported into your project. The new translations are saved in a filename similar to the original one (only the locale is replaced).

## Installation

Add this line to your application's Gemfile in the development group because you will need it only locally:

```ruby
group :development do
  gem "i18n_csv", require: false
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-csv_translation

## Usage

### Export translations into one csv file

Write in a (Rails) console or script:

```ruby
  require "i18n/csv-translation"

  exporter = I18n::CsvTranslation::Exporter.new
  exporter.export(path: "path-to-your-locales-directory", output: "my_translations.csv", files: "*.yml")
```

Note: The gem expects only one locale in each file. If you want to export only English to have it translated you can either
give a files param like `files: "en.*.yml"` or use a block (see below) to determine if the files content should be processed.

If you wish a different csv column separator give it as option:

```ruby
  I18n::CsvTranslation::Exporter.new(col_sep: "\t")
```

With a block you can decide if the translation file should be processed

```ruby
  exporter.export(path: "path-to-your-locales-directory", output: "my_translations.csv") do |file|
    !file.include? "admin"
  end
```

Ignores all files with "admin" in the name.

### Import translations from csv

Given you got a csv with translated values for a new locale, lets say German.

The import process works only if the first two columns on the csv file haven't been
touched by the translaters. The first column holds the file name of the original
translation file, without the locale. The second one is the translation key,
again without locale.

Creating new translation files can be done like this:

```ruby
  require "i18n/csv-translation"

  importer = I18n::CsvTranslation::Importer.new
  importer.import input: "path_to_translated_csv_file", path: "path_for_new_translation_files", new_locale: "de"
```

Given you had two English translation files:

```
  config/locales/en.users.yml
  config/locales/en.addresses.yml
```

After the import you would have these two new German translation files:

```
  de.users.yml
  de.addresses.yml
```

With all keys and values in their respective files, e.g. "de.users.name" in de.users.yml,
"de.addresses.street" in de.addresses.yml.

The translated csv file has a custom col sep?

```ruby
  importer = I18n::CsvTranslation::Importer.new(col_sep: "\t")
```

## TODO

- Option for the locale to be exported instead of files param. Would load all yml files but process only thos with a distinct locale.
- Remove YAML header from new translation files (optionally)
- Option for verbose output (which file processed, which keys, etc...)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/swelther/i18n-csv_translation.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
