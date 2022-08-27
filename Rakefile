# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

desc 'Build documentation.'
task :doc do
  system 'rdoc lib/tube.rb'
end

desc 'Run rspec tests.'
task :test do
  system 'rspec'
end

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

desc "Run tasks 'test' and 'rubocop' by default."
task default: %w[test rubocop]
