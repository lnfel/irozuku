# require "irozuku"
require "simplecov"

module SimpleCov
  module Formatter
    ##
    # SimpleCov Formatter for colored summary output
    #
    # https://github.com/simplecov-ruby/simplecov-html/blob/main/lib/simplecov-html.rb#L56
    class ColoredSummary
      def format(result)
        require "irozuku"
        message = "#{Irozuku.bold.yellow("Coverage Report for #{result.command_name}")}"
        message += "\n#{Irozuku.bold.blue("Output path:")} #{SimpleCov.coverage_path}"
        message += "\n#{Irozuku.bold.blue("Line Coverage:")} #{coverage_color(result.covered_percent.round(2))} (#{result.covered_lines} / #{result.total_lines})"
        message += "\n#{Irozuku.bold.blue("Branch Coverage:")} #{result.coverage_statistics[:branch].percent.round(2)}% (#{result.covered_branches} / #{result.total_branches})" if SimpleCov.branch_coverage?
        message

        # result.files.each do |file|
        #   puts file.covered_percent.round(2)
        # end
      end

      def coverage_color(coverage_percent)
        require "irozuku"
        if coverage_percent > 90
          Irozuku.green("#{coverage_percent}%")
        elsif coverage_percent > 80
          Irozuku.yellow("#{coverage_percent}%")
        else
          Irozuku.red("#{coverage_percent}%")
        end
      end
    end
  end
end
# https://github.com/simplecov-ruby/simplecov/issues/741#issuecomment-655803917
Pathname.new(__FILE__).parent.join("..", "..", "..", "coverage").tap do |cov|
  # clear old coverage results
  FileUtils.rm_rf cov if cov.exist?
end
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
