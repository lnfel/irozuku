require_relative "constants"

module Irozuku
  # https://dev.to/vinistock/make-a-ruby-gem-configurable-228d
  class Configuration
    def initialize
      @colors = Constants::HEX_COLOR_MAP
    end

    def colors=(colors)
      @colors = Constants::HEX_COLOR_MAP.merge(colors)

      Irozuku.configuration.colors.each do |key, value|
        Irozuku.generate_text_color_method key, value
        Irozuku.generate_bg_color_method "bg_#{key}", value
      end
    end
  end
end
