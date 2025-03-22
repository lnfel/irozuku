<p align="center">
    <a href="https://lnfel.github.io/irozuku/" target="_blank">
        <img src="https://raw.githubusercontent.com/lnfel/irozuku/main/rdoc/assets/images/irozuku.png" height="150" alt="Irozuku logo" />
    </a>
</p>

> Elegant terminal styling in ruby.

## Motivation

- It's been a long time since I have written something in ruby, and this is an attempt to get back and familiarize myself on how to write proper ruby code (modular and tested). Also learning how to package a gem as well.

- There are similar gems that are doing the same thing [Colorize](https://github.com/fazibear/colorize) but extend the `String` class. [Rainbow](https://github.com/ku1ik/rainbow) also exists that supports both ANSI colors and X11 colors list but sometimes we need more than what is listed. There is [Shopify's cli-ui](https://github.com/Shopify/cli-ui) but it has limited colors and it introduces a somewhat weird template syntax for styling strings `puts CLI::UI.fmt "{{red:This is a red sentence.}} {{green:Green}}"`.    

- There is a javascript package named [Chalk](https://github.com/chalk/chalk) and I have used it for quite a while. It is so nice so I wanted to see something similar with ruby ecosystem.

## Highlights

- Does not extend String class
- No additional dependencies
- Nest styles by simply chaining methods
- 256/Truecolor color support
- Clean API
- Supports ANSI text decoration (bold, dim, italic etc.)

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add irozuku
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install irozuku
```

## Usage

```ruby
require "irozuku"

puts Irozuku.green("Color me impressed!")
```

The code above would print the text output green by wrapping the string with ANSI escape sequences:

```ruby
Irozuku.green("Color me impressed!") #=> "\e[38;2;34;197;94mColor me impressed!\e[0m"
```

Irozuku styles can be chained and nest together.

```ruby
require "irozuku"

# Combine styles using string interpolation
puts "#{Irozuku.red("Apple")} and #{Irozuku.orange("oranges")}."
#=>> "\e[38;2;239;68;68mApple\e[0m and \e[38;2;249;115;22moranges\e[0m."

# Multiple styles on a string using chainable methods
puts Irozuku.underline.red("Emphasized text")
#=>> "\e[38;2;239;68;68m\e[4mEmphasized text\e[24m\e[0m"

# Nest styles
puts Irozuku.red("Hello #{Irozuku.underline.blue("World!")}")
#=>> "\e[38;2;239;68;68mHello \e[38;2;59;130;246m\e[4mWorld!\e[24m\e[38;2;239;68;68m\e[0m"

# Nesting also works when inserting between similar styled strings
puts Irozuku.green("Start with green, #{Irozuku.underline.bold.blue("insert blue")} then continue being green!")
#=>> "\e[38;2;34;197;94mStart with green, \e[38;2;59;130;246m\e[4m\e[1minsert blue\e[22m\e[24m\e[38;2;34;197;94m then continue being green!\e[0m"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lnfel/irozuku. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lnfel/irozuku/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Irozuku project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lnfel/irozuku/blob/main/CODE_OF_CONDUCT.md).
