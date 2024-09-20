# frozen_string_literal: true

require "simplecov"
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
