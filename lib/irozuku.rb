# frozen_string_literal: true

require_relative "irozuku/version"
require_relative "irozuku/constants"
require_relative "irozuku/validation"

module Irozuku
  attr_accessor :ansi_color, :ansi_background_color, :ansi_text_decoration, :text
  @ansi_text_decoration = [] # steep:ignore

  # https://rollbar.com/guides/ruby/how-to-raise-exceptions-in-ruby/
  # https://www.honeybadger.io/blog/ruby-exception-vs-standarderror-whats-the-difference/
  class IrozukuError < StandardError
    def initialize(msg)
      super
    end
  end

  def self.generate_text_color_method(name, color)
    define_singleton_method :"#{name}" do |text = nil|
      @ansi_color = "\x1b[38;2;#{hex_to_ansi color}m" # steep:ignore
      if text
        write(text)
      else
        self
      end
    end
  end

  def self.generate_bg_color_method(name, color)
    define_singleton_method :"#{name}" do |text = nil|
      @ansi_background_color = "\x1b[48;2;#{hex_to_ansi color}m" # steep:ignore
      if text
        write(text)
      else
        self
      end
    end
  end

  def self.generate_text_decoration_method(name, ansi_value)
    define_singleton_method :"#{name}" do |text = nil|
      @ansi_text_decoration.push("\x1b[#{ansi_value}m") # steep:ignore

      if text
        write(text)
      else
        self
      end
    end
  end

  Constants::HEX_COLOR_MAP.each do |key, value|
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
    @ansi_color = "\x1b[38;2;#{hex_to_ansi color_string}m" # steep:ignore
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

  def self.write(string)
    output = "#{@ansi_color}#{@ansi_background_color}#{@ansi_text_decoration.join("")}#{string}#{"\x1b[0m" if [@ansi_color, @ansi_background_color, @ansi_text_decoration[0]].compact.length > 0}"
    cleanup
    output
  end

  def self.cleanup
    # steep:ignore:start
    @ansi_color = nil
    @ansi_background_color = nil
    @ansi_text_decoration = []
    @text = nil
    # steep:ignore:end
  end
end
