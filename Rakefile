# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"
require "cucumber"
require "cucumber/rake/task"

RSpec::Core::RakeTask.new(:spec)

# https://cucumber.io/docs/tools/ruby/
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--guess" # Any valid command line option can go here.
end

task default: %i[spec standard features]
