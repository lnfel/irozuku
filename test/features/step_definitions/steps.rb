# frozen_string_literal: true

require "irozuku"
# require "irozuku/cli"

# Run cucumber with --guess flag option, without guess option enabled cucumber hallucinates
# and we either get @result with nil value or Then cases are undefined
#
# > bundle exec cucumber features --guess
#
# A rake task for cucumber is also declared in Rakefile, we can run cucumber test using:
# > rake features

Before do
  # @irozuku = Irozuku::CLI.new
end

When("I run `irozuku write {string}`") do |string|
  @result = Irozuku.write(string)
end

Then("the resulting value should contain {string}") do |result|
  expect(result).to eq(@result)
end
