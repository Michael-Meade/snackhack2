# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
module Snackhack2
  class WebsiteLinks
    attr_accessor :save_file

    def initialize(site, save_file: true)
      @site = site
      @save_file = save_file
    end

    def run
      doc = Nokogiri::HTML(URI.open(@site))
      links = doc.xpath('//a')
      all_links = links.map { |e| e['href'] }.compact
      content = all_links.uniq.join("\n")
      if @save_file
        Snackhack2::file_save(@site, "links", content)
      else
        all_links.each do |links|
          puts links
        end
      end
    end
  end
end
