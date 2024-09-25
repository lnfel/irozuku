# frozen_string_literal: true

require "simplecov"
require_relative "../helper/simplecov"

SimpleCov::Utils.clear_coverage_output
SimpleCov.start

require "irozuku"
require "irozuku/utils"

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

  # Run cleanup method after each context to prevent
  # previous test's instance variables to affect next usage of Irozuku.
  # i.e. After running the tests, using Irozuku on SimpleCov.at_exit hook receives the last context's Irozuku instance variable,
  # making the Coverage Report for RSpec title background color yellow!
  config.after(:context) do
    Irozuku.cleanup
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
