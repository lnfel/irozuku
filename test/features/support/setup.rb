require "simplecov"
require_relative "../../helper/simplecov"

SimpleCov::Utils.clear_coverage_output
SimpleCov.start

# https://github.com/cucumber/aruba/tree/main/features/
require "aruba/cucumber"

# https://rubydoc.info/gems/simplecov/SimpleCov#result-class_method
# https://rubydoc.info/gems/simplecov/SimpleCov/Formatter/SimpleFormatter#format-instance_method
SimpleCov.at_exit do
  require "irozuku/utils"
  Irozuku::Utils.silence_stdout do
    SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
    SimpleCov.result.format!
  end
  SimpleCov.formatter = SimpleCov::Formatter::ColoredSummary
  puts SimpleCov.result.format!
end
