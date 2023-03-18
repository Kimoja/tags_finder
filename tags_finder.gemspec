# frozen_string_literal: true

require_relative 'lib/tags_finder/version'

Gem::Specification.new do |spec|
  spec.name        = 'tags_finder'
  spec.version     = TagsFinder::VERSION
  spec.summary     = 'Search for text content by tag in the local file system'
  spec.authors     = ['Joakim Carrilho']
  spec.email       = 'joakim.carrilho@yahoo.fr'
  spec.files       = Dir['lib/**/*.rb']
  spec.homepage    = 'https://github.com/Kimoja/tags_finder'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.1.1'

  spec.add_dependency 'string-similarity', '~> 2.1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
