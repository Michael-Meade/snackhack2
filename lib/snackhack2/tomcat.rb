# frozen_string_literal: true

require 'nokogiri'
module Snackhack2
  class TomCat
    attr_accessor :site
    def initialize
      @site = site
    end

    def run
      # adds `/docs/` to the instance variable @site
      tc = Snackhack2.get(@site)
      if tc.headers.has_key?("server")
        if tc.headers['server'].match?("Tomcat")
          puts "[+] Found Tomcat in the site's header... #{tc.headers['server']}\n\n\n"
          tc_body = Snackhack2.get(File.join(@site, '/docs/'))
          if tc_body.code.to_i.eql?(404)
            if tc_body.body.include?('Tomcat')
              doc = Nokogiri::HTML(tc.body)
              # it will then extract the version displayed if
              # the word is found
              begin
                # use to get the version
                version = doc.at('h3').text
                puts "[+] Looks like the site is Tomcat, running #{version}."
              rescue => e
                puts "ERROR: #{e}"
              end
            end
          end
        end
      end
    end
  end
end
