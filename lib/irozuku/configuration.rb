require_relative "constants"

module Irozuku
  # https://dev.to/vinistock/make-a-ruby-gem-configurable-228d
  class Configuration
    attr_reader :colors, :reset_sequence, :ansi_sequence

    def initialize
      @colors = Constants::HEX_COLOR_MAP
      @reset_sequence = "enabled"
      @ansi_sequence = "enabled"
    end

    def colors=(colors)
      @colors = Constants::HEX_COLOR_MAP.merge(colors)

      Irozuku.configuration.colors.each do |key, value|
        Irozuku.generate_text_color_method key, value
        Irozuku.generate_bg_color_method "bg_#{key}", value
      end
    end

    def reset_sequence=(reset_sequence)
      @reset_sequence = reset_sequence
    end

    def ansi_sequence=(ansi_sequence)
      @ansi_sequence = ansi_sequence
    end
  end
end
