# frozen_string_literal: true

require 'httparty'
module Snackhack2
  class GoogleAnalytics
    attr_accessor :site

    def initialize(print_status: false)
      @site = site
    end

    def run
      # uses a handful of different regexs to extract the Google Analytics
      # code from sites. This is used by the site admin to track and mesaure 
      # people who visit the site. This could be used to find more sites 
      # they own where they re-use the code.
      gas = []
      a = Snackhack2.get(@site).body
      case a
      when /UA-\d{8}-\d/
        gas << a.match(/UA-\d{8}-\d/).to_s
      when /GTM-[A-Z0-9]{7}/
        gas <<  a.match(/GTM-[A-Z0-9]{7}/).to_s
      when /G-([0-9]+([A-Za-z]+[0-9]+)+)/
        gas << a.match(/G-([0-9]+([A-Za-z]+[0-9]+)+)/).to_s
      when /G-[A-Za-z0-9]+/
        gas << a.match(/G-[A-Za-z0-9]+/).to_s
      when /GT-[A-Za-z0-9]+/
        gas << a.match(/GT-[A-Za-z0-9]+/).to_s
      else
        puts '[+] No Google Analytics found :('
      end
      if @print_status
        gas.each do |g|
          puts g
        end
      else 
        return gas
      end
    end
  end
end
