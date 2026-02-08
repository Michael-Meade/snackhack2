# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
module Snackhack2
  class WebsiteLinks
    attr_accessor :save_file, :site

    def initialize(save_file: true)
      @site = site
      @save_file = save_file
    end

    def run
      # uses nokogiri to get the source of the page
      doc = Nokogiri::HTML(URI.open(@site))
      # uses the xpath to get all the links on the source code
      links = doc.xpath('//a')
      # gets the links
      all_links = links.map { |e| e['href'] }.compact
      # remove any duplicates
      content = all_links.uniq.join("\n")   
      if @save_file
        Snackhack2.file_save(@site, 'links', content)
      else
        all_links.each do |links|
          puts links
        end
      end
    end
  end
end
