# frozen_string_literal: true

require 'socket'
module Snackhack2
  class BannerGrabber
    attr_accessor :site, :save_file

    def initialize(site, port: 443, save_file: true)
      @site    = site
      @port    = port
      @headers = Snackhack2::get(@site).headers
      @save_file = save_file
    end

    def site
      @site.gsub('https://', '')
    end

    def run
      nginx
      apache2
      wordpress
    end

    def nginx
      if @headers['server'].match(/nginx/)
        puts "[+] Server is running NGINX... Now checking if #{File.join(@site, "nginx_status")} is valid..."
        nginx = Snackhack2::get(File.join(@site, "nginx_status"))
        if nginx.code == 200
          puts "Check #{@site}/nginx_status"
        else
          puts "Response code: #{nginx.code}"
        end
      end
    end

    def curl
      servers = ''
      cmd = `curl -s -I #{@site.gsub('https://', '')}`
      version = cmd.split('Server: ')[1].split("\n")[0].strip
      if @save_file
        servers += version.to_s
      else
        puts "Banner: #{cmd.split('Server: ')[1].split("\n")[0]}"
      end
      Snackhack2::file_save(@site, "serverversion", servers) if @save_file
    end

    def apache2
      if @headers['server'].match(/Apache/)
        puts "[+] Server is running APACHE2... Now checking #{File.join(@site, "server-status")}..."
        apache = Snackhack2::get(File.join(@site, "server-status"))
        if apache.code == 200
          puts "Check #{@site}/server-status"
        else
          puts "Response Code: #{apache.code}"
        end
      else
        puts "Apache2 is not found..."
      end
    end

    def wordpress
      wp = Snackhack2::get(@site).body
      return unless wp.match(/wp-content/)

      puts '[+] Wordpress found [+]'
    end

    def headers
      @headers.to_a
    end

    def server
      @headers['server']
    end

    attr_reader :site
  end
end
