# frozen_string_literal: true

require_relative "irozuku/version"

module Irozuku
  attr_accessor :ansi_color, :ansi_background_color, :ansi_text_decoration, :text
  @ansi_text_decoration = []
end
