# frozen_string_literal: true

require "simplecov"
require_relative "../helper/simplecov"

SimpleCov::Utils.clear_coverage_output
SimpleCov.start

require "irozuku"

RSpec.configure do |config|
  # Exit test early as soon as failing test is encountered
  config.fail_fast = true
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

SimpleCov.at_exit do
  require "irozuku/utils"
  Irozuku::Utils.silence_stdout do
    SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
    SimpleCov.result.format!
  end
  SimpleCov.formatter = SimpleCov::Formatter::ColoredSummary
  puts SimpleCov.result.format!
end
