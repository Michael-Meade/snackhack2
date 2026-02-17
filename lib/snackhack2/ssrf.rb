# frozen_string_literal: true

# Process.spawn("ruby -run -ehttpd . -p8008")
# sleep 10
require 'typhoeus'
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
    def http_port_scan(port_count: 8082)
      # save the found ports in an array.
      hydra = Typhoeus::Hydra.new
      i = 0
      found_ports = []
      65530.times.each_with_index.map{ |i|
        request = Typhoeus::Request.new("http://127.0.0.1:10/?url=#{i}", followlocation: true)
        t = hydra.queue(request)
        request.on_complete do |response|
          if response.code.to_i.eql?(200)
            puts i
            puts "#{response.code}"
            found_ports << i
          end
        end
        #i+=1
      }
      hydra.run
      p found_ports
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
