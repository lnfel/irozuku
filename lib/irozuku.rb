# frozen_string_literal: true

require_relative "irozuku/version"
require_relative "irozuku/constants"
require_relative "irozuku/validation"
require_relative "irozuku/configuration"

module Irozuku
  @ansi_color = nil
  @ansi_background_color = nil
  @text = nil
  @ansi_text_decoration = []

  # https://rollbar.com/guides/ruby/how-to-raise-exceptions-in-ruby/
  # https://www.honeybadger.io/blog/ruby-exception-vs-standarderror-whats-the-difference/
  class IrozukuError < StandardError
    def initialize(msg)
      super
    end
  end

  def self.configuration
    @configuration ||= Irozuku::Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end

  # https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b#rgb-colors
  def self.generate_text_color_method(name, color)
    define_singleton_method :"#{name}" do |text = nil|
      @ansi_color = "\x1b[38;2;#{hex_to_ansi color}m"
      if text
        write(text)
      else
        self
      end
    end
  end

  # https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b#rgb-colors
  def self.generate_bg_color_method(name, color)
    define_singleton_method :"#{name}" do |text = nil|
      @ansi_background_color = "\x1b[48;2;#{hex_to_ansi color}m"
      if text
        write(text)
      else
        self
      end
    end
  end

  def self.generate_text_decoration_method(name, ansi_value)
    define_singleton_method :"#{name}" do |text = nil|
      @ansi_text_decoration.push({
        "code" => "\x1b[#{ansi_value["code"]}m",
        "reset" => "\x1b[#{ansi_value["reset"]}m"
      })

      if text
        write(text)
      else
        self
      end
    end
  end

  self.configuration.colors.each do |key, value|
    generate_text_color_method key, value
    generate_bg_color_method "bg_#{key}", value
  end

  Constants::TEXT_DECORATION_MAP.each do |key, value|
    generate_text_decoration_method key, value
  end

  def self.color(color_string)
    if !color_string.start_with?("#")
      hex_string = get_color(color_string)
    end
    color_string = hex_string if hex_string
    @ansi_color = "\x1b[38;2;#{hex_to_ansi color_string}m"
    self
  end

  def self.hex_to_ansi(hex_string)
    Validation.hex_color?(hex_string)
    # hex_string = hex_string.sub(/^#?/, "")
    # if hex_string.match?(/^#?[a-f0-9]{3}$/i)
    #   hex_string = hex_string.chars.map { |a|
    #     a * 2
    #   }.join("")
    # end

    parts = hex_string.match(/#?(?<r>..)(?<g>..)(?<b>..)/)
    t = []

    %w[r g b].each do |e|
      t << parts[e].hex # steep:ignore NoMethod
    end

    t.join(";")
  end

  def self.get_color(name)
    Validation.valid_color?(name.downcase)
  end

  # ANSI code is written in sequence as:
  # color; bg_color; text_decoration; <text_to_decorate> text_decoration_reset; global_reset;
  # global_reset at the end is optional and is only added when color and bg_color are present
  def self.write(string)
    output = "#{@ansi_color}#{@ansi_background_color}#{@ansi_text_decoration.map{ |x| x["code"] if x }.join("")}#{string}#{@ansi_text_decoration.reverse.map{ |x| x["reset"] if x }.join("")}#{"\x1b[0m" if [@ansi_color, @ansi_background_color].compact.length > 0 and self.configuration.reset_sequence == "enabled" }"
    cleanup
    output
  end

  def self.cleanup
    @ansi_color = nil
    @ansi_background_color = nil
    @ansi_text_decoration = []
    @text = nil
  end
end
