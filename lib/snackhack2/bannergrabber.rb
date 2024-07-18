# frozen_string_literal: true

require 'httparty'
require 'socket'
module Snackhack2
  class BannerGrabber
    attr_accessor :site, :save_file

    def initialize(site, port: 443, save_file: true)
      @site    = site
      @port    = port
      @headers = HTTParty.get(site).headers
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
      return if @headers['server'].nil?
      return unless @headers['server'].match(/nginx/)

      nginx = HTTParty.get("#{@site}/nginx_status")
      if nginx.code == 200
        puts "Check #{@site}/nginx_status"
      else
        puts "Response code: #{nginx.code}"
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
      File.open("#{@site.gsub('https://', '')}_serverversion.txt", 'w+') { |file| file.write(servers) }
    end

    def apache2
      return if @headers['server'].nil?
      return unless @headers['server'].match(/Apache/)

      apache = HTTParty.get("#{@site}/server-status")
      if apache.code == 200
        puts "Check #{@site}/server-status"
      else
        puts "Response Code: #{apache.code}"
      end
    end

    def wordpress
      wp = HTTParty.get(@site.to_s).body
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
