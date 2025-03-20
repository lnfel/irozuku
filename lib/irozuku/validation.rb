# frozen_string_literal: true

require_relative "../irozuku"

module Irozuku
  module Validation
    class ValidationError < StandardError
      def initialize(msg)
        super
      end
    end

    ##
    # Validate color name existence
    # Returns color hex_string if found
    def self.valid_color?(color_string)
      Irozuku.configuration.colors.fetch(color_string.to_sym)
    rescue KeyError
      raise ValidationError.new("Color #{color_string} is not defined.")
    end

    # Validate hex color string
    # ```
    # #? - Optionally start with a hash symbol
    # (
    #   ?: - Non-capturing group
    #   \h - a shorthand character class for hex digit character ([0-9a-fA-F])
    #   {3} - match the previous token (the hex digit) three times
    # )
    # {1,2} - repeat either once or twice
    # ```
    #
    # See [Validate RGB hex](https://stackoverflow.com/a/59302334/12478479),
    # [Ruby Regexp - Ruby-lang](https://docs.ruby-lang.org/en/master/Regexp.html),
    # [Ruby Regexp - Rubyapi](https://rubyapi.org/3.3/o/regexp)
    def self.hex_color?(hex_string)
      validation_success = hex_string.match?(/^#?(?:\h{3}){1,2}/)
      if !validation_success
        raise ValidationError.new "Invalid hex color string: #{hex_string}"
      end
    end
  end
end
