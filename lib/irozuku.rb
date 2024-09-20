# frozen_string_literal: true

require_relative "irozuku/version"
require_relative "irozuku/constants"

module Irozuku
  attr_accessor :ansi_color, :ansi_background_color, :ansi_text_decoration, :text
  @ansi_text_decoration = []

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
      @ansi_text_decoration.push("\x1b[#{ansi_value}m")

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

  def self.write(string)
    output = "#{@ansi_color}#{@ansi_background_color}#{@ansi_text_decoration.join("")}#{string}#{"\x1b[0m" if [@ansi_color, @ansi_background_color, @ansi_text_decoration[0]].compact.length > 0}"
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
