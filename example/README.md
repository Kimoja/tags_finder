# Example 

Example of basic command line use.

Run `bundle install` before 

Usage: 
```bash
# BUNDLE_GEMFILE=[THE GEMFILE PATH OF THE EXAMPLE] [PATH OF THE BIN] [search_tag1 search_tags]
# In my local machine, launch in path `/Users/me/dev/tools/toolbox/gems/tags_finder`: 
BUNDLE_GEMFILE=/Users/kimoja/dev/tools/toolbox/gems/tags_finder/example/Gemfile ./tags_finder/example/example ruby json
```

You can easily create a zsh function or other, for example for zsh:

```zsh
tag() {
  BUNDLE_GEMFILE=/Users/kimoja/dev/tools/toolbox/gems/tags_finder/example/Gemfile /Users/kimoja/dev/tools/toolbox/gems/tags_finder/example/example "$@"
}
export "tag"
```

And in use

```bash
tag ruby json
```


