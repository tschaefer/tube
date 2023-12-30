# frozen_string_literal: true

require 'json'
require 'nokogiri'
require 'faraday'
require 'tty-table'
require 'time'

##
# Show what to gawk on the (german) tube, currently. The info is gathered from
# the RSS feeds of https://www.texxas.de.
#
module Tube
  class << self
    # :nodoc:
    Show = Struct.new('Show', :channel, :title, :started)
    # :doc:

    ##
    # List of shows represented by simple struct.
    #
    # * channel
    # * title
    # * started
    #
    attr_reader :shows

    ##
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
    # and scheduled following:
    #
    # * now, default
    # * prime
    #
    #   tube = Tube.watch('main')
    def watch(categories: [], scheduled: 'now')
      @shows = build_shows(categories.map(&:downcase), scheduled.downcase)

      self
    end

    ##
    # Return shows schedule in wanted format.
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

    ##
    # Return shows schedule as JSON.
    def to_json(_obj = nil)
      hash = {}
      shows.each do |show|
        hash[show.channel] = { show: show.title, started: show.started }
      end
      hash.to_json
    end

    ##
    # Return shows schedule as table.
    def to_table # rubocop:disable Metrics/AbcSize
      headers = %w[CHANNEL SHOW STARTED]
      rows = @shows.map do |show|
        title = show.title.length >= 40 ? "#{show.title[0..37]}..." : show.title
        [show.channel, title, show.started.strftime('%R')]
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

    def build_shows(categories, scheduled)
      feeds = get_scheduled_feeds(scheduled)
      urls  = get_feed_urls_by_categories(feeds, categories)

      shows = []
      urls.each do |url|
        shows += get_shows_info(url, scheduled)
      end

      shows
    end

    def get_shows_info(url, scheduled)
      rss  = Faraday.get(url).body
      feed = Nokogiri::XML(rss)

      shows = []
      feed.xpath('//item').each do |item|
        shows << Show.new(
          item.xpath('dc:subject').text,
          item.xpath('title').text.gsub(/^.+: /, ''),
          determine_show_start_time(item, scheduled)
        )
      end

      shows
    end

    def determine_show_start_time(item, scheduled)
      Time.parse(
        case scheduled
        when 'prime'
          item.xpath('description').text.match(/\d{2}\.\d{2}\.\d{4} (\d{2}:\d{2})/)
          ::Regexp.last_match(1)
        when 'now'
          item.xpath('dc:date').text.gsub(/:\d+Z$/, '')
        end
      )
    end

    def get_scheduled_feeds(scheduled)
      file = "#{File.dirname(__FILE__)}/tube/#{scheduled}.json"
      raise ArgumentError, "Unknown scheduled '#{scheduled}'" if !File.exist?(file)

      JSON.parse(File.read(file))
    end

    def get_feed_urls_by_categories(feeds, categories)
      return feeds.values if categories.empty?

      categories.map do |category|
        feeds[category] || (raise ArgumentError, "Unknown category '#{category}'")
      end
    end
  end
end
