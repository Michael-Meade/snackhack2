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
      hostname = URI.parse(@site).host
      doc = Nokogiri::HTML(URI.open(@site))
      links = doc.xpath('//a')
      all_links = links.map { |e| e['href'] }.compact
      if @save_file
        File.open("#{hostname}_links.txt", 'w+') { |file| file.write(all_links.uniq.join("\n")) }
      else
        all_links.each do |links|
          puts links
        end
      end
    end
  end
end
