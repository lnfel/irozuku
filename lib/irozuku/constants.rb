# frozen_string_literal: true

module Irozuku
  ##
  # Constants module holds definitions for reusable ANSI sequences, extendable built-in color values and text decoration ANSI code values together with their corresponding reset sequence number.
  #
  # See [ANSI Escape Sequences gist by ConnerWill](https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b) and [Sample ruby implementation by abhishekkr](https://gist.github.com/abhishekkr/3610174).
  module Constants
    ##
    # The escape character used to start ANSI escape sequences.
    # Can be represented as `\x1b`, `\e`, or `\033` followed by a bracket `[`.
    # Not really used throughout the code but is here for documentation.
    ANSI_ESC_SEQUENCE = "\x1b"

    ##
    # The escape character used to reset ANSI escape sequences to default terminal style output.
    # `0` specifies the "reset all" action, meaning it reverts to the default terminal settings.
    # Not really used throughout the code but is here for documentation.
    ANSI_RESET_SEQUENCE = "\e[0m"

    ##
    # Built-in color values inspired by [Tailwindcss color palette](https://tailwindcss.com/docs/colors).
    HEX_COLOR_MAP = {
      black: "#000000",
      white: "#ffffff",
      gray: "#6b7280",
      stone: "#78716c",
      red: "#ef4444",
      orange: "#f97316",
      amber: "#f59e0b",
      yellow: "#eab308",
      lime: "#84cc16",
      green: "#22c55e",
      emerald: "#10b981",
      teal: "#14b8a6",
      cyan: "#06b6d4",
      sky: "#0ea5e9",
      blue: "#3b82f6",
      indigo: "#6366f1",
      violet: "#8b5cf6",
      purple: "#a855f7",
      fuschia: "#d946ef",
      pink: "#ec4899",
      rose: "#f43f5e"
    }.freeze

    ##
    # This holds the ANSI code representation for text decorations such as bold, italic etc.
    # Some terminals may not support some of the graphic mode sequences listed.
    TEXT_DECORATION_MAP = {
      bold: {
        code: "1",
        reset: "22"
      },
      dim: {
        code: "2",
        reset: "22"
      },
      italic: {
        code: "3",
        reset: "23"
      },
      underline: {
        code: "4",
        reset: "24"
      },
      blink: {
        code: "5",
        reset: "25"
      }, # most consider this as bad for accessibility, hence why it is not supported most of the time
      inverse: {
        code: "7",
        reset: "27"
      },
      hidden: {
        code: "8",
        reset: "28"
      },
      strikethrough: {
        code: "9",
        reset: "29"
      },
      double_underline: {
        code: "21",
        reset: "24"
      }, # double_underline sequence is a non-specified sequence for double underline mode and only work in some terminals and is reset with [24m
      overline: {
        code: "53",
        reset: "55" # Reset is 55 as defined in microsoft vscode implementation https://github.com/microsoft/vscode/issues/181242#issuecomment-1564668078
      } # overline is not defined in XTerm Control Sequences https://invisible-island.net/xterm/ctlseqs/ctlseqs.html, not a standard in most terminal implementations
    }

    ##
    # The default color codes used in legacy terminal settings.
    # Not really used throughout the code but is here for documentation.
    EIGHT_COLOR_MAP = {
      black: "30",
      red: "31",
      green: "32",
      yellow: "33",
      blue: "34",
      magenta: "35",
      white: "37"
    }
  end
end
