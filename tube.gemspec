# frozen_string_literal: true

$LOAD_PATH << File.expand_path('lib', __dir__)
require 'tube/version'

Gem::Specification.new do |spec|
  spec.name        = 'tube'
  spec.version     = Tube::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Tobias Schäfer']
  spec.email       = ['github@blackox.org']

  spec.summary     = 'What to gawk on the tube?!'
  spec.description = <<~DESC
    #{spec.summary}
  DESC
  spec.homepage    = 'https://github.com/tschaefer/tube'
  spec.license     = 'MIT'

  spec.files                 = Dir['lib/**/*']
  spec.bindir                = 'bin'
  spec.executables           = ['tube']
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.1'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['source_code_uri']       = 'https://github.com/tschaefer/tube'
  spec.metadata['bug_tracker_uri']       = 'https://github.com/tschaefer/tube/issues'
end
