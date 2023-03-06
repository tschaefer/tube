# frozen_string_literal: true

require 'clamp'
require 'pastel'

require_relative '../../tube'
require_relative '../../tube/version'

module Tube
  module App
    # :nodoc:
    class BaseCommand < Clamp::Command
      option ['-m', '--man'], :flag, 'show manpage' do
        manpage = <<~MANPAGE
          Name:
              tube

          #{help}
          Description:
            Show what to gawk on the (german) tube, currently. The info is gathered
            from the RSS feeds of https://www.texxas.de and categorized as following.

              * alternative
              * kids
              * main
              * news
              * regional
              * sports

          Authors:
              Tobias Schäfer <github@blackox.org>

          Copyright and License
              This software is copyright (c) 2022 by Tobias Schäfer.

              This package is free software; you can redistribute it and/or modify it under the terms of the "GPLv3.0 License".
        MANPAGE
        TTY::Pager.page(manpage)

        exit 0
      end

      option ['-v', '--version'], :flag, 'show version' do
        puts "tube #{tube::VERSION}"
        exit(0)
      end

      def tube(categories:, scheduled:)
        Tube.watch(categories:, scheduled:)
      rescue StandardError => e
        bailout(e)
      end

      def bailout(error)
        puts Pastel.new.red.bold(error.cause || error.message)
        exit(1)
      end
    end
  end
end
