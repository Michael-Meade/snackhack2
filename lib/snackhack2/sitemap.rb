require 'httparty'
require 'nokogiri'
module Snackhack2
  class SiteMap
    def initialize(site)
      @site = site
    end

    def run
      sm = Snackhack2::get(File.join(@site, "sitemap.xml"))
      if sm.code == 200
        if !sm.body.include?("Not Found")
          Snackhack2::file_save(@site, "site.xml", sm.body)
        else
          puts "[+] Eh. I don't think the site has a sitemap. Manually check just in case... :(\n\n"
        end
      else
        puts "[+] Status Code: #{sm.code}"
      end
    end
  end
end
