# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in irozuku.gemspec
gemspec

# Typically we only need to specify gems in our gemspec file (./irozuku.gemspec)
# But Ruby LSP does not have support for autocompletion on gems that are declared in gemspec files
# This is why we declare the gems here
# TODO: Move all gem declaration to gemspec file (./irozuku.gemspec) once Ruby LSP support is available
gem "thor", "~> 1.3.2"
gem "rake", "~> 13.0"

group :development do
  gem "standard", "~> 1.3"
end

group :test do
  gem "simplecov", "~> 0.22", require: false
end

group :development, :test do
  gem "steep", "~> 1.7", require: false
end
