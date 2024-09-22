# Generate RBS types for Irozuku

https://www.youtube.com/watch?v=sVU5EYriNw4

Run `rbs prototype runtime --help` to see options and usage:

```sh
rbs prototype runtime -R lib/irozuku Irozuku Irozuku::IrozukuError > sig/irozuku.rbs
rbs prototype runtime -R lib/irozuku/cli.rb Irozuku::CLI > sig/irozuku/cli.rbs
rbs prototype runtime -R lib/irozuku/constants.rb Irozuku::Constants > sig/irozuku/constants.rbs
rbs prototype runtime -R lib/irozuku/utils.rb Irozuku::Utils > sig/irozuku/utils.rbs
rbs prototype runtime -R lib/irozuku/validation.rb Irozuku::Validation Irozuku::Validation::ValidationError > sig/irozuku/validation.rbs
```
