# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
module Snackhack2
  class WebsiteMeta
    def initialize(site)
      @site = site
    end

    def run
      doc = Nokogiri::HTML(URI.open(@site))
      posts = doc.xpath('//meta')
      posts.each do |link|
        puts "#{link.attributes['name']}: #{link.attributes['content']}" unless link.attributes['name'].nil?
      end
    end
  end
end
