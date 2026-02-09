# frozen_string_literal: true

require 'socket'
require 'colorize'

module Snackhack2
  class IpLookup
    attr_accessor :site

    def initialize(site, file_save: false)
      @file_save = file_save
      # Clean the URL immediately to avoid repeating .gsub everywhere
      @site = site.gsub(%r{https?://}, '').split('/').first
    end

    def run
      # Running all methods and displaying results
      puts "Methods for: #{@site}".bold.blue
      puts "Ping:   #{get_ip.join(', ')}"
      puts "NS:     #{nslookup.is_a?(Array) ? nslookup.join(', ') : 'Saved to file'}"
      puts "Socket: #{socket_lookup}"
    end

    def get_ip
      # Uses ping command to get IP of the host
      ips = []
      output = `ping -c 2 #{@site}`
      # Using scan to find all IP-like patterns
      output.scan(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/).each do |match|
        ip = match.first
        ips << ip unless ips.include?(ip)
      end
      ips
    end

    def nslookup
      # Uses the nslookup command to extract the IP
      output = `nslookup #{@site}`
      # Simplified extraction using regex for "Address: [IP]"
      ips = output.scan(/Address: (\d{1,3}(?:\.\d{1,3}){3})/).flatten.uniq

      if @file_save
        # Note: Ensure Snackhack2.file_save is defined in your main module
        Snackhack2.file_save(@site, 'ip_lookup', ips.join("\n"))
      else
        ips
      end
    end

    def socket_lookup
      IPSocket.getaddress(@site)
    rescue SocketError
      "Could not resolve"
    end
  end
end