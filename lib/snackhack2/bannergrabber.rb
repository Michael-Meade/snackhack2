require 'httparty'
require 'socket'
module Snackhack2
  class BannerGrabber
    attr_accessor :site
    def initialize(site, port: 443)
      @site    = site
      @port    = port
      @headers = HTTParty.get(site).headers
    end
    def run
      nginx
      apache2
      wordpress
    end
    def nginx
      if !@headers["server"].nil?
        if @headers["server"].match(/nginx/)
            nginx = HTTParty.get("#{@site}/nginx_status")
            if nginx.code == 200
              puts "Check #{@site}/nginx_status"
            else
              puts "Response code: #{nginx.code}"
            end 
        end
      end
    end
    def curl
      cmd = `curl -s -I #{@site.gsub("https://", "")}`
      puts "Banner: " +  cmd.split("Server: ")[1].split("\n")[0]
    end
    def apache2
      if !@headers["server"].nil?
        if @headers["server"].match(/Apache/)
          apache = HTTParty.get("#{@site}/server-status")
          if apache.code == 200
            puts "Check #{@site}/server-status"
          else
            puts "Response Code: #{apache.code}"
          end
        end
      end
    end
    def wordpress
      wp = HTTParty.get("#{@site}").body
      if wp.match(/wp-content/)
        puts "[+] Wordpress found [+]"
      end
    end
    def headers
      @headers.to_a
    end
    def server
      @headers["server"]
    end
    def site
      @site
    end
  end
end