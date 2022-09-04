# frozen_string_literal: true

require 'json'
require 'nokogiri'
require 'open-uri'
require 'tty-table'

##
# Show what to gawk on the (german) tube, currently. The info is gathered from
# the RSS feeds of https://www.texxas.de.
#
module Tube
  class << self
    # :nodoc:
    Show = Struct.new('Show', :channel, :title, :started)
    # :doc:

    # List of shows represented by simple struct.
    #
    # * channel
    # * title
    # * started
    #
    attr_reader :shows

    # Create new object with list of shows of **all** channels or categorized
    # following:
    #
    # * alternative
    # * kids
    # * main
    # * news
    # * regional
    # * sports
    #
    # Optional customized feeds file can be provided.
    #
    #   tube = Tube.watch('main')
    def watch(categories = [], file = nil)
      file ||= "#{File.dirname(__FILE__)}/tube/feeds.json"
      feeds = JSON.parse(File.read(file))

      urls = categories.map do |category|
        url = feeds[category]
        raise ArgumentError, "Unknown category '#{category}'" if !url

        url
      end
      urls = feeds.values if urls.empty?

      @shows = []
      urls.each do |url|
        @shows += build_shows(url)
      end

      self
    end

    # Return shows schedule in given format.
    #
    # * table
    # * json
    #
    def schedule(format = 'table')
      case format
      when 'table'
        to_table
      when 'json'
        to_json
      else
        raise ArgumentError, "Unknown format '#{format}'"
      end
    end

    # Return shows schedule as JSON.
    def to_json(_obj = nil)
      hash = {}
      shows.each do |show|
        hash[show.channel] = { show: show.title, started: show.started }
      end
      hash.to_json
    end

    # Return shows schedule as table.
    def to_table
      headers = %w[CHANNEL SHOW STARTED]
      rows = @shows.map do |show|
        [show.channel, show.title, show.started.strftime('%R')]
      end
      table = TTY::Table.new(headers, rows)

      rendered = table.render(multiline: true, width: 2**16) do |renderer|
        renderer.border do
          mid     '─'
          mid_mid '─'
          center  ' '
        end
      end
      rendered.gsub(/\s+$/, '')

      rendered
    end

    private

    def build_shows(url)
      URI.open(url) do |rss| # rubocop:disable Security/Open
        feed = Nokogiri::XML(rss)

        shows = []
        feed.xpath('//item').each do |item|
          shows << Show.new(
            item.xpath('dc:subject').text,
            item.xpath('title').text.gsub(/^.+: /, ''),
            DateTime.parse(item.xpath('dc:date').text.gsub(/:\d+Z$/, ''))
          )
        end

        return shows
      end
    end
  end
end
