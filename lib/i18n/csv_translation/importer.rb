require "csv"
require "deep_merge"

module I18n::CsvTranslation
  class Importer
    def initialize col_sep: ";", headers: false
      @col_sep = col_sep
      @headers = headers
    end

    def import input:, path:, new_locale:
      @input      = input
      @path       = path
      @new_locale = new_locale

      translations = load_translations_from_csv
      save_translations_as_yaml translations
    end

    private

    def load_translations_from_csv
      translations = {}

      CSV.foreach(@input, col_sep: @col_sep, headers: @headers) do |csv|
        unless csv[1].nil? && csv[2].nil?
          if translations[csv[0]].nil?
            translations[csv[0]] = { key_with_locale(csv[1]) => csv[2] }
          else
            translations[csv[0]].merge!({ key_with_locale(csv[1]) => csv[2] })
          end
        end
      end

      translations
    end

    def save_translations_as_yaml translations
      translations.each do |key, value|
        unless key.nil?
          filename = Pathname.new(@path).join(key.gsub(/yml$/, "#{@new_locale}.yml"))
          FileUtils.mkdir_p(File.dirname(filename))
          file = File.open(filename, "w")

          hash = {}

          value.each do |inner_key, inner_value|
            if inner_value && inner_value.start_with?('[') && inner_value.ends_with?(']')
              inner_value = eval(inner_value)
            end
            a = inner_key.split(".").reverse.inject(inner_value) { |a, n| { n => a } }
            hash.deep_merge! a
          end

          file.write(hash.to_yaml.gsub(/^---\n/, ''))

          file.close
        end
      end
    end

    def key_with_locale key
      "#{@new_locale}.#{key}"
    end

  end
end
