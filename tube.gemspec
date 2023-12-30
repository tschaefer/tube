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

    Show what to gawk on the (german) tube, currently. The info is gathered
    from the RSS feeds of https://www.texxas.de and categorized as following.

      * alternative
      * kids
      * main
      * news
      * regional
      * sports
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

  spec.post_install_message = 'All your tube are belong to us!'

  spec.add_dependency 'clamp', '~> 1.3.2'
  spec.add_dependency 'faraday', '~> 2.8.1'
  spec.add_dependency 'nokogiri', '~> 1.16.0'
  spec.add_dependency 'tty-table', '~> 0.12.0'
end
