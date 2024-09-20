require "irozuku"

module Irozuku
  module Constants
    ANSI_ESC_SEQUENCE = "\x1b"

    ANSI_RESET_SEQUENCE = "\e[0m"

    # Built-in colors
    HEX_COLOR_MAP = {
      "black" => "#000000",
      "white" => "#ffffff",
      "gray" => "#6b7280",
      "stone" => "#78716c",
      "red" => "#ef4444",
      "orange" => "#f97316",
      "amber" => "#f59e0b",
      "yellow" => "#eab308",
      "lime" => "#84cc16",
      "green" => "#22c55e",
      "emerald" => "#10b981",
      "teal" => "#14b8a6",
      "cyan" => "#06b6d4",
      "sky" => "#0ea5e9",
      "blue" => "#3b82f6",
      "indigo" => "#6366f1",
      "violet" => "#8b5cf6",
      "purple" => "#a855f7",
      "fuschia" => "#d946ef",
      "pink" => "#ec4899",
      "rose" => "#f43f5e"
    }.freeze

    # https://gist.github.com/abhishekkr/3610174
    # Some terminals may not support some of the graphic mode sequences listed
    TEXT_DECORATION_MAP = {
      "bold" => "1",
      "dim" => "2",
      "italic" => "3",
      "underline" => "4",
      "blink" => "5", # most consider this as bad for accessibility, hence why it is not supported most of the time
      "inverse" => "7",
      "hidden" => "8",
      "strikethrough" => "9",
      "double_underline" => "21", # double_underline sequence is a non-specified sequence for double underline mode and only work in some terminals and is reset with [24m
      "overline" => "53" # not defined in XTerm Control Sequences https://invisible-island.net/xterm/ctlseqs/ctlseqs.html, not a standard in most terminal implementations
    }

    EIGHT_COLOR_MAP = {
      "black" => "30",
      "red" => "31",
      "green" => "32",
      "yellow" => "33",
      "blue" => "34",
      "magenta" => "35",
      "white" => "37"
    }
  end
end
