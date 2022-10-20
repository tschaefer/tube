# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

desc 'Build documentation.'
task :doc do
  system 'rdoc lib/tube.rb'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Start a console session with Tube loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'tube'

  ARGV.clear
  IRB.start
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

desc "Run tasks 'spec' and 'rubocop' by default."
task default: %w[spec rubocop]
