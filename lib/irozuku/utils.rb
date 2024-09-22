require_relative "../irozuku"

module Irozuku
  module Utils
    ##
    # Silence STDOUT
    # Usage:
    # ```ruby
    # capture_output = silence_stdout do
    #   # Does not output anything directly.
    #   puts "Hey!"
    # end
    # puts capture_output #=> "Hey!"
    # ```
    # https://stackoverflow.com/questions/4459330/how-do-i-temporarily-redirect-stderr-in-ruby/4459463#4459463
    # https://github.com/simplecov-ruby/simplecov/issues/992#issuecomment-1230389720
    def self.silence_stdout
      # The output stream must be an IO-like object. In this case we capture it in
      # an in-memory IO object so we can return the string value. You can assign any
      # IO object here.
      previous_stdout, $stdout = $stdout, StringIO.new
      yield
      $stdout.string
    ensure
      # Restore the previous value of stdout (typically equal to STDOUT)
      $stdout = previous_stdout
    end
  end
end
