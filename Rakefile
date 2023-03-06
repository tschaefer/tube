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

  def silent
    original_stdout = $stdout.clone
    original_stderr = $stderr.clone
    $stderr.reopen File.new(File::NULL, 'w')
    $stdout.reopen File.new(File::NULL, 'w')
    yield
  ensure
    $stdout.reopen original_stdout
    $stderr.reopen original_stderr
  end

  def reload!(print: true)
    puts 'Reloading...' if print
    root_dir = File.expand_path(__dir__)
    reload_dirs = %w[lib]
    reload_dirs.each do |dir|
      Dir.glob("#{root_dir}/#{dir}/**/*.rb").each { |f| silent { load(f) } }
    end

    true
  end

  IRB.start
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

desc "Run tasks 'spec' and 'rubocop' by default."
task default: %w[spec rubocop]
