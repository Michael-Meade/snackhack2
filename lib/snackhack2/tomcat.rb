# frozen_string_literal: true

require 'nokogiri'
module Snackhack2
  class TomCat
    def initialize(site)
      @site = site
    end

    def run
      # adds `/docs/` to the instance variable @site
      tc = Snackhack2.get(File.join(@site, '/docs/'))
      # if the site returns `400` status code it will check if the
      # word `Tomcat` is found in the body of the page
      if tc.code == 404
        if tc.body.include?('Tomcat')
          doc = Nokogiri::HTML(tc.body)
          # it will then extract the version displayed if
          # the word is found
          version = doc.at('h3').text
          puts "[+] Looks like the site is Tomcat, running #{version}."
        end
      else
        puts "[+] Status code: #{tc.code}"
      end
    end
  end
end
