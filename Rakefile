# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"
require "cucumber"
require "cucumber/rake/task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = [
    "--default-path test/spec",
    "--pattern test/spec/**/*_spec.rb",
    "--format documentation",
    "--color",
    "--require spec_helper"
  ]
end

# By default Cucumber looks in features folder in the root directory of the project
# and loads features/step_definitions and features/support folder files.
#
# If we change directories we need to explicitly require those folders
# https://cucumber.io/docs/tools/ruby/
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = [
    "--require test/features/step_definitions",
    "--require test/features/support",
    "--guess",
    "--format pretty",
    "test/features"
  ] # Any valid command line option can go here.
end

task default: %i[spec standard features]
