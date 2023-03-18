# TagsFinder 

## Description

TagsFinder is a rudimentary tool for searching from local file system for text fragments from their tags.

It is primarily intended for the developer who wants to maintain a set of resources/documentation/tips and be able to find them easily.

The comparison between the tags of the elements and the searched tags is done with the [cosine algorithm](https://en.wikipedia.org/wiki/Cosine_similarity#:~:targetText=Cosine%20similarity%20is%20a%20measure,(0%2C%CF%80%5D%20radians), implemented in the [string-similarity library](https://github.com/mhutter/string-similarity)

The search is parallelized and uses by default all the processors of the machine.

The tool only integrates the minimum to search for text extracts.
The integration in a command line tool will be done manually, see example [FIXME link].

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add tags_finder

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install tags_finder

## Usage

### API 

TagsFinder offers several search and retrieval options, passed at instance initialization, here they are:
- `search_tags`: The tags to search
- `search_globs`: The global paths to search
- `result_size`: Number of results to extract per page
- `parallelism`: Number of processors used for the search, by default the number of processors of the machine
- `html_tags`: An object specifying html tags names to use, default `{ tags: 'tags', gtags: 'gtags' }`

Once the `TagsFinder` object is created, the `find` instance method is used to start the search.
The method accepts a block with an array of `TagsFinder::Result` as argument, here are its properties/methods:
- `path`: The path of the file
- start_line: The line number of the opening `tags` tag
- `end_line`: The line number of the closing `tags` tag
- `tags`: The tags of the `tags` tag
- `search_tags`: The searched tags
- `score`: The score of the search for this `tags` element
- `extract`: Extracts the text contained in the `tags` tag

#### Example 

```ruby
tags_finder = TagsFinder.new(
  search_tags: search_tags, 
  search_globs: ["./tags/**/*"], 
  result_size: 10
)
tags_finder.find do |results_slice|
  puts results_slice.flat_map do |result|
    <<~TEXT
      # Result Tags: #{result.tags * " "}
      - score: #{result.score}
      - Path: #{result.path}:#{result.start_line}`
      #{result.extract}
      ---------------
    TEXT
  end * "\n\n"
end
```

### Tags definition

The definition of tags is based on an HTML-like markup system.

Three levels of tags or pseudo tags:
- `<tags tag1 tag2>[TEXT]</tags>`: Allows to define a list of tags in attribute for the nested text
- `<gtags tag1 tag2>[OTHER TAGS]</gtags>`: Allows to group `gtags` or `tags` elements. Child elements will inherit the list of tags defined in attributes
- The names directories and files where a tag is located. `gtags` and `tags` elements of the file will have the tag attributes inherited from these "path tags"

#### Example 

```md
<gtags shell bash fs>
  <tags file write push>

  ## Write a line at the end of a file
  `echo "text" >> mon_fichier.text`
  </tags>
  <tags dir create mkdir>

  ## Create one or more folders, without error if existing (-p)
  `mkdir -p mon_fichier`
  </tags>
</gtags>
```

## Note

This project was not originally intended to be shared, but is a result of a request from a colleague.

I don't plan to evolve it.

You are still invited to open issues if necessary, or the fork to adapt it to your needs!