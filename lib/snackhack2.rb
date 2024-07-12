# frozen_string_literal: true
require 'uri'
require_relative 'snackhack2/version'
require_relative 'snackhack2/bannergrabber'
require_relative 'snackhack2/wordpress'
require_relative 'snackhack2/portscan'
require_relative 'snackhack2/iplookup'
require_relative 'snackhack2/robots'
require_relative 'snackhack2/subdomains'
require_relative 'snackhack2/sshbrute'
require_relative 'snackhack2/website_meta'
require_relative 'snackhack2/google_analytics'
require_relative 'snackhack2/cryptoextractor'
require_relative 'snackhack2/website_links'
module Snackhack2
  class Main
    def initialize(site)
      @site = site
    end
    def banner_grabber
      s = Snackhack2::BannerGrabber.new(@site)
      s.run
      s.curl
    end
    def subdomain
      sd = Snackhack2::Subdomains.new(@site)
      sd.run
    end
    def website_meta
      wm = Snackhack2::WebsiteMeta.new(@site)
      wm.run
    end
  end
end
