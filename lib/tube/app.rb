# frozen_string_literal: true

require_relative 'app/base'
require_relative 'app/shows'

module Tube
  # :nodoc:
  module App
    class Command < Tube::App::BaseCommand
      subcommand 'shows', 'list current shows', Tube::App::ShowsCommand
    end
  end
end
