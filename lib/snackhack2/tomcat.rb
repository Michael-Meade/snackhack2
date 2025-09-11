# frozen_string_literal: true

require 'nokogiri'
module Snackhack2
  class TomCat
    def initialize(site)
      @site = site
    end

    def run
      tc = Snackhack2.get(File.join(@site, '/docs/'))
      if tc.code == 404
        if tc.body.include?('Tomcat')
          doc = Nokogiri::HTML(tc.body)
          version = doc.at('h3').text
          puts "[+] Looks like the site is Tomcat, running #{version}."
        end
      else
        puts "[+] Status code: #{tc.code}"
      end
    end
  end
end
