# frozen_string_literal: true

require 'httparty'
module Snackhack2
  class GoogleAnalytics
    attr_reader :site

    def initialize(site)
      @site = site
    end

    def run
      a = HTTParty.get(@site).body
      case a
      when /UA-\d{8}-\d/
        puts a.match(/UA-\d{8}-\d/)
      when /GTM-[A-Z0-9]{7}/
        puts a.match(/GTM-[A-Z0-9]{7}/)
      when /G-([0-9]+([A-Za-z]+[0-9]+)+)/
        puts a.match(/G-([0-9]+([A-Za-z]+[0-9]+)+)/)
      when /G-[A-Za-z0-9]+/
        puts a.match(/G-[A-Za-z0-9]+/)
      else
        puts '[+] No Google Analytics found :('
      end
    end
  end
end
