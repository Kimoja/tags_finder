# frozen_string_literal: true

require_relative 'lib/tags_finder'

Gem::Specification.new do |spec|
  spec.name        = 'tags_finder'
  spec.version     = TagsFinder::VERSION
  spec.summary     = 'Search for text content by tag in the local file system'
  spec.authors     = ['Joakim Carrilho']
  spec.email       = 'joakim.carrilho@yahoo.fr'
  spec.files       = ['lib/tags_finder.rb']
  spec.homepage    = ''
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.1.1'

  spec.add_dependency 'string-similarity', '~> 2.1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
