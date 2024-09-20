require "irozuku"

module Irozuku
  module Validation
    class ValidationError < StandardError
      def initialize(msg)
        super
      end
    end

    ##
    # Validate hex color string
    # #? - Optionally start with a hash symbol
    # (
    #   ?: - Non-capturing group
    #   \h - a shorthand character class for hex digit character ([0-9a-fA-F])
    #   {3} - match the previous token (the hex digit) three times
    # )
    # {1,2} - repeat either once or twice
    #
    # https://stackoverflow.com/a/59302334/12478479
    # https://docs.ruby-lang.org/en/3.3/Regexp.html
    # https://rubyapi.org/3.3/o/regexp
    def self.hex_color?(hex_string)
      validation_success = hex_string.match?(/^#?(?:\h{3}){1,2}/)
      if !validation_success
        raise ValidationError.new "Invalid hex color string: #{hex_string}"
      end
    end
  end
end
