# frozen_string_literal: true

require_relative "irozuku/version"

module Irozuku
  attr_accessor :ansi_color, :ansi_background_color, :ansi_text_decoration, :text
  @ansi_text_decoration = []

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
