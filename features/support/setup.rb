require 'simplecov'
# https://github.com/simplecov-ruby/simplecov/issues/741#issuecomment-655803917
Pathname.new(__FILE__).parent.join("..", "..", "coverage").tap do |cov|
  # clear old coverage results
  FileUtils.rm_rf cov if cov.exist?
end
SimpleCov.start

# https://github.com/cucumber/aruba/tree/main/features/
require "aruba/cucumber"
