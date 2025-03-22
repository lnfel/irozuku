# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"
require "cucumber"
require "cucumber/rake/task"
require "steep/rake_task"
require "rdoc"
require "rdoc/task"
require "rubygems/package_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = [
    "--default-path test/spec",
    "--pattern test/spec/*_spec.rb,test/spec/**/*_spec.rb",
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

# Steep available commands
# init check stats binstub project watch
# See steep/cli for command options
Steep::RakeTask.new do |t|
  t.check.severity_level = :error
  t.watch.verbose
end

# ENV['RDOC_USE_PRISM_PARSER'] = "true"

# Todo: Generate Constants with default values documented
# https://stackoverflow.com/questions/48603151/how-to-show-constant-value-in-rdoc
# https://stackoverflow.com/questions/15760530/change-a-rdoc-template-for-generating-rails-app-documentation/15764193#15764193
class RDoc::Options
  def template_dir_for(template_path)
    "#{File.dirname(__FILE__)}/rdoc/template/#{template_path}"
  end
end

RDoc::Task.new({rdoc: "rdoc", clobber_rdoc: "rdoc:clean", rerdoc: "rdoc:force"}) do |rdoc|
  rdoc.title = "Irozuku"
  rdoc.markup = "markdown"
  rdoc.template = "darkfish"
  rdoc.generator = "darkfish"
  rdoc.rdoc_dir = "site/docs"
  rdoc.options = [
    "--line_numbers",
    "--copy-files=rdoc/assets"
    # "-D",
    # "--template=darkfish",
  ]
end

gemspec = Gem::Specification.new(File.open("#{File.dirname(__FILE__)}/irozuku.gemspec"))

# rake build
Gem::PackageTask.new(gemspec)

task default: %i[spec standard features steep rdoc:force]
