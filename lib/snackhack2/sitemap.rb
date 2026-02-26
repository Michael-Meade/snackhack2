# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
module Snackhack2
  class SiteMap
    attr_accessor :site
    def initialize
      @site = site
    end

    def run
      # adds `sitemap.xml` to the site given 
      # defined in `@site` instance variable.
      sm = Snackhack2.get(File.join(@site, 'sitemap.xml'))
      # site returns 200 status code
      if sm.code.to_i.eql?(200)
        # checks the body of the page to detetmine if the words
        # `Not Found` is it
        unless sm.body.include?('Not Found')
          # the page did not include "Not Found". Saving the contents of the sitemap.xml 
          # to a file.
          Snackhack2.file_save(@site, 'site.xml', sm.body)
        else
          puts "[+] Eh. I don't think the site has a sitemap. Manually check just in case... :(\n\n"
        end
      else
        puts "[+] Status Code: #{sm.code}"
      end
    end
  end
end
