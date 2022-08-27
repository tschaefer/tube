# frozen_string_literal: true

require 'tty-pager'

require_relative 'base'

module Tube
  module App
    # :nococ:
    class ShowsCommand < Tube::App::BaseCommand
      option '--[no-]legend', :flag, 'do not print a legend.', default: true
      option '--[no-]pager', :flag, 'do not pipe output into a pager.', default: true
      option '--category', 'CATEGORY', 'channel category (main, sports, regional, alternative)', multivalued: true

      def execute
        tube = tube(category_list)

        legend = legend? ? "\n\n#{tube.shows.size} shows listed.\n" : "\n"
        table = tube.to_table
        content = "#{table}#{legend}"
        TTY::Pager.new(enabled: pager?).page(content)
      end
    end
  end
end
