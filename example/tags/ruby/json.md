<gtags rubyZZ json>

<tags read load parse>

 ## Parse JSON
```ruby
require "json"
data_hash = JSON.parse(string)
```

</tags>

<tags read load parse sym symbolize>

 ## Parse JSON with symbolize names
```ruby
require "json"
data_hash = JSON.parse(string, symbolize_names: true)
```

</tags>

<tags fs parse load read>

 ## Parse a JSON file
```ruby
require "json"
data_hash = JSON.parse(File.read("./file-name-to-be-read.json"))
```

</tags>

<tags serialize dump stringify>

 ## Serialize ruby object
```ruby
require "json"
str = JSON.dump(data_hash)
```

</tags>

<tags serialize dump stringify format pretty>

 ## Serialize ruby object with a nice format !
```ruby
require "json"
str = JSON.pretty_generate(data_hash)
```

</tags>

<tags fs serialize dump stringify>

## Serialize a ruby object into a file
```ruby
require "json"
File.write('./sample-data.json', JSON.dump(data_hash))
```

</tags>

</gtags>