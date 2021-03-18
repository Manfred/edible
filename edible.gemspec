# frozen_string_literal: true

require File.expand_path('lib/edible/version', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'edible'
  spec.version = Edible::VERSION
  spec.authors = [
    'Manfred Stienstra'
  ]
  spec.email = [
    'manfred@fngtps.com'
  ]
  spec.summary = <<-SUMMARY
  Parser and builder for EDIFACT data.
  SUMMARY
  spec.description = <<-DESCRIPTION
  Edible providers a parser and builder for loading and generating EDIFACT data. It does not support
  any specific message formats.
  DESCRIPTION
  spec.homepage = 'https://github.com/Manfred/edible'
  spec.license = 'MIT'

  spec.files = Dir.glob('lib/**/*') + [
    'LICENSE.txt',
    'README.md'
  ]
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.6'

  spec.add_development_dependency 'minitest', '>= 5'
  spec.add_development_dependency 'rake', '~> 12'
end
