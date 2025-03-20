# frozen_string_literal: true

# rbs_inline: enabled

require_relative "irozuku/version"
require_relative "irozuku/constants"
require_relative "irozuku/validation"
require_relative "irozuku/configuration"

module Irozuku
  @ansi_color = nil
  @ansi_background_color = nil
  @text = nil
  @ansi_text_decoration = []
  @sequences = []

  ##
  # Generic Error
  #
  # TODO: Handle possible errors
  #
  # Related links:
  #
  # - [How to raise exceptions in ruby](https://rollbar.com/guides/ruby/how-to-raise-exceptions-in-ruby/)
  #
  # - [Ruby exception vs standard error](https://www.honeybadger.io/blog/ruby-exception-vs-standarderror-whats-the-difference/)
  class IrozukuError < StandardError
    ##
    # Initialize IrozukuError from StandardError.
    def initialize(msg)
      super
    end
  end

  ##
  # Gets user-defined configuration or initializes from default config.
  # Users can customize configuration by passing a block to `Irozuku.configure`.
  def self.configuration
    @configuration ||= Irozuku::Configuration.new
  end

  ##
  # Customize `Irozuku::Configuration`.
  #
  # Sample configuration:
  # ```ruby
  # Irozuku.configure do |config|
  #   config.colors = {forest_green: "#174a43"}
  #   config.ansi_sequence = "enabled"
  #   config.reset_sequence = "enabled"
  # end
  # ```
  # - **colors** - Defaults to `Irozuku::Constants::HEX_COLOR_MAP`.
  # Colors can be added by setting a hash with a color key name that does not exist in Irozuku::Constants::HEX_COLOR_MAP, otherwise the existing color name is overridden with a new value.
  # This is done by merging the default color constants to the user-defined colors.
  # - **ansi_sequence** - Defaults to `enabled`.
  # Setting this to "disabled" is useful for logging into a text file, preventing unwanted characters from your precious production logs.
  # - **reset_sequence** - Deprecated - Defaults to `enabled`.
  # This was an experimental flag for exploring how to properly end escape sequences. Current behaviour when "disabled" is similar to disabled ansi_sequence.
  def self.configure
    yield configuration if block_given?
  end

  ##
  # Dynamically add text color method to Irozuku module.
  # See [ConnerWill's gist on RGB color escape code sequence](https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b#rgb-colors).
  def self.generate_text_color_method(name, color)
    define_singleton_method name.to_sym do |text = nil|
      @ansi_color = "\x1b[38;2;#{hex_to_ansi color}m"
      if text
        write(text)
      else
        self
      end
    end
  end

  ##
  # Dynamically add background color method to Irozuku module.
  # See [ConnerWill's gist on RGB color escape code sequence](https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b#rgb-colors).
  def self.generate_bg_color_method(name, color)
    define_singleton_method name.to_sym do |text = nil|
      @ansi_background_color = "\x1b[48;2;#{hex_to_ansi color}m"
      if text
        write(text)
      else
        self
      end
    end
  end

  ##
  # Dynamically add text decoration method to Irozuku module.
  # See [ConnerWill's gist on Graphics escape code sequence](https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b#colors--graphics-mode).
  def self.generate_text_decoration_method(name, ansi_value)
    define_singleton_method name.to_sym do |text = nil|
      @ansi_text_decoration.push({
        code: "\x1b[#{ansi_value[:code]}m",
        reset: "\x1b[#{ansi_value[:reset]}m"
      })

      if text
        write(text)
      else
        self
      end
    end
  end

  ##
  # Use configured built-in or user defined color values to add text and background color methods to Irozuku.
  Irozuku.configuration.colors.each do |key, value|
    generate_text_color_method key, value
    generate_bg_color_method "bg_#{key}", value
  end

  ##
  # Use TEXT_DECORATION_MAP to dynamically add text decoration methods to Irozuku.
  Constants::TEXT_DECORATION_MAP.each do |key, value|
    generate_text_decoration_method key, value
  end

  ##
  # Either use a hex color string or specify a built-in color or user defined color to color text output.
  #
  # Usage:
  # ```ruby
  # # Using hex color string
  # print Irozuku.color("#ffffff").write("Color this sentence white.")
  #
  # # Using built-in color name
  # print Irozuku.rose("Rose colored sentence.")
  #
  # # Using user defined color name
  # Irozuku.configure do |config|
  #   config.colors = { crimson: "#ff5733" }
  # end
  # print Irozuku.crimson("King Crimson.")
  # ```
  #
  # See Irozuku::Configuration.colors= for user defined colors.
  def self.color(color_string)
    if !color_string.start_with?("#")
      hex_string = get_color(color_string)
    end
    color_string = hex_string if hex_string
    @ansi_color = "\x1b[38;2;#{hex_to_ansi color_string}m"
    self
  end

  ##
  # Transforms hex color string to ANSI code sequence with the following format:
  # ```
  # <R>;<G>;<B>;
  # ```
  #
  # Usage:
  # ```ruby
  # print "\x1b[38;2;#{Irozuku.hex_to_ansi("#ff5733")}mColored Text\x1b[0m"
  # ```
  def self.hex_to_ansi(hex_string)
    Validation.hex_color?(hex_string)
    # hex_string = hex_string.sub(/^#?/, "")
    # if hex_string.match?(/^#?[a-f0-9]{3}$/i)
    #   hex_string = hex_string.chars.map { |a|
    #     a * 2
    #   }.join("")
    # end

    parts = hex_string.match(/#?(?<r>..)(?<g>..)(?<b>..)/)
    # standard:disable Layout/LeadingCommentSpace
    t = [] #: [String?]
    # standard:enable Layout/LeadingCommentSpace

    %w[r g b].each do |e|
      t << parts[e].hex # steep:ignore NoMethod
    end

    t.join(";")
  end

  ##
  # Gets built-in or user defined color name hex color string using fetch validation.
  # See Validation.valid_color?
  def self.get_color(name)
    Validation.valid_color?(name.downcase)
  end

  ##
  # Concatenates given `string` input with ANSI sequences. Where the sequence is written in the following format:
  # ```
  # color; bg_color; text_decoration; <text_to_decorate> text_decoration_reset; global_reset;
  # ```
  # `global_reset` at the end is optional and is only added when color and bg_color are present.
  def self.write(string)
    output = (configuration.ansi_sequence == "enabled") ? "#{@ansi_color}#{@ansi_background_color}#{@ansi_text_decoration.map { |x| x[:code] if x }.join("")}#{string}#{@ansi_text_decoration.reverse.map { |x| x[:reset] if x }.join("")}#{"\x1b[0m" if [@ansi_color, @ansi_background_color].compact.length > 0 && configuration.reset_sequence == "enabled"}" : string
    if @sequences.length > 0
      @sequences.each_with_index do |sequence, index|
        inner_sequence = sequence if output.include?(sequence)
        if inner_sequence
          output = output.gsub(inner_sequence, inner_sequence.gsub("\x1b[0m", (@sequences.length - 1 == index) ? "#{@ansi_color}#{@ansi_background_color}#{@ansi_text_decoration.map { |x| x[:code] if x }.join("")}" : ""))
        end
      end
    end
    @sequences.push(output)
    cleanup
    output
  end

  ##
  # Resets the following:
  #
  # - @ansi_color, @ansi_background_color and @text to nil
  #
  # - @ansi_text_decoration to empty array
  #
  # This is useful for combining nested ANSI sequences so we can properly close each style. Another use is for making sure each test example are not influenced by previous test case.
  def self.cleanup
    @ansi_color = nil
    @ansi_background_color = nil
    @ansi_text_decoration = []
    @text = nil
  end
end
