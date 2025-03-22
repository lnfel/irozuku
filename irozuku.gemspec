# frozen_string_literal: true

require_relative "lib/irozuku/version"

Gem::Specification.new do |spec|
  spec.name = "irozuku"
  spec.version = Irozuku::VERSION
  spec.authors = ["Dale Ryan Aldover"]
  spec.email = ["bk2o1.syndicates@gmail.com"]

  spec.summary = "Terminal styling in ruby."
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://lnfel.github.io/irozuku/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lnfel/irozuku/"
  spec.metadata["changelog_uri"] = "https://github.com/lnfel/irozuku/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  # https://github.com/soutaro/steep/issues/329
  spec.metadata = {
    "steep_types" => "sig"
  }

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "thor", "~> 1.3.2"

  spec.add_development_dependency "standard", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 9.2"
  spec.add_development_dependency "aruba", "~> 2.2"
  spec.add_development_dependency "simplecov", "~> 0.22"
  spec.add_development_dependency "steep", "~> 1.7"
  spec.add_development_dependency "rdoc", "~> 6.12"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
